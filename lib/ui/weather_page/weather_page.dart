import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../navigation/navigation_controller.dart';
import 'widgets/days_list_widget.dart';
import 'widgets/now_weather_widget.dart';
import 'widgets/today_list_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key, required this.townName}) : super(key: key);

  final String townName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
            minHeight: Size.infinite.height, minWidth: Size.infinite.width),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/sunBack.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: ListView(
                    children: [
                      NowWeather(townName: townName),
                      TodayWeatherList(townName: townName),
                      const SizedBox(
                        height: 16,
                      ),
                      DaysWeatherList(townName: townName),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              constraints:
                  BoxConstraints(minWidth: Size.infinite.width, minHeight: 60),
              child: TextButton(
                onPressed: () {
                  context.read<NavigationController>().pop();
                },
                child: const Text("Назад"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
