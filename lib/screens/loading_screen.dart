import 'package:clima_app/services/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:http/http.dart' as http;
import 'package:clima_app/services/weather.dart';
import 'dart:convert';
import 'package:clima_app/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';

const ApiKey = 'e83a143074e55b9b2873af001d174663';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double longitude;
  double latitude;

  @override
  void initState() {
    super.initState();
    getDataLocation();
  }

  void getDataLocation() async {
    //Only Android
    // Map<Permission, PermissionStatus> status = await [
    //   Permission.location,
    // ].request();
    Location location = Location();
    await location.getCurrentPosition();

    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$ApiKey');
    var weatherData = await networkHelper.getData();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationScreen()));
  }

  @override
  Widget build(BuildContext context) {
    //IOS USAGE BUG
    getDataLocation();
    return const Scaffold(
      body: Center(
        child: SpinKitSpinningLines(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
