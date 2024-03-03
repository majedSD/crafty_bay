import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final Widget child;
  const Input({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: child,
    );
  }
}