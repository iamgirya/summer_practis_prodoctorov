import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:summer_practis_prodoctorov/models/added_town_list.dart';
import 'package:summer_practis_prodoctorov/models/saved_town_model.dart';

abstract class ILocalSavesRepository {
  Future<void> saveLocalAddedTownsName(List<AddedTown> addedTownList);

  Future<List<SavedTownModel>> loadLocalAddedTownsName();
}

class LocalSavesRepository implements ILocalSavesRepository {
  @override
  Future<List<SavedTownModel>> loadLocalAddedTownsName() async {
    final prefs = await SharedPreferences.getInstance();


    if (prefs.containsKey("savedTownNameList")) {
      List<String> savedTownNameJsonList = prefs.getStringList(
          "savedTownNameList")!;
      return [
        for (var i in savedTownNameJsonList) SavedTownModel.fromJson(
            jsonDecode(i))
      ];
    } else {
      return [];
    }
  }

  @override
  Future<void> saveLocalAddedTownsName(List<AddedTown> addedTownList) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList("savedTownNameList", [
      for (var i in addedTownList)
        SavedTownModel(name: i.weather.townName, isFavorite: i.isFavorite)
            .toJson()
    ]);

    prefs.setStringList("favoritesTownName", [
      for (var i in addedTownList)
        if (i.isFavorite) i.weather.townName
    ]);
    prefs.setStringList("notFavoritesTownName", [
      for (var i in addedTownList)
        if (!i.isFavorite) i.weather.townName
    ]);
  }
}
