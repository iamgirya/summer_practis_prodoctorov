import 'package:flutter/material.dart';
import 'package:summer_practis_prodoctorov/models/weather_now.dart';

class SearchCard extends StatelessWidget {
  const SearchCard(
      {Key? key, required this.weatherNow, required this.onChooseTown})
      : super(key: key);

  final WeatherNow weatherNow;
  final void Function(WeatherNow) onChooseTown;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.blue,
      child: ListTile(
        title: TextButton(
          onPressed: () {
            onChooseTown(weatherNow);
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(8),
            primary: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
          ),
          child: Container(
            height: 20,
            constraints: BoxConstraints(minWidth: Size.infinite.width),
            child: Text(weatherNow.townName),
          ),
        ),
      ),
    );
  }
}
