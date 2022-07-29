import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_practis_prodoctorov/models/added_town_list.dart';

import '../../../core/container_class.dart';
import '../../../navigation/navigation_controller.dart';

class TownWeatherCard extends StatelessWidget {
  const TownWeatherCard({Key? key, required this.town}) : super(key: key);

  final AddedTown town;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.green,
      child: ListTile(
        trailing: town.isFavorite
            ? const Icon(Icons.star)
            : const Icon(Icons.star_border),
        onTap: () {
          context.read<NavigationController>().navigateTo(Cont.weatherPageRoot,
              arguments: town.weather.townName);
        },
        title: Row(
          children: [
            Column(
              children: [
                Text(town.weather.townName),
                Text(town.weather.weatherName),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Text("${town.weather.temp}"),
          ],
        ),
      ),
    );
  }
}
