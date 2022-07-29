import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_practis_prodoctorov/styles/app_fonts.dart';

import '../../../blocs/weather_now/weather_now_cubit.dart';
import '../../../blocs/weather_now/weather_now_state.dart';
import '../../../core/container_class.dart';

class NowWeather extends StatefulWidget {
  const NowWeather({Key? key, required this.townName}) : super(key: key);

  final String townName;

  @override
  State<NowWeather> createState() => _NowWeatherState();
}

class _NowWeatherState extends State<NowWeather> {
  late WeatherNowCubit weatherNowCubit;

  @override
  void initState() {
    weatherNowCubit =
        WeatherNowCubit(forecastRepository: Cont.forecastRepository);
    weatherNowCubit.updateWeatherNowForTown(widget.townName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Center(
        child: BlocProvider(
          create: (_) => weatherNowCubit,
          child: BlocBuilder<WeatherNowCubit, WeatherNowState>(
            builder: (context, state) {
              if (state is WeatherNowLoading) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.cyan[100],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                );
              } else if (state is WeatherNowLoaded) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.weatherNow.townName,
                      style: AppFontsStyles.title,
                    ),
                    Text(
                      "${state.weatherNow.temp}",
                      style: AppFontsStyles.mainTemp,
                    ),
                    Text(
                      state.weatherNow.weatherName,
                      style: AppFontsStyles.body,
                    ),
                  ],
                );
              } else {
                return const Text("Ошибка, чел");
              }
            },
          ),
        ),
      ),
    );
  }
}
