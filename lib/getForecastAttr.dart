


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

String getTemp(Map<int, dynamic>? hourlyForecast, int time) {
  if (hourlyForecast == null) {
    return "-°C";
  }
  return "${hourlyForecast[time]["temperature"].round()}°";
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

String getWindSpeed(Map<int, dynamic>? hourlyForecast) {
  if (hourlyForecast == null) {
    return "- mph";
  }
  return "${hourlyForecast[getCurrentHour()]["wind_speed"]} mph";
}

String getSunrise(Map<int, dynamic>? hourlyForecast) {
  if (hourlyForecast == null) {
    return "--:--";
  }
  return hourlyForecast[23]["sunrise"].substring(0, 5);
}

String getSunset(Map<int, dynamic>? hourlyForecast) {
  if (hourlyForecast == null) {
    return "--:--";
  }
  return hourlyForecast[23]["sunset"].substring(0, 5);
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