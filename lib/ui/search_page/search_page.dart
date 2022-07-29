import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_practis_prodoctorov/styles/app_fonts.dart';

import '../../blocs/added_town_list/added_town_list_cubit.dart';
import '../../core/container_class.dart';
import 'widgets/search_panel_widget.dart';
import 'widgets/town_weather_list_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        lazy: false,
        create: (context) {
          var addedTownListCubit = AddedTownListCubit(
              forecastRepository: Cont.forecastRepository,
              localSavesRepository: Cont.localSavesRepository);
          return addedTownListCubit;
        },
        child: Container(
          constraints: BoxConstraints(
              minHeight: Size.infinite.height, minWidth: Size.infinite.width),
          color: Colors.black,
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 46.0, left: 16.0, right: 16.0),
              child: ListView(
                children: [
                  const Text(
                    "Погода",
                    style: AppFontsStyles.mainTemp,
                  ),
                  Stack(
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 30),
                        child: const TownWeatherList(),
                      ),
                      const SearchPanel(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
