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

  void getData() {
    Future<Map<int, dynamic>> futureForecast = getForcast();
    futureForecast.then((data) {
      weatherData = data;
    });
  }

  String getDay(day) {
    if (weatherData == null) {
      if (!isFetching) {
        isFetching = true;
        getData();
      }
      return "";
    }
    return weatherData?[day]["day"];
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(getDay(selectedDay)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/sunny_bg.png'),
                      fit: BoxFit.fill,
                    )
                  ),
    
                ),
            
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Top section
                    Container(
                      color: const Color.fromARGB(0, 0, 0, 0),
                      height: 500,
                      child: const Center(
                        child: Text('Top Section'),
                      ),
                    ),
                    const WeatherTable(),
                  ],
                )
              ],
            ),

            const Stack(
              children: [
                Column(
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
        destinations: <Widget>[
          buildNavigationDestination(0),
          buildNavigationDestination(1),
          buildNavigationDestination(2),
        ],
      ),
    );
  }

}