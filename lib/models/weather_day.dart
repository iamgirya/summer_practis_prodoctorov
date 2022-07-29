class WeatherDay {
  const WeatherDay({
    this.weatherName = "",
    this.tempMax = -1,
    this.tempMin = -1,
    this.day,
  });

  final String weatherName;
  final int tempMax;
  final int tempMin;
  final DateTime? day;

  static WeatherDay fromJson(json) {
    return WeatherDay(
      day: DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000),
      tempMax: (json["main"]["temp_max"] - 273.15).round(),
      tempMin: (json["main"]["temp_min"] - 273.15).round(),
      weatherName: json["weather"][0]["main"],
    );
  }

  copyWith({
    weatherName,
    tempMax,
    tempMin,
    day,
  }) {
    return WeatherDay(
      weatherName: weatherName ?? this.weatherName,
      tempMax: tempMax ?? this.tempMax,
      tempMin: tempMin ?? this.tempMin,
      day: day ?? this.day,
    );
  }
}
