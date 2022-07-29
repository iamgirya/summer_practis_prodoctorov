import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/weather_today.dart';

@immutable
abstract class TodayListState extends Equatable {
  @override
  List<Object> get props => [];
}

class TodayListLoading extends TodayListState {}

class TodayListError extends TodayListState {
  final String message;

  TodayListError({required this.message});
}

class TodayListLoaded extends TodayListState {
  final List<WeatherHour> weatherHourList;

  TodayListLoaded({required this.weatherHourList});
}