import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

class DatailsScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,
      totalRecovered,
      totalDeaths,
      active,
      critical,
      todayRecovered,
      test;

  DatailsScreen(
      {required this.name,
      required this.image,
      required this.totalCases,
      required this.totalRecovered,
      required this.totalDeaths,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test,
      Key? key})
      : super(key: key);

  @override
  State<DatailsScreen> createState() => _DatailsScreenState();
}

class _DatailsScreenState extends State<DatailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding:EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05 ),
                  child: Card(
                    child: Column(
                      children: [
                        ReusableRow(title: 'Total Cases', value: widget.totalCases.toString()),
                        ReusableRow(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                        ReusableRow(title: 'Total Death', value: widget.totalDeaths.toString()),
                        ReusableRow(title: 'active', value: widget.active.toString()),
                        ReusableRow(title: 'Critical cases', value: widget.critical.toString()),
                        ReusableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                        ReusableRow(title: 'test', value: widget.test.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ]),
    );
  }
}
