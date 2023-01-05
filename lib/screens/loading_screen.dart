import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';


import 'package:weather_app/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  static const String API_KEY='87513add4cb8e9bdd283b8ed34605ab9';
  late double lat,long;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location=Location();
    await location.getLocation();
    lat=location.lat;
    long=location.long;
    var url='https://api.openweathermap.org/data/2.5/weather?'
        'lat=$lat&lon=$long&appid=$API_KEY&units=metric';
    NetworkHelper helper=NetworkHelper(url: url);
    var jsonDecode=await helper.getData();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context){
              return LocationScreen(weaterData: jsonDecode);
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children:[
             SpinKitDoubleBounce(
               color: Colors.white,
               size: 100,
             ),
             Padding(
               padding: const EdgeInsets.only(top: 20,left: 8,right: 8),
               child: Text(
                 'Please wait while we fetch your location',
                   textAlign: TextAlign.center,
                 style:TextStyle(
                   fontSize: 30,
                   fontWeight: FontWeight.w500,

                 )
               ),
             )
           ]
        ),
      ),
      );
  }
}
