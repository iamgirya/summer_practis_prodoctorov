import 'package:summer_practis_prodoctorov/models/weather_now.dart';

class AddedTown {
  AddedTown({
    required this.weather,
    required this.isFavorite,
  });

  final WeatherNow weather;
  bool isFavorite;
}
