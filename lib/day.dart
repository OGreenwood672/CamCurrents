import 'package:camcurrents/ExtraDetails/sun.dart';
import 'package:camcurrents/ExtraDetails/uv.dart';
import 'package:camcurrents/ExtraDetails/wind.dart';
import 'package:camcurrents/ExtraDetails/waterlevel.dart';
import 'package:camcurrents/fetchForecast.dart';
import 'package:camcurrents/getForecastAttr.dart';
import 'package:camcurrents/navigation.dart';
import 'package:camcurrents/weathertable.dart';

import 'package:flutter/material.dart';

class Day extends StatefulWidget {
  final int day;
  final Map<int, dynamic>? weatherData;

  const Day({super.key, required this.weatherData, required this.day});

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {

  double dayIconSize = 40;

  bool isFetching = false;

  Map<int, dynamic>? _weatherData;

  static const int numberDaysShown = 5;
  final int realDay;

  _DayState() : realDay = (DateTime.now().weekday - 1);

  @override
  void initState() {
    super.initState();
    
    if (widget.weatherData == null) {
      Future<Map<int, dynamic>> futureForecast = getForcast();
      futureForecast.then((data) {
        setState(() {
          _weatherData = data;
        });
      });
    } else {
      _weatherData = widget.weatherData;
    }
  }

  String getDay(day) {
    const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    return days[(day+realDay)%7];
  }

  Map<int, dynamic>? getHourlyForecast(day) {

      if (_weatherData == null) {
        return null;
      }
      if (0 > day || day > 4) { return null; }
      return _weatherData?[day]["hourly_forecast"];
  }
  
  AssetImage chooseBg(){
    int currentHour = DateTime.now().hour;
    if (currentHour >=20 || currentHour <= 3){
      return AssetImage( 'assets/images/night_bg.png');
    } else {
      Map<int, dynamic>? hourlyForecast = getHourlyForecast(widget.day);
      if (hourlyForecast != null) {
        if (hourlyForecast[currentHour]["precipitation"]>=40 &&  hourlyForecast[currentHour]["precipitation"]<=70){
          return AssetImage('assets/images/rainy.gif');
        } else if (hourlyForecast[currentHour]["precipitation"]>70 && hourlyForecast[currentHour]["wind_speed"]>=25){
          return AssetImage('assets/images/stormy.gif');
        } else if (hourlyForecast[currentHour]["precipitation"]<40 && hourlyForecast[currentHour]["cloud_cover"]>=70){
          return AssetImage('assets/images/cloudy_bg.png');
        } else if (hourlyForecast[currentHour]["cloud_cover"]<70 && hourlyForecast[currentHour]["cloud_cover"]>=40 && hourlyForecast[currentHour]["temperature"]>=10 && hourlyForecast[currentHour]["temperature"]<20){
          return AssetImage('assets/images/sunWithClouds_bg.png');
        } else {
          return AssetImage('assets/images/sunny_bg.png');
        }
      } else {
        return AssetImage('assets/images/sunny_bg.png');
      }
    }
  }

  Widget buildNavigationDestination(int day) {
    return NavigationDestination(
      selectedIcon: ColorFiltered(
        colorFilter: const ColorFilter.mode(Color.fromARGB(255, 27, 106, 234), BlendMode.srcIn),
        child: Image.asset(
          'assets/icons/${getDay(day).toLowerCase()}.png',
          width: dayIconSize,
          height: dayIconSize,
        ),
      ),
      icon: Image.asset('assets/icons/${getDay(day).toLowerCase()}.png', width: dayIconSize, height: dayIconSize),
      label: "",
    );
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> destinations = [];
    for (int i=0; i<numberDaysShown; i++){
      destinations.add(buildNavigationDestination(i));
    }

    WeatherTable weatherTable = WeatherTable(hourlyForecast: getHourlyForecast(widget.day), day: widget.day);

    return Scaffold(
      appBar: null,
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0 && widget.day > 0) {
            Navigator.of(context).push(
              createRoute(Day(weatherData: _weatherData, day: widget.day - 1), const Offset(-1, 0))
            );
          } else if (details.primaryVelocity! < 0 && widget.day < numberDaysShown) {
            Navigator.of(context).push(
              createRoute(Day(weatherData: _weatherData, day: widget.day + 1), const Offset(1, 0))
            );
          }
        },
        child: SingleChildScrollView(
          child: Column( //Whole Page Column
            children: [
              Stack( // Top Page
                children: [
                  Container( //Background Top Page
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: chooseBg(),
                        fit: BoxFit.fill,
                      )
                    ),
      
                  ),
              
                  Column( // Top Page Content
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Top section
                      Container(
                        color: const Color.fromARGB(0, 0, 0, 0),
                        height: 100,
                      ),
                      Container(
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          getDay(widget.day),
                          style: const TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Container(
                        color: const Color.fromARGB(0, 0, 0, 0),
                        height: 300,
                      ),
                      weatherTable
                    ],
                  )
                ],
              ),

              Stack(
                children: [
                  Container( //Background Bottom Page
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/underwater_bg.png'),
                        fit: BoxFit.fill,
                      )
                    ),
      
                  ),
                  Container(
                      color: const Color.fromARGB(255, 0, 74, 126), // Set background color for additional weather conditions
                      //color: Colors.transparent,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: WindWidget(
                                    windspeed: getWindSpeed(getHourlyForecast(widget.day)),
                                    windDirection: getWindDirection(getHourlyForecast(widget.day)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15), // Space between the widgets
                              Expanded(
                                child: Center(
                                  child: WaterLvlWidget(waterLevel: getWaterLevel(getHourlyForecast(widget.day))),
                                ),
                              ),
                            ],
                          ), 
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: UVIndexWidget(uvIndex: getUVIndex(getHourlyForecast(widget.day))), // data to be changed to dynamic
                              ),
                              const SizedBox(width: 20), // Adjust spacing between widgets
                              Flexible(
                                child: SunsetTimeWidget(sunriseTime: getSunrise(getHourlyForecast(widget.day)), sunsetTime: getSunset(getHourlyForecast(widget.day))),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )
          )
      ),
    
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            Navigator.of(context).push(
              createRoute(Day(weatherData: _weatherData, day: index), const Offset(0, 1))
            );
          });
        },
        // indicatorColor: Colors.amber,
        selectedIndex: widget.day,
        destinations: destinations
      ),
    );
  }

}