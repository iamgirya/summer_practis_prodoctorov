class WeatherHour {
  const WeatherHour({
    required this.weatherName,
    required this.temp,
    required this.hour,
  });

  final String weatherName;
  final int temp;
  final int hour;

  static WeatherHour fromJson(json) {
    return WeatherHour(
      hour: DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000).hour,
      temp: (json["main"]["temp"] - 273.15).round(),
      weatherName: json["weather"][0]["main"],
    );
  }
}
