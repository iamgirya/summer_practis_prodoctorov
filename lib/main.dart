import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:summer_practis_prodoctorov/ui/search_page/search_page.dart';
import 'package:summer_practis_prodoctorov/ui/weather_page/weather_page.dart';

import 'core/container_class.dart';
import 'navigation/navigation_controller.dart';

void main() {
  debugRepaintRainbowEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationController = NavigationController();
    return Provider<NavigationController>.value(
      value: navigationController,
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigationController.key,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case Cont.weatherPageRoot:
              return MaterialPageRoute(
                  builder: (_) =>
                      WeatherPage(townName: settings.arguments as String));
          }
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SearchPage(),
      ),
    );
  }
}
