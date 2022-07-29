import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/days_weather/days_weather_cubit.dart';
import '../../../blocs/days_weather/days_weather_state.dart';
import '../../../core/container_class.dart';

class DaysWeatherList extends StatefulWidget {
  const DaysWeatherList({Key? key, required this.townName}) : super(key: key);

  final String townName;

  @override
  State<DaysWeatherList> createState() => _DaysWeatherListState();
}

class _DaysWeatherListState extends State<DaysWeatherList> {
  late DaysWeatherCubit daysWeatherCubit;

  @override
  void initState() {
    daysWeatherCubit =
        DaysWeatherCubit(forecastRepository: Cont.forecastRepository);
    daysWeatherCubit.updateWeatherDaysForTown(widget.townName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              Icon(Icons.mail),
              Text("5-ти днейный прогноз погоды"),
            ],
          ),
          BlocBuilder<DaysWeatherCubit, DaysWeatherState>(
            bloc: daysWeatherCubit,
            builder: (context, state) {
              if (state is DaysWeatherLoading) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.cyan[100],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                );
              } else if (state is DaysWeatherError) {
                return const Text("Ошибка, чел");
              } else if (state is DaysWeatherLoaded) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: state.weatherDayList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container();
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("${state.weatherDayList[index - 1].day!.day}"),
                            const Icon(Icons.sunny),
                            Text("${state.weatherDayList[index - 1].tempMin}"),
                            Text("${state.weatherDayList[index - 1].tempMax}"),
                          ],
                        ),
                      );
                    }
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 2,
                      color: Colors.grey,
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
