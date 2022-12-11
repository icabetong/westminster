import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/providers/profile.dart';
import 'package:westminster/routes/game/game_page.dart';
import 'package:westminster/routes/locations/locations.dart';
import 'package:westminster/shared/theme.dart';

class LocationPage extends ConsumerStatefulWidget {
  const LocationPage({super.key});

  @override
  ConsumerState<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends ConsumerState<LocationPage> {
  List<String> finishedLocations = [];

  @override
  void initState() {
    super.initState();

    final profile = ref.read(currentProfileProvider);
    if (profile != null) finishedLocations = profile.locations;
  }

  @override
  Widget build(BuildContext context) {
    final List<Location> locations = Location.getLocations(context);
    final lastLocationId =
        finishedLocations.isNotEmpty ? finishedLocations.last : null;
    final lastLocationIndex = locations
        .lastIndexWhere((element) => element.locationId == lastLocationId);

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
                final location = locations[index];
                final isFinished =
                    finishedLocations.contains(location.locationId);
                final isUnlocked = isFinished || index == lastLocationIndex + 1;

                debugPrint(finishedLocations.length.toString());
                return LocationTile(
                  location: location,
                  finished: isFinished,
                  unlocked: isUnlocked,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationTile extends StatelessWidget {
  const LocationTile({
    super.key,
    required this.location,
    required this.finished,
    required this.unlocked,
  });

  final Location location;
  final bool finished;
  final bool unlocked;

  Color getTileBackgroundColor() {
    Color background = WestminsterTheme.primaryContainer.withAlpha(60);
    if (finished) {
      return background;
    } else if (unlocked) {
      return background.withAlpha(120);
    } else {
      return background.withAlpha(20);
    }
  }

  void _onInvokeTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return GamePage(location: location);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: unlocked ? () => _onInvokeTap(context) : null,
      child: Container(
        decoration: BoxDecoration(
          color: getTileBackgroundColor(),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    unlocked ? location.icon : Icons.lock_outline_rounded,
                    color: WestminsterTheme.onPrimaryContainer,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    location.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            finished
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: WestminsterTheme.tertiaryContainer,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          Translations.of(context).feedbackFinished,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: WestminsterTheme.onTertiaryContainer,
                                  ),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
