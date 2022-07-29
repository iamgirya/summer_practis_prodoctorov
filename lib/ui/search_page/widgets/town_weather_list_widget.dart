import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_practis_prodoctorov/ui/search_page/widgets/town_weather_card_widget.dart';

import '../../../blocs/added_town_list/added_town_list_cubit.dart';
import '../../../blocs/added_town_list/added_town_list_state.dart';

class TownWeatherList extends StatefulWidget {
  const TownWeatherList({Key? key}) : super(key: key);

  @override
  State<TownWeatherList> createState() => _TownWeatherListState();
}

class _TownWeatherListState extends State<TownWeatherList> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AddedTownListCubit addedTownListCubit =
        BlocProvider.of<AddedTownListCubit>(context);

    return BlocBuilder<AddedTownListCubit, AddedTownListState>(
      bloc: addedTownListCubit,
      builder: (context, state) {
        if (state is AddedTownListLoading) {
          return SizedBox(
            height: 120,
            width: 150,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: CircularProgressIndicator(
                backgroundColor: Colors.cyan[100],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          );
        } else if (state is AddedTownListLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: addedTownListCubit.getLengthOfAddedTownList(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Dismissible(
                  key: Key(addedTownListCubit
                      .getWeatherNowModel(index)
                      .weather
                      .townName),
                  onDismissed: (direction) {
                    addedTownListCubit.deleteWeatherNowModel(index);
                  },
                  background: const ColoredBox(
                    color: Colors.blue,
                  ),
                  secondaryBackground: const ColoredBox(
                    color: Colors.red,
                  ),
                  confirmDismiss: (direction) {
                    if (direction.name == "endToStart") {
                      return Future(() => true);
                    } else {
                      addedTownListCubit.changeIsFavoriteTownAndSort(index);
                      return Future(() => false);
                    }
                  },
                  child: TownWeatherCard(
                      town: addedTownListCubit.getWeatherNowModel(index)),
                ),
              );
            },
          );
        } else if (state is AddedTownListCreated) {
          addedTownListCubit.loadLocalAddedTowns();
          return SizedBox(
            height: 120,
            width: 150,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue[100],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ),
          );
        } else {
          return const Text("Ошибка, чел");
        }
      },
    );
  }
}
