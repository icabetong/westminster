import 'package:flutter/material.dart';
import 'package:westminster/routes/game/game_page.dart';
import 'package:westminster/routes/locations/locations.dart';

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
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: List.generate(locations.length, (index) {
                final Location location = locations[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => GamePage(
                          location: location,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Icon(location.icon), Text(location.name)],
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
