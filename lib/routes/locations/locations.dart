import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';

class Location {
  String locationId;
  String name;
  bool locked;
  IconData icon;

  Location(this.locationId, this.name, this.icon, {this.locked = true});

  static List<Location> getLocations(BuildContext context) {
    return [
      Location(
        "home",
        Translations.of(context).locationHome,
        Icons.home_outlined,
      ),
      Location(
        "bus",
        Translations.of(context).locationBus,
        Icons.directions_bus_outlined,
      ),
      Location(
        "school",
        Translations.of(context).locationSchool,
        Icons.school_outlined,
      ),
      Location(
        "library",
        Translations.of(context).locationLibrary,
        Icons.domain_outlined,
      ),
      Location(
        "gym",
        Translations.of(context).locationGym,
        Icons.fitness_center,
      ),
      Location(
        "hospital",
        Translations.of(context).locationHospital,
        Icons.medical_services_outlined,
      ),
      Location(
        "market",
        Translations.of(context).locationMarket,
        Icons.storefront_outlined,
      ),
      Location(
        "park",
        Translations.of(context).locationPark,
        Icons.nature_people_outlined,
      ),
      Location(
        "church",
        Translations.of(context).locationChurch,
        Icons.church_outlined,
      ),
      Location(
        "mall",
        Translations.of(context).locationMall,
        Icons.local_mall_outlined,
      ),
    ];
  }
}
