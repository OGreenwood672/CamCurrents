import 'dart:convert';
import 'package:http/http.dart' as http;


//* Get Hourly Forecast of Day by Date
Future<List<dynamic>?> fetchForecast(String date) async {
  try {

    var resp = await http.get(Uri.parse('https://cam-currents-backend-ogreenwood672s-projects.vercel.app/get-data-by-date?date=$date'));

    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else {
      // ignore: avoid_print
      print('[ERROR] Error: ${resp.statusCode}');
    }
  } catch (e) {
    // ignore: avoid_print
    print('[ERROR]: $e');
    throw Error();
  }
  return [];
}