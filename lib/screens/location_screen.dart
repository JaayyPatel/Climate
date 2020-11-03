import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweadher});
  final locationweadher;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int tempertaure;
  String condition;
  String city;
  String mssg;

  @override
  // ignore: must_call_super
  void initState() {
    // TODO: implement initState
    updateui(widget.locationweadher);
  }
  void updateui(dynamic weadtherdata) {
   setState(() {
     if(weadtherdata == null)
       {
         tempertaure = 0;
         mssg = 'Error';
         city='null';
         return;
       }
     var temp = weadtherdata['main']['temp'];
     tempertaure = temp.toInt();
     mssg = weather.getMessage(tempertaure);
     var cond = weadtherdata['weather'][0]['id'];
     condition = weather.getWeatherIcon(cond);
     city = weadtherdata['name'];
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/weather.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherdata  = await weather.locationweatherca();
                      updateui(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typename = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }) );
                      if(typename != null)
                        {
                          print(typename);
                          var weatherdata = await weather.getcitylocation(typename);
                          updateui(weatherdata);
                        }
                    },

                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$tempertaure°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      condition,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  mssg+" in "+city,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
