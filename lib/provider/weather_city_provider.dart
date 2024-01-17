import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherCity extends ChangeNotifier {
  bool notfound = false;
  Weather? w;
  Future<void> getCityWeather(String city) async {
    notfound = false;
    notifyListeners();
    WeatherFactory wf = WeatherFactory('bdec9591fefbd01f7782f4308cc8c9f3');
    try {
      w = await wf.currentWeatherByCityName(city);
    } on OpenWeatherAPIException catch (e) {
      w = null;
      notfound = true;
    }
    notifyListeners();
  }
}
