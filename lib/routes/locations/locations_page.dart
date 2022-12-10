import 'package:flutter/material.dart';
import 'package:westminster/routes/game/game_page.dart';
import 'package:westminster/routes/locations/locations.dart';
import 'package:westminster/shared/theme.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    final List<Location> locations = Location.getLocations(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(locations.length, (index) {
                final Location location = locations[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return GamePage(location: location);
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: WestminsterTheme.primaryContainer.withAlpha(60),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          location.icon,
                          color: WestminsterTheme.onPrimaryContainer,
                        ),
                        const SizedBox(height: WestminsterTheme.normalSpacing),
                        Text(
                          location.name,
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
