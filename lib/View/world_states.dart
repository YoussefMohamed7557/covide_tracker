import 'dart:async';

import 'package:covid_tracker/View/countries_list.dart';
import 'package:covid_tracker/model/WorldStatesModel.dart';
import 'package:covid_tracker/services/StatesServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen();

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration:const Duration(seconds: 3),
      vsync: this
  )..repeat();
  final colorList = < Color> [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  @override
  void dispose() {
    _controller.dispose();
    print("home page disposed");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    StatesServices _statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<WorldStatesModel>(
            future:_statesServices.getWorldStatesApiData(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50.0,
                  controller: _controller,
                );
              }else if(snapshot.hasError){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error check network and try again'),
                      ElevatedButton(onPressed: (){setState(() {});}, child: Icon(Icons.refresh,size: 32,color: Colors.blue,),)
                    ],
                  ),
                );
              }else{
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                      PieChart(dataMap:{
                        "Total":double.parse(snapshot.data!.cases!.toString()),
                        "Recovered":double.parse(snapshot.data!.recovered!.toString()),
                        "Death":double.parse(snapshot.data!.deaths!.toString()),
                      },
                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesInPercentage: true
                        ),
                        legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left
                        ),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        animationDuration: Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorList,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(title: 'Total', value: snapshot.data!.cases!.toString()),
                              ReusableRow(title: 'Death', value:snapshot.data!.deaths!.toString()),
                              ReusableRow(title: 'Recovered', value: snapshot.data!.recovered!.toString()),
                              ReusableRow(title: 'Active', value: snapshot.data!.active!.toString()),
                              ReusableRow(title: 'Critical', value:snapshot.data!.critical!.toString()),
                              ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths!.toString()),
                              ReusableRow(title: 'Today Recovery', value: snapshot.data!.todayRecovered!.toString()),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesListScreen(),));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text('Track Country',style: TextStyle(fontSize: 18),),
                          ),
                          height: 50,
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title,value;
  ReusableRow({Key? key,required this.title,required this.value}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:  EdgeInsets.only(top:10  ,bottom: 5 ,left: 10 ,right: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text(value),
              ],
            ),
            SizedBox(height: 5,),
            Divider(),
          ],
        ),
    );
  }
}
