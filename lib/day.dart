import 'package:camcurrents/data.dart';
import 'package:camcurrents/extradetails.dart';
import 'package:camcurrents/weathertable.dart';
import 'package:flutter/material.dart';

class Day extends StatefulWidget {
  final int day;

  const Day({super.key, required this.day});

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {

  int selectedDay = 0;
  double dayIconSize = 40;

  Map<int, dynamic>? weatherData;
  bool isFetching = false;

  static const int numberDaysShown = 4;
  final int realDay;

  _DayState() : realDay = (DateTime.now().weekday - 1);

  void getData() {
    Future<Map<int, dynamic>> futureForecast = getForcast();
    futureForecast.then((data) {
      setState(() {
        weatherData = data;
      });
    });
  }

  String getDay(day) {
    const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    return days[(day+realDay)%7];
  }

  Map<int, dynamic>? getHourlyForecast(day) {

      if (weatherData == null) {
        if (!isFetching) {
          isFetching = true;
          getData();
        }
        return null;
      }
      if (0 > day || day > 4) { return null; }
      return weatherData?[day]["hourly_forecast"];
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

    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Column( //Whole Page Column
          children: [
            Stack( // Top Page
              children: [
                Container( //Background Top Page
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/sunny_bg.png'),
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
                        getDay(selectedDay),
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(0, 0, 0, 0),
                      height: 300,
                    ),
                    WeatherTable(hourlyForecast: getHourlyForecast(selectedDay)),
                  ],
                )
              ],
            ),

             Stack(
              children: [Container( //Background Top Page
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/underwater_bg.png'),
                      fit: BoxFit.fill,
                    )
                  ),
    
                ),
                const Column(
                  children: [
                    ExtraDetails(),
                  ]
                )
              ],
            )

          ],
        )
        
        
      ),
    
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            selectedDay = index;
          });
        },
        // indicatorColor: Colors.amber,
        selectedIndex: selectedDay,
        destinations: destinations
      ),
    );
  }

}