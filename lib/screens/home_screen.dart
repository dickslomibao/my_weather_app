import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_weather_app/provider/weather_city_provider.dart';
import 'package:my_weather_app/screens/widgets/five_days_forecast.dart';
import 'package:provider/provider.dart';
import 'package:my_weather_app/provider/weather_current_location_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final read = context.read<WeatherCurrentLocation>();
    final watch = context.watch<WeatherCurrentLocation>();
    if (read.permissionStatus == "") {
      read.getPermission();
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Weather Application',
          style:
              TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFfafafa)),
        ),
      ),
      backgroundColor: const Color(0xAA1D1D48),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade600,
        onPressed: () {
          showDialog(
            builder: (_) =>
                Consumer<WeatherCity>(builder: (context, value, child) {
              return AlertDialog(
                title: const Text(
                  'Get Weather',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: const [],
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (value.w != null)
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              color: const Color.fromRGBO(0, 0, 0, .1),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Temperature:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      value.w!.temperature.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                        color: Colors.amber.shade600,
                                      ),
                                    ),
                                    const Text(
                                      'Location:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${value.w!.areaName!}, ${value.w!.country!}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      const Text(
                        'City:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: OutlineInputBorder(),
                          hintText: 'Enter city...',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: value.notfound,
                        child: const Center(
                          child: Text(
                            'City not found',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber.shade700,
                          ),
                          onPressed: () async {
                            await value.getCityWeather(controller.text);
                          },
                          child: const Text(
                            'Get',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
            context: context,
          );
        },
        child: const Icon(
          Icons.edit_location_alt,
          color: Color(0xFF1D1D48),
          size: 30,
        ),
      ),
      body: watch.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.amber.shade600,
              ),
            )
          : watch.permissionStatus != "permission-granted"
              ? Center(
                  child: Text(
                    watch.permissionStatus,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFfafafa),
                      fontSize: 20,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    bottom: 15.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // boxShadow: ,
                          color: const Color.fromRGBO(255, 255, 255, .018),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Today',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFfafafa),
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "${DateFormat("EE, dd MMM").format(DateTime.now())}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFfafafa),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                read.temperature,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFfafafa),
                                                  fontSize: 65,
                                                ),
                                              ),
                                              Text(
                                                '°C',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.amber.shade600,
                                                  fontSize: 65,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 3),
                                            decoration: BoxDecoration(
                                              color: Colors.amber.shade600,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              '${read.weatherCondition}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFFfafafa),
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Image.network(
                                    'http://openweathermap.org/img/w/${read.weatherIcon}.png',
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BuildColumnData(
                                    label: 'Latitude',
                                    value: read.position.latitude
                                        .toStringAsFixed(2),
                                  ),
                                  BuildColumnData(
                                    label: 'Longtitude',
                                    value: read.position.longitude
                                        .toStringAsFixed(2),
                                  ),
                                  BuildColumnData(
                                    label: 'Altitude',
                                    value: read.position.altitude
                                        .toStringAsFixed(2),
                                  ),
                                  BuildColumnData(
                                    label: 'Accuracy',
                                    value: read.position.accuracy
                                        .toStringAsFixed(2),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Location:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFfafafa),
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                '${read.placemark.street} ${read.placemark.subLocality} ${read.placemark.locality} ${read.placemark.subAdministrativeArea} ${read.placemark.administrativeArea} ${read.placemark.country}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFfafafa),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        ' Five days Forecast:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFfafafa),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: FiveDayForecastWidget(
                          weather: read.fiveDayForecast,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

class BuildColumnData extends StatelessWidget {
  const BuildColumnData({
    super.key,
    required this.label,
    required this.value,
  });
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${label}:',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFFfafafa),
            fontSize: 15,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFFfafafa),
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
