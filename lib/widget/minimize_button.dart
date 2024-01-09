import 'package:flutter/material.dart';

class MinimizeButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onPressed;

  const MinimizeButton({
    required this.isExpanded,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.minimize),
      onPressed: onPressed,
    );
  }
}
