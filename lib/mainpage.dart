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
            const ExtraDetails(),
            ],
            )
          ],
          ),
     
        Container(
              color: const Color.fromARGB(0, 0, 0, 0),
              height: 500,
              child: const Center(
                child: Text('Bottom Section'),
              ),
            ),
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
