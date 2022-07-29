import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/added_town_list.dart';

@immutable
abstract class AddedTownListState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddedTownListLoading extends AddedTownListState {}

class AddedTownListCreated extends AddedTownListState {}

class AddedTownListError extends AddedTownListState {
  final String message;

  AddedTownListError({required this.message});
}

class AddedTownListLoaded extends AddedTownListState {
  final List<AddedTown> addedTownList;

  AddedTownListLoaded({required this.addedTownList});
}
