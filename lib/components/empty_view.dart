import 'package:flutter/material.dart';
import 'package:westminster/shared/theme.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.title,
    required this.summary,
    this.icon,
  });

  final String title;
  final String summary;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: WestminsterTheme.normalPadding,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon ?? Container(),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22.0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            summary,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
