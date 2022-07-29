class WeatherNow {
  WeatherNow({
    this.temp = -1,
    this.weatherName = "",
    this.townName = "",
  });

  final int temp;
  final String weatherName;
  final String townName;

  static WeatherNow fromJson(Map<String, dynamic> map) {
    //добавить имя города
    return WeatherNow(
      temp: (map["main"]["temp"] - 273.15).round(),
      weatherName: map["weather"][0]["main"],
      townName: map["name"],
    );
  }
}
