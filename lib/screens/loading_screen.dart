

import 'package:flutter/material.dart';

import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';




class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getlocation();
  }

  void getlocation() async {

    var wedherdata = await WeatherModel().locationweatherca();
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationweadher:wedherdata);
    }) );
    //print(wedherdata);
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.green,
          size: 50.0,
        ),
      ),
    );


  }
}
