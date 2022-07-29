import 'package:dio/dio.dart';

import '../models/weather_day.dart';
import '../models/weather_now.dart';
import '../models/weather_today.dart';

abstract class IForecastRepository {
  Future<List<WeatherDay>> getFiveDaysForecast(String name);

  Future<List<WeatherHour>> getTodayForecast(String name);

  Future<WeatherNow> getNowWeather(String name);

  Future<List<WeatherNow>> getSearchedTownsWeather(String name);
}

class ForecastRepository implements IForecastRepository {

  List<WeatherDay> sortTempFromForecastResultByDays(List<WeatherDay> result) {
    List<WeatherDay> sortedResult = [];
    for (int i = 0; i < result.length; i++) {
      if (result[i].day!.day != DateTime
          .now()
          .day) {
        if (sortedResult.isEmpty) {
          sortedResult.add(result[i]);
        } else if (sortedResult.isNotEmpty &&
            sortedResult[sortedResult.length - 1].day!.day !=
                result[i].day!.day) {
          sortedResult.add(result[i]);
        } else if (sortedResult.isNotEmpty) {
          if (sortedResult[sortedResult.length - 1].tempMax <
              result[i].tempMax) {
            sortedResult[sortedResult.length - 1] =
                sortedResult[sortedResult.length - 1]
                    .copyWith(tempMax: result[i].tempMax);
          }
          if (sortedResult[sortedResult.length - 1].tempMin >
              result[i].tempMin) {
            sortedResult[sortedResult.length - 1] =
                sortedResult[sortedResult.length - 1]
                    .copyWith(tempMin: result[i].tempMin);
          }
        }
      }
    }
    return sortedResult;
  }

  @override
  Future<List<WeatherDay>> getFiveDaysForecast(String name) async {
    List<WeatherDay> result = [];

    try {
      Response<Map<String, dynamic>> response = await Dio().get(
        'https://api.openweathermap.org/data/2.5/forecast',
        queryParameters: {
          "q": name,
          "appid": "a0e508f45eed10d76be37cc08bfab391",
        },
      );
      for (var day in response.data!["list"]) {
        result.add(WeatherDay.fromJson(day));
      }

      return sortTempFromForecastResultByDays(result);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<List<WeatherHour>> getTodayForecast(String name) async {
    List<WeatherHour> tmpList = [];
    try {
      Response<Map<String, dynamic>> response = await Dio().get(
        'https://api.openweathermap.org/data/2.5/forecast',
        queryParameters: {
          "q": name,
          "appid": "a0e508f45eed10d76be37cc08bfab391",
        },
      );
      for (var day in response.data!["list"]) {
        if (DateTime
            .fromMillisecondsSinceEpoch(day["dt"] * 1000)
            .day ==
            DateTime
                .now()
                .day) {
          tmpList.add(WeatherHour.fromJson(day));
        }
      }
    } catch (e) {
      print(e);
    }

    return tmpList;
  }

  @override
  Future<WeatherNow> getNowWeather(String name) async {
    try {
      Response<Map<String, dynamic>> response = await Dio().get(
          'https://api.openweathermap.org/data/2.5/weather',
          queryParameters: {
            "q": name,
            "appid": "a0e508f45eed10d76be37cc08bfab391",
          });
      WeatherNow tmp = WeatherNow.fromJson(response.data!);
      return tmp;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<List<WeatherNow>> getSearchedTownsWeather(String name) async {
    try {
      Response<Map<String, dynamic>> response = await Dio()
          .get('https://openweathermap.org/data/2.5/find', queryParameters: {
        "q": name,
        "type": "like",
        "sort": "population",
        "cnt": "30",
        "appid": "439d4b804bc8187953eb36d2a8c26a02",
      });
      List<WeatherNow> tmpList = [];
      for (var day in response.data!["list"]) {
        tmpList.add(WeatherNow.fromJson(day));
      }
      return tmpList;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
