import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:westminster/providers/profile.dart';
import 'package:westminster/routes/profile/profile.dart';
import 'package:westminster/routes/profile/profile_editor_page.dart';

class ProfileListPage extends ConsumerStatefulWidget {
  const ProfileListPage({super.key});

  @override
  ConsumerState<ProfileListPage> createState() => _ProfileListPageState();
}

class _ProfileListPageState extends ConsumerState<ProfileListPage> {
  Future<bool?> _confirmRemove() async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translations.of(context).dialogRemoveProfileTitle),
          content: Text(Translations.of(context).dialogRemoveProfileBody),
          actions: <Widget>[
            TextButton(
              child: Text(Translations.of(context).buttonRemove),
              onPressed: () => Navigator.pop(context, true),
            ),
            TextButton(
              child: Text(Translations.of(context).buttonCancel),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
  }

  void _onInvokeAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const ProfileEditorPage(),
      ),
    );
  }

  Future<void> _onInvokeRemove(Profile profile) async {
    final confirm = await _confirmRemove() ?? false;

    if (confirm) {
      final profileNotifier = ref.read(profileListProvider.notifier);
      profileNotifier.remove(profile);
    }
  }

  void _onInvokeTap(Profile profile) {
    final currentProfile = ref.read(currentProfileProvider.notifier);
    currentProfile.change(profile);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final profiles = ref.watch(profileListProvider);
    final currentProfile = ref.watch(currentProfileProvider);

    return Scaffold(
      appBar: AppBar(title: Text(Translations.of(context).pageProfiles)),
      body: ListView.builder(
        itemCount: profiles.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final profile = profiles[index];
          final isCurrent = profile.profileId == currentProfile?.profileId;

          return ListTile(
            selected: isCurrent,
            title: Text(profile.name),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _onInvokeRemove(profile),
            ),
            onTap: () => _onInvokeTap(profile),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onInvokeAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}
