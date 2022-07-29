import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/today_list/today_list_cubit.dart';
import '../../../blocs/today_list/today_list_state.dart';
import '../../../core/container_class.dart';

class TodayWeatherList extends StatefulWidget {
  const TodayWeatherList({Key? key, required this.townName}) : super(key: key);

  final String townName;

  @override
  State<TodayWeatherList> createState() => _TodayWeatherListState();
}

class _TodayWeatherListState extends State<TodayWeatherList> {
  late TodayListCubit todayListCubit;

  @override
  void initState() {
    todayListCubit =
        TodayListCubit(forecastRepository: Cont.forecastRepository);
    todayListCubit.updateTodayListForTown(widget.townName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: BlocBuilder<TodayListCubit, TodayListState>(
          bloc: todayListCubit,
          builder: (context, state) {
            if (state is TodayListLoading) {
              return SizedBox(
                height: 120,
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.cyan[100],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              );
            } else if (state is TodayListLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.weatherHourList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 120,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${state.weatherHourList[index].hour}"),
                          const Icon(Icons.sunny),
                          Text("${state.weatherHourList[index].temp}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text("Ошибка, чел");
            }
          }),
    );
  }
}
