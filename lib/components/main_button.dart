import 'package:flutter/material.dart';

class MainMenuButton extends StatelessWidget {
  const MainMenuButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  final Function()? onPressed;
  final Widget? icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(alignment: Alignment.centerLeft, child: icon),
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(fontFamily: 'Karla'),
            ),
          )
        ],
      ),
    );
  }
}
