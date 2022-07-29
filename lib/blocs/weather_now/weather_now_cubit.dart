import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/weather_now.dart';
import '../../repositories/forecast_repository.dart';
import 'weather_now_state.dart';

class WeatherNowCubit extends Cubit<WeatherNowState> {
  WeatherNowCubit({required this.forecastRepository})
      : super(WeatherNowLoading());
  final IForecastRepository forecastRepository;

  void updateWeatherNowForTown(String name) async {
    emit(WeatherNowLoading());
    try {
      WeatherNow tmp = await forecastRepository.getNowWeather(name);
      emit(WeatherNowLoaded(weatherNow: tmp));
    } catch (e) {
      print(e);
      emit(WeatherNowError(message: "Ошибка запроса"));
    }
  }
}
