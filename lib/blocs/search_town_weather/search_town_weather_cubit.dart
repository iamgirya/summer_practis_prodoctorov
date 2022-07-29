import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_practis_prodoctorov/blocs/search_town_weather/search_town_weather_state.dart';

import '../../models/weather_now.dart';
import '../../repositories/forecast_repository.dart';

class SearchTownWeatherCubit extends Cubit<WeatherNowListState> {
  SearchTownWeatherCubit({required this.forecastRepository})
      : super(WeatherNowListWaiting());
  final IForecastRepository forecastRepository;

  StreamController<String> queryStreamController = StreamController<String>();
  late void Function() clearSearchPanel;
  Timer? delayTime;

  void initQueryStreamSubscribe(TextEditingController controller) {
    queryStreamController.stream.listen((event) {
      sendWeatherQuery(event);
    });
    controller.addListener(() {
      filterSearchQuery(controller.text);
    });
    clearSearchPanel = () {
      //закрыть бы клаву
      controller.clear();
    };
  }

  void filterSearchQuery(String query) {
    emit(WeatherNowListWaiting());
    if (query == "") {
      if (delayTime != null) {
        delayTime!.cancel();
      }
      return;
    }

    if (delayTime != null && delayTime!.isActive) {
      delayTime!.cancel();
    }
    delayTime = Timer(const Duration(milliseconds: 800), () {
      queryStreamController.sink.add(query);
    });
  }

  void sendWeatherQuery(String name) async {
    emit(WeatherNowListLoading());
    try {
      List<WeatherNow> tmp =
          await forecastRepository.getSearchedTownsWeather(name);
      emit(WeatherNowListLoaded(weatherNowList: tmp));
    } catch (e) {
      print(e);
      emit(WeatherNowListError(message: "Ошибка запроса"));
    }
  }

  void onChooseTown(WeatherNow weatherNow) {
    emit(WeatherNowListChoosed(data: weatherNow));
    clearSearchPanel();
  }

  @override
  Future<void> close() {
    queryStreamController.close();
    return super.close();
  }
}
