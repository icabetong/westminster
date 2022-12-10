import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 5,
                children: List.generate(locations.length, (index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text(locations[index].name)],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
