import 'package:flutter/material.dart';
import 'package:camcurrents/weathertable.dart';
import 'package:camcurrents/extradetails.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}


class MainPageState extends State<MainPage> {

  int selectedDay = 0;
  double dayIconSize = 40;

  List<Map<String, dynamic>> days = [
    {
      "day": "Monday",
      "nick": "Mon"
    },
    {
      "day": "Tuesday",
      "nick": "Tue"
    },
    {
      "day": "Wednesday",
      "nick": "Wed"
    }
  ];

  Widget buildNavigationDestination(int day) {
    return NavigationDestination(
      selectedIcon: ColorFiltered(
        colorFilter: const ColorFilter.mode(Color.fromARGB(255, 27, 106, 234), BlendMode.srcIn),
        child: Image.asset(
          'assets/icons/${days[day]["day"].toLowerCase()}.png',
          width: dayIconSize,
          height: dayIconSize,
        ),
      ),
      icon: Image.asset('assets/icons/${days[day]["day"].toLowerCase()}.png', width: dayIconSize, height: dayIconSize),
      label: "",
    );
  }

  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(days[selectedDay]["day"]),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Top section
            Container(
              color: Colors.white,
              height: 300,
              child: const Center(
                child: Text('Top Section'),
              ),
            ),
            const WeatherTable(),
            const ExtraDetails(),
          ],
        ),
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
