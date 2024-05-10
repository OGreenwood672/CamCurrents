import 'package:flutter/material.dart';
class WeatherTable extends StatelessWidget {
  const WeatherTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: List.generate(
            24, // Assuming 24 hours
            (index) => DataColumn(
              label: Text('$index:00'),
            ),
          ),
          rows: List.generate(
            2, // Assuming 5 days
            (dayIndex) => DataRow(
              cells: List.generate(
                24, // Assuming 24 hours
                (hourIndex) => DataCell(
                  Container(
                    width: 200, // Adjust according to your need
                    height: 100, // Adjust according to your need
                    color: Colors.grey[300],
                    child: const Center(
                      child: Text('Weather Info'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}