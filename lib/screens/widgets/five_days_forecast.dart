import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class FiveDayForecastWidget extends StatelessWidget {
  const FiveDayForecastWidget({super.key, required this.weather});
  final List<Weather> weather;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weather.length,
      itemBuilder: (context, index) {
        Weather w = weather[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromRGBO(255, 255, 255, .018),
          ),
          child: ListTile(
            leading: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: w.temperature!.celsius!.toStringAsFixed(0),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFfafafa),
                            fontSize: 28,
                          ),
                        ),
                        TextSpan(
                          text: '°C',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.amber.shade600,
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            title: Text(
              "${DateFormat.jm().format(DateTime.parse(w.date.toString()))} - ${DateFormat("EE, dd MMM").format(DateTime.parse(w.date.toString()))}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.amber.shade600,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              w.weatherDescription.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFFfafafa),
              ),
            ),
            trailing: Image.network(
                'http://openweathermap.org/img/w/${w.weatherIcon}.png'),
          ),
        );
      },
    );
  }
}
