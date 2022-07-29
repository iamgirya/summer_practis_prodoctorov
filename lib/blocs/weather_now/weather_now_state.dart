import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/weather_now.dart';

@immutable
abstract class WeatherNowState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherNowLoading extends WeatherNowState {}

class WeatherNowError extends WeatherNowState {
  final String message;

  WeatherNowError({required this.message});
}

class WeatherNowLoaded extends WeatherNowState {
  final WeatherNow weatherNow;

  WeatherNowLoaded({required this.weatherNow});
}
