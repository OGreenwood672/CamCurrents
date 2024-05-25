import 'package:camcurrents/ExtraDetails/humidity.dart';
import 'package:camcurrents/ExtraDetails/sun.dart';
import 'package:camcurrents/ExtraDetails/uv.dart';
import 'package:camcurrents/ExtraDetails/wind_speed.dart';
import 'package:camcurrents/ExtraDetails/wind_direction.dart';
import 'package:camcurrents/ExtraDetails/waterlevel.dart';
import 'package:camcurrents/fetchForecast.dart';
import 'package:camcurrents/flag.dart';
import 'package:camcurrents/arrow.dart';
import 'package:camcurrents/getForecastAttr.dart';
import 'package:camcurrents/lighting.dart';
import 'package:camcurrents/navigation.dart';
import 'package:camcurrents/weathertable.dart';

import 'package:flutter/material.dart';

class Day extends StatefulWidget {
  final int day;
  final Map<int, dynamic>? weatherData;
  final Map<String, Map<String, dynamic>>? lightingTimes;

  const Day({super.key, required this.weatherData, required this.lightingTimes, required this.day});

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {

  double dayIconSize = 0.1;
  double flagSize = 0.23;
  double arrowSize = 0.17;

  late final ScrollController _controller;

  bool night = false;

  bool isFetching = false;

  Map<int, dynamic>? _weatherData;
  Map<String, Map<String, dynamic>>? _lightingTimes;

  static const int numberDaysShown = 5;
  final int realDay;

  _DayState() : realDay = (DateTime.now().weekday - 1);

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    
    if (widget.weatherData == null) {
      Future<Map<int, dynamic>?> futureForecast = getForcast();
      futureForecast.then((data) {
        try {
          setState(() {
            _weatherData = data;
          });
        } catch (e) {
          return;
        }
      });
    } else {
      _weatherData = widget.weatherData;
    }

    if (widget.lightingTimes == null){

      Future<Map<String, Map<String, dynamic>>?> futureLighting = getLighting();
      futureLighting.then((data) {
        try {
          setState(() {
            _lightingTimes = data;
          });
        } catch (e) {
          return;
        }
      });
    } else {
      _lightingTimes = widget.lightingTimes;
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
  
  AssetImage chooseBg() {
    int currentHour = DateTime.now().hour;
    if (currentHour >= 20 || currentHour <= 3){
      night = true;
      return const AssetImage('assets/images/night_bg.png');
    } else {
      Map<int, dynamic>? hourlyForecast = getHourlyForecast(widget.day);
      night = false;
      if (hourlyForecast != null) {
        if (hourlyForecast[currentHour]["precipitation"]>=40 &&  hourlyForecast[currentHour]["precipitation"]<=70){
          return const AssetImage('assets/images/rainy.gif');
        } else if (hourlyForecast[currentHour]["precipitation"]>70 && hourlyForecast[currentHour]["wind_speed"]>=25){
          return const AssetImage('assets/images/stormy.gif');
        } else if (hourlyForecast[currentHour]["precipitation"]<40 && hourlyForecast[currentHour]["cloud_cover"]>=70){
          return const AssetImage('assets/images/cloudy_bg.png');
        } else if (hourlyForecast[currentHour]["cloud_cover"]<70 && hourlyForecast[currentHour]["cloud_cover"]>=40 && hourlyForecast[currentHour]["temperature"]>=10 && hourlyForecast[currentHour]["temperature"]<20){
          return const AssetImage('assets/images/sunWithClouds_bg.png');
        } else {
          return const AssetImage('assets/images/sunny_bg.png');
        }
      } else {
        return const AssetImage('assets/images/sunny_bg.png');
      }
    }
  }

  void leftArrowPress () {
    if (widget.day > 0) {
      Navigator.of(context).pushReplacement(
        createRoute(Day(weatherData: _weatherData, lightingTimes: _lightingTimes, day: widget.day - 1), const Offset(-1, 0))
      );
    }
  }

  void rightArrowPress () {
    if (widget.day < numberDaysShown - 1) {
      Navigator.of(context).pushReplacement(
        createRoute(Day(weatherData: _weatherData, lightingTimes: _lightingTimes, day: widget.day + 1), const Offset(1, 0))
      );
    }
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 2000),
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget buildNavigationDestination(BuildContext context, int day) {
    return NavigationDestination(
      selectedIcon: ColorFiltered(
        colorFilter: const ColorFilter.mode(Color.fromARGB(255, 255, 255, 234), BlendMode.srcIn),
        child: Image.asset(
          'assets/icons/${getDay(day).toLowerCase()}.png',
          width: MediaQuery.of(context).size.width * dayIconSize,
          height: MediaQuery.of(context).size.width * dayIconSize,
        ),
      ),
      icon: Image.asset(
        'assets/icons/${getDay(day).toLowerCase()}.png',
        width: MediaQuery.of(context).size.width * dayIconSize,
        height: MediaQuery.of(context).size.width * dayIconSize
      ),
      label: "",
    );
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> destinations = [];
    for (int i=0; i<numberDaysShown; i++){
      destinations.add(buildNavigationDestination(context, i));
    }
    
    return Scaffold(
      appBar: null,
      body: (_weatherData == null)
        ? Center(
          child: Image.asset(
            'assets/icons/app_icon.png',
            width: MediaQuery.of(context).size.width * arrowSize,
            height: MediaQuery.of(context).size.width * arrowSize,
          ),
        )
        : GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0 && widget.day > 0) {
              Navigator.of(context).pushReplacement(
                createRoute(Day(weatherData: _weatherData, lightingTimes: _lightingTimes, day: widget.day - 1), const Offset(-1, 0))
              );
            } else if (details.primaryVelocity! < 0 && widget.day < numberDaysShown - 1) {
              Navigator.of(context).pushReplacement(
                createRoute(Day(weatherData: _weatherData, lightingTimes: _lightingTimes, day: widget.day + 1), const Offset(1, 0))
              );
            }
          },
          child: SingleChildScrollView(
            controller: _controller,
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
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // Top section
                        Container(
                          color: const Color.fromARGB(0, 0, 0, 0),
                          height: MediaQuery.of(context).size.height * 0.125,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0, bottom: 10.0), // Padding to give some space around the text
                          decoration: BoxDecoration(
                            color: Color.fromARGB(night ? 150 : 0, 7, 7, 7), // Background color
                            borderRadius: BorderRadius.circular(10.0), // Rounded corners
                          ),
                          child: IntrinsicWidth(
                            child: Text(
                              getDay(widget.day),
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.07,
                                color: night ? Colors.white : Colors.black
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: const Color.fromARGB(0, 0, 0, 0),
                          height: MediaQuery.of(context).size.height * 0.065,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          IconButton(
                            iconSize: MediaQuery.of(context).size.width * arrowSize,
                            onPressed: leftArrowPress,
                            icon: Arrow(arrowSize: MediaQuery.of(context).size.width * arrowSize, direction: 'left', visible: (widget.day > 0 ? true : false)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * flagSize,
                            height: MediaQuery.of(context).size.width * flagSize,
                            alignment: Alignment.center,
                            child: Flag(
                              flagSize: MediaQuery.of(context).size.width * flagSize,
                              flag: (widget.day == 0 ? getFlag(getHourlyForecast(widget.day)).toLowerCase() : predictFlag(getHourlyForecast(widget.day))),
                            ),
                          ),
                          IconButton(
                            iconSize: MediaQuery.of(context).size.width * arrowSize,
                            onPressed: rightArrowPress,
                            icon: Arrow(arrowSize: MediaQuery.of(context).size.width * arrowSize, direction: 'right', visible: (widget.day < numberDaysShown - 1 ? true : false)),
                          ),
                          ],
                        ),
                        widget.day==0 ? const SizedBox(height: 36,) : (
                          Container(
                            width: 150,
                            padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 6),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(150, 0, 0, 0), // Background color
                              borderRadius: BorderRadius.circular(10.0), // Rounded corners
                            ),
                            child: const Text(
                              "Prediction Flag",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            )
                          )
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.07,),
                        WeatherTable(hourlyForecast: getHourlyForecast(widget.day), day: widget.day),
                        IconButton(
                          iconSize: MediaQuery.of(context).size.width * arrowSize,
                          onPressed: _scrollDown,
                          icon: Arrow(arrowSize: MediaQuery.of(context).size.width * arrowSize, direction: 'down', visible: true),
                      ),
                      ],
                    )
                  ],
                ),

                Stack(
                  children: [
                    Container( //Background Bottom Page
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height,
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
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: WindSpeedWidget(
                                      windspeed: "${getWindSpeed(getHourlyForecast(widget.day), getCurrentHour())} mph",
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15), // Space between the widgets
                                Expanded(
                                  child: Center(
                                    child: WindDirectionWidget(
                                      windDirection: getWindDirection(getHourlyForecast(widget.day)),
                                    ),
                                  ),
                                ),
                              ],
                            ), 
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: HumidityWidget(humidity: getHumidity(getHourlyForecast(widget.day))),
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
                                  child: SunsetTimeWidget(sunriseTime: getSunrise(_lightingTimes, widget.day), sunsetTime: getSunset(_lightingTimes, widget.day)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )
            )
        ),
      
        bottomNavigationBar: _weatherData == null
        ? Container()
        : NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              if (index == widget.day) {return;}
              Offset offset = index < widget.day ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0);
              Navigator.of(context).pushReplacement(
                createRoute(Day(weatherData: _weatherData, lightingTimes: _lightingTimes, day: index), offset)
              );
            });
          },
          // indicatorColor: Colors.amber,
          selectedIndex: widget.day,
          destinations: destinations,
          backgroundColor: const Color.fromRGBO(0, 74, 126, 1),
          indicatorColor: const Color.fromRGBO(0, 141, 199, 0),
          indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          
        )
    );
  }

}