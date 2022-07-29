import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_practis_prodoctorov/blocs/today_list/today_list_state.dart';
import 'package:summer_practis_prodoctorov/models/weather_today.dart';

import '../../repositories/forecast_repository.dart';

class TodayListCubit extends Cubit<TodayListState> {
  TodayListCubit({required this.forecastRepository})
      : super(TodayListLoading());
  final IForecastRepository forecastRepository;

  void updateTodayListForTown(String name) async {
    emit(TodayListLoading());
    try {
      List<WeatherHour> tmp = await forecastRepository.getTodayForecast(name);
      emit(TodayListLoaded(weatherHourList: tmp));
    } catch (e) {
      print(e);
      emit(TodayListError(message: "Ошибка запроса"));
    }
  }
}
