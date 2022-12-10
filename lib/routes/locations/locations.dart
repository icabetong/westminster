import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';

class Location {
  String locationId;
  String name;
  bool locked;

  Location(this.locationId, this.name, {this.locked = true});

  static List<Location> getLocations(BuildContext context) {
    return [
      Location("home", Translations.of(context).locationHome),
      Location("bus", Translations.of(context).locationBus),
      Location("school", Translations.of(context).locationSchool),
      Location("library", Translations.of(context).locationLibrary),
      Location("gym", Translations.of(context).locationGym),
      Location("hospital", Translations.of(context).locationHospital),
      Location("market", Translations.of(context).locationMarket),
      Location("park", Translations.of(context).locationPark),
      Location("church", Translations.of(context).locationChurch),
      Location("mall", Translations.of(context).locationMall),
    ];
  }
}
