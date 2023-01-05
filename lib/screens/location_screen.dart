import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather.dart';
import 'city_screen.dart';
import 'package:weather_app/services/networking.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen({this.weaterData});
  final weaterData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  static const String API_KEY='87513add4cb8e9bdd283b8ed34605ab9';
  late int temperature;
  late int condition;
  late String cityName;
  late String descp;
  @override
  void initState() {
    super.initState();
    updateUI(widget.weaterData);
  }

  void updateUI(dynamic weaterData){
    setState(() {
      double temp=weaterData['main']['temp'];
      temperature=temp.toInt();
      condition=weaterData['weather'][0]['id'];
      cityName=weaterData['name'];
      descp=weaterData['weather'][0]['description'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
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
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityNamed=await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context){
                            return CityScreen();
                          })
                      );
                      print(cityNamed);
                      if(cityNamed!=null) {
                        var url = 'https://api.openweathermap.org/data/2.5/weather?'
                            'q=$cityNamed&appid=$API_KEY&units=metric';
                        NetworkHelper helper = NetworkHelper(url: url);
                        var response = await helper.getData();
                        print(response);
                        setState(() {
                          updateUI(response);
                        });

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
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      WeatherModel().getWeatherIcon(condition),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  WeatherModel().getMessage(temperature)+' in '+cityName,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
