import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/weather_day.dart';

@immutable
abstract class DaysWeatherState extends Equatable {
  @override
  List<Object> get props => [];
}

class DaysWeatherLoading extends DaysWeatherState {}

class DaysWeatherError extends DaysWeatherState {
  final String message;

  DaysWeatherError({required this.message});
}

class DaysWeatherLoaded extends DaysWeatherState {
  final List<WeatherDay> weatherDayList;

  DaysWeatherLoaded({required this.weatherDayList});
}
