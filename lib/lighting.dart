

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';


Future<List<List>> _readCSV(String path) async {
  final rawData = await rootBundle.loadString(path);
  List<List<dynamic>> listData = const CsvToListConverter(
    eol: "\n", // Comment this out if you are getting a null error on "Lighting_up"
  ).convert(rawData);
  return listData;
}

Future<Map<String, Map<String, dynamic>>?> getLighting() async {
  List<List<dynamic>> listData = await _readCSV("assets/lightings.csv");
  Map<String, Map<String, dynamic>> result = {};
  
  for (List<dynamic> row in listData) {
    Map<String, dynamic> entry = {};
    for (int i=1; i<5; i++){
      entry[listData[0][i]] = row[i];
    }
    result[row[0].toString()] = entry;
  }
  if (result.isEmpty) {
    return null;
  }
  return result;
}

