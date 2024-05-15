import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


//* Get Hourly Forecast of Day by Date
Future<List<dynamic>> fetchForecast(String date) async {
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

Future<List<dynamic>> fetchForecastDate(DateTime date) async {
  return fetchForecast(DateFormat('yyyy-MM-dd').format(date));

}

// Day -> Time -> Weather type -> Value
// Day: Day of weather, today=0, tomorrow=1 ...
// Time: integer between 0 and 23
// Weather type: name of data, e.g. "temperature"
//    - "temperature"
//    - "temperature_feels_like"
//    - "visibility"
//    - "cloud_cover"
//    - "flag"
//    - "wind_direction"
//    - "wind_speed"
//    - "humidity"
// Value: value of weather type, e.g. "11.6"
Future<Map<int, dynamic>> getForcast() async {

  Map<int, dynamic> weather = {};


  for (int i=0; i < 5; i++){
    DateTime date = DateTime.now().add(Duration(days: i));

    var jsonHourlyForecast = await fetchForecastDate(date);

    Map<int, Map<String, dynamic>> hourlyForecast= {};

    for (final Map<String, dynamic> line in jsonHourlyForecast){
      Map<String, dynamic> entry = line;
      var time = entry["time"].toString().substring(0, 2);
      var inttime = int.parse(time);
      hourlyForecast[inttime] = entry;
    }

    Map<String, dynamic> forecast = {
      "day": getDayName(date),
      "hourly_forecast": hourlyForecast
    };

    weather[i] = forecast;

  }
  return weather;

}


String getDayName(DateTime date) {
  final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  return days[date.weekday - 1];
}