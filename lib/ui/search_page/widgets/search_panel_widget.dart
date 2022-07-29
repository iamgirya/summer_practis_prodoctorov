import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_practis_prodoctorov/ui/search_page/widgets/search_card_widget.dart';

import '../../../blocs/added_town_list/added_town_list_cubit.dart';
import '../../../blocs/search_town_weather/search_town_weather_cubit.dart';
import '../../../blocs/search_town_weather/search_town_weather_state.dart';
import '../../../core/container_class.dart';

class SearchPanel extends StatefulWidget {
  const SearchPanel({Key? key}) : super(key: key);

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  final TextEditingController controller = TextEditingController();
  late SearchTownWeatherCubit searchTownWeatherCubit;

  void chooseTown() {
    controller.clear();
  }

  @override
  initState() {
    searchTownWeatherCubit =
        SearchTownWeatherCubit(forecastRepository: Cont.forecastRepository);
    searchTownWeatherCubit.initQueryStreamSubscribe(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.pink,
          height: 30,
          child: TextField(
            controller: controller,
          ),
        ),
        BlocBuilder<SearchTownWeatherCubit, WeatherNowListState>(
            bloc: searchTownWeatherCubit,
            builder: (context, state) {
              if (state is WeatherNowListLoading) {
                return SizedBox(
                  height: 50,
                  width: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.cyan[100],
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                );
              } else if (state is WeatherNowListError) {
                return const ColoredBox(
                    color: Colors.red, child: Text("Ошибка, чел"));
              } else if (state is WeatherNowListLoaded) {
                return BlocListener<SearchTownWeatherCubit,
                    WeatherNowListState>(
                  bloc: searchTownWeatherCubit,
                  listener: (context, state) {
                    if (state is WeatherNowListChoosed) {
                      AddedTownListCubit bloc =
                          BlocProvider.of<AddedTownListCubit>(context);
                      bloc.addNewTown(state.data);
                    }
                  },
                  child: Column(
                    children: [
                      for (var item in state.weatherNowList)
                        SearchCard(
                          weatherNow: item,
                          onChooseTown: searchTownWeatherCubit.onChooseTown,
                        )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    searchTownWeatherCubit.close();
    super.dispose();
  }
}
