


import 'package:intl/intl.dart';

int getCurrentHour() {
  DateTime currentTime = DateTime.now();
  return currentTime.hour;
}


String getPrecipitation(Map<int, dynamic>? hourlyForecast, int time) {
  if (hourlyForecast == null) {
    return "-%";
  }
  return "${hourlyForecast[time]["precipitation"].round()}%";
}

int getTemp(Map<int, dynamic>? hourlyForecast, int time) {
  if (hourlyForecast == null) {
    return 0;
  }
  return hourlyForecast[time]["temperature"].round();
}

String getWindDirection(Map<int, dynamic>? hourlyForecast) {
  if (hourlyForecast == null) {
    return "NORTH";
  }
  double windDirection = hourlyForecast[getCurrentHour()]["wind_direction"];

  if (windDirection < 22.5 || windDirection > 337.5) { return "North"; }
  else if (windDirection <= 67.5) { return "North-East"; }
  else if (windDirection <= 112.5) { return "East"; }
  else if (windDirection <= 157.5) { return "South-East"; }
  else if (windDirection <= 202.5) { return "South"; }
  else if (windDirection <= 247.5) { return "South-West"; }
  else if (windDirection <= 292.5) { return "West"; }
  else if (windDirection <= 337.5) { return "North-West"; }
  return "NORTH";
}

double getWindSpeed(Map<int, dynamic>? hourlyForecast, int time) {
  if (hourlyForecast == null) {
    return 0;
  }
  return hourlyForecast[time]["wind_speed"];
}

String getHumidity(Map<int, dynamic>? hourlyForecast) {
  if (hourlyForecast == null) {
    return "-%";
  }
  return "${hourlyForecast[getCurrentHour()]["humidity"].round()}%";
}

String getDateString(int day){
  DateTime date = DateTime.now().add(Duration(days: day));
  return DateFormat("yyyyMMdd").format(date);
}

String getSunrise(Map<String, Map<String, dynamic>>? lightingTimes, int day) {
  if (lightingTimes == null) {
    return "--:--";
  }
  
  String dateString = getDateString(day);
  return lightingTimes[dateString]?["Friendly_Down"];
}

String getSunset(Map<String, Map<String, dynamic>>? lightingTimes, int day) {
  if (lightingTimes == null) {
    return "--:--";
  }
  String dateString = getDateString(day);
  return lightingTimes[dateString]?["Friendly_Up"];
}

int getUVIndex(Map<int, dynamic>? hourlyForecast) {
  if (hourlyForecast == null) {
    return 0;
  }
  return hourlyForecast[getCurrentHour()]["uv_index"].round();
}

String getWaterLevel(Map<int, dynamic>? hourlyForecast) {
  if (hourlyForecast == null) {
    return "0m";
  }
  return "${hourlyForecast[23]["water_level"]}m";
}

String getFlag(Map<int, dynamic>? hourlyForecast) {
  if (hourlyForecast == null){
    return "grey";
  }
  return "${hourlyForecast[23]["flag"]}";
}

double getVisibility(Map<int, dynamic>? hourlyForecast){
  if (hourlyForecast == null){
    return 0;
  }
  return hourlyForecast[6]["visibility"];
}

String predictFlag(Map<int, dynamic>? hourlyForecast){
  if (hourlyForecast == null) {
    return "grey";
  }

  if (getWindSpeed(hourlyForecast, 6) >= 35 
  || (getWindSpeed(hourlyForecast, 6) >= 25 && getTemp(hourlyForecast, 6) < 0)
  //|| getVisibility(hourlyForecast) < 5 // This is not very accurate and doesn't play much of a role
  ){
    return "yellow";
  }

  return "green";
}