import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/weather_now.dart';

@immutable
abstract class WeatherNowListState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeatherNowListLoading extends WeatherNowListState {}

class WeatherNowListChoosed extends WeatherNowListState {
  final WeatherNow data;

  WeatherNowListChoosed({required this.data});
}

class WeatherNowListWaiting extends WeatherNowListState {}

class WeatherNowListSending extends WeatherNowListState {}

class WeatherNowListError extends WeatherNowListState {
  final String message;

  WeatherNowListError({required this.message});
}

class WeatherNowListLoaded extends WeatherNowListState {
  final List<WeatherNow> weatherNowList;

  WeatherNowListLoaded({required this.weatherNowList});
}
