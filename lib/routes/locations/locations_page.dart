import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/providers/profile.dart';
import 'package:westminster/routes/game/game_page.dart';
import 'package:westminster/routes/locations/locations.dart';

class LocationPage extends ConsumerStatefulWidget {
  const LocationPage({super.key});

  @override
  ConsumerState<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends ConsumerState<LocationPage> {
  List<String> finishedLocations = [];

  Future<bool?> _confirmReplay() async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(Translations.of(context).dialogConfirmLocationRePlayTitle),
          content:
              Text(Translations.of(context).dialogConfirmLocationRePlayBody),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(Translations.of(context).buttonContinue),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(Translations.of(context).buttonCancel),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onInvokeTap(Location location) async {
    if (finishedLocations.contains(location.locationId)) {
      final confirm = await _confirmReplay() ?? false;
      if (!confirm) return;
    }

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return GamePage(location: location);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(currentProfileProvider);
    finishedLocations = profile != null ? profile.locations : [];

    final List<Location> locations = Location.getLocations(context);
    final lastLocationId =
        finishedLocations.isNotEmpty ? finishedLocations.last : null;
    final lastLocationIndex = locations
        .lastIndexWhere((element) => element.locationId == lastLocationId);

    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).pageLocations),
      ),
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

                return LocationTile(
                  location: location,
                  finished: isFinished,
                  unlocked: isUnlocked,
                  onTap: () => _onInvokeTap(location),
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
  const LocationTile(
      {super.key,
      required this.location,
      required this.finished,
      required this.unlocked,
      required this.onTap});

  final Location location;
  final bool finished;
  final bool unlocked;
  final Function() onTap;

  Color getTileBackgroundColor(BuildContext context) {
    Color background = Theme.of(context).colorScheme.secondary;
    if (finished) {
      return background;
    } else if (unlocked) {
      return background.withAlpha(180);
    } else {
      return background.withAlpha(60);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: unlocked ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: getTileBackgroundColor(context),
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
                    color: unlocked
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    location.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            finished
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: const BorderRadius.only(
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiaryContainer,
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
