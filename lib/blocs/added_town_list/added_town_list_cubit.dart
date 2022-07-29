import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_practis_prodoctorov/blocs/added_town_list/added_town_list_state.dart';
import 'package:summer_practis_prodoctorov/models/saved_town_model.dart';
import 'package:summer_practis_prodoctorov/models/weather_now.dart';

import '../../models/added_town_list.dart';
import '../../repositories/forecast_repository.dart';
import '../../repositories/local_saves_repository.dart';

class AddedTownListCubit extends Cubit<AddedTownListState> {
  AddedTownListCubit(
      {required this.forecastRepository, required this.localSavesRepository})
      : super(AddedTownListCreated());

  final IForecastRepository forecastRepository;
  final ILocalSavesRepository localSavesRepository;

  void addNewTown(WeatherNow data) async {
    if (state is AddedTownListLoaded) {
      var addedTown = (state as AddedTownListLoaded).addedTownList;
      addedTown.add(AddedTown(weather: data, isFavorite: false));
      _sortAddedTown();
      _saveLocalAddedTowns();

      emit(AddedTownListLoading());
      emit(AddedTownListLoaded(addedTownList: addedTown));
    }
  }

  int getLengthOfAddedTownList() {
    if (state is AddedTownListLoaded) {
      return (state as AddedTownListLoaded).addedTownList.length;
    }
    return 0;
  }

  AddedTown getWeatherNowModel(int index) {
    try {
      if (state is AddedTownListLoaded) {
        return (state as AddedTownListLoaded).addedTownList[index];
      }
      throw Error();
    } catch (e) {
      rethrow;
    }
  }

  void deleteWeatherNowModel(int index) {
    if (state is AddedTownListLoaded) {
      var addedTown = (state as AddedTownListLoaded).addedTownList;
      addedTown.removeAt(index);
      _saveLocalAddedTowns();

      emit(AddedTownListLoading());
      emit(AddedTownListLoaded(addedTownList: addedTown));
    }
  }

  void changeIsFavoriteTownAndSort(int index) {
    if (state is AddedTownListLoaded) {
      var addedTown = (state as AddedTownListLoaded).addedTownList;
      addedTown[index].isFavorite = !addedTown[index].isFavorite;
      _sortAddedTown();
      _saveLocalAddedTowns();

      emit(AddedTownListLoading());
      emit(AddedTownListLoaded(addedTownList: addedTown));
    }
  }

  void _sortAddedTown() {
    if (state is AddedTownListLoaded) {
      (state as AddedTownListLoaded)
          .addedTownList
          .sort((addedTown1, addedTown2) {
        if (addedTown1.isFavorite && addedTown2.isFavorite ||
            !addedTown1.isFavorite && !addedTown2.isFavorite) {
          return addedTown1.weather.townName
              .compareTo(addedTown2.weather.townName);
        } else if (addedTown1.isFavorite) {
          return -1;
        } else {
          return 1;
        }
      });
    }
  }

  void _saveLocalAddedTowns() async {
    if (state is AddedTownListLoaded) {
      localSavesRepository.saveLocalAddedTownsName(
          (state as AddedTownListLoaded).addedTownList);
    }
  }

  void loadLocalAddedTowns() async {
    List<SavedTownModel> savedTownModelList =
        await localSavesRepository.loadLocalAddedTownsName();

    List<AddedTown> addedTownList = [];

    for (var savedTown in savedTownModelList) {
      WeatherNow townWeather =
          await forecastRepository.getNowWeather(savedTown.name);
      addedTownList.add(
          AddedTown(weather: townWeather, isFavorite: savedTown.isFavorite));
    }

    emit(
      AddedTownListLoaded(addedTownList: addedTownList),
    );
  }
}
