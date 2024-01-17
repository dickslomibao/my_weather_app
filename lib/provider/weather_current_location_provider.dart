import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_weather_app/services/geo_location.dart';
import 'package:weather/weather.dart';

class WeatherCurrentLocation extends ChangeNotifier {
  bool isLoading = true;
  String permissionStatus = "";
  late Position position;
  late Placemark placemark;
  late String temperature;
  late String weatherCondition;
  late String weatherIcon;
  late List<Weather> fiveDayForecast;
  Future<void> getPermission() async {
    isLoading = true;
    permissionStatus = await geoLocationServices.getPermission();
    if (permissionStatus == 'permission-granted') {
      position = await geoLocationServices.getPosition();

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      placemark = placemarks.first;
      WeatherFactory wf = WeatherFactory('bdec9591fefbd01f7782f4308cc8c9f3');
      Weather w = await wf.currentWeatherByLocation(
          position.latitude, position.longitude);
      temperature = w.temperature!.celsius!.toStringAsFixed(0);
      weatherCondition = w.weatherDescription.toString();
      weatherIcon = w.weatherIcon.toString();
      fiveDayForecast = await wf.fiveDayForecastByLocation(
          position.latitude, position.longitude);
    }
    isLoading = false;
    notifyListeners();
  }


}
