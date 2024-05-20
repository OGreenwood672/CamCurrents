

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';


void loadCSV(String path) async {
  final rawData = await rootBundle.loadString(path);
  List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
  print(listData[0]);
}