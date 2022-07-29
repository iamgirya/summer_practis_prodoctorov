import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/forecast_repository.dart';
import 'days_weather_state.dart';

class DaysWeatherCubit extends Cubit<DaysWeatherState> {
  DaysWeatherCubit({required this.forecastRepository})
      : super(DaysWeatherLoading());

  final IForecastRepository forecastRepository;

  void updateWeatherDaysForTown(String name) async {
    emit(DaysWeatherLoading());
    try {
      var tmpList = await forecastRepository.getFiveDaysForecast(name);
      emit(DaysWeatherLoaded(weatherDayList: tmpList));
    } catch (e) {
      print(e);
      emit(DaysWeatherError(message: "Ошибка запроса"));
    }
  }
}
