import 'dart:async';

import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration:const Duration(seconds: 3),
      vsync: this
  )..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),
        ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>WorldStatesScreen())));
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
             SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
                ),
              AnimatedBuilder(animation: _controller,
                  child: Container(
                    height: 200,
                    width: 200,
                    child: const Center(
                      child: Image(image: AssetImage('images/virus.png')),
                    ),
                  ),
                  builder: (context, childWidget) {
                   return Transform.rotate(
                        angle: _controller.value *2.0 *math.pi,
                        child: childWidget,
                    );
                  },)
            ,SizedBox(
              height: MediaQuery.of(context).size.height*0.1,
            ),
           Align(
             alignment: Alignment.center,
             child: Text('Covid-19 \n Tracker App',style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 25,

             ),
               textAlign: TextAlign.center,),
           )
          ],
        ),
      ),
    );
  }
}
