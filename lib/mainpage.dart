import 'package:camcurrents/data.dart';
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
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(days[0]["day"]),
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
        indicatorColor: Colors.amber,
        selectedIndex: selectedDay,
        destinations: <Widget>[
          NavigationDestination(
            icon: const SizedBox.shrink(),
            label: days[0]["nick"],
          ),
          NavigationDestination(
            icon: const SizedBox.shrink(),
            label: days[1]["nick"],
          ),
          NavigationDestination(
            icon: const SizedBox.shrink(),
            label: days[2]["nick"],
          ),
        ],
      ),
    );
  }
}
