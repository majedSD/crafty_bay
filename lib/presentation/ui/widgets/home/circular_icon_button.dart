import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  const CircularIconButton({
    super.key,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        radius: 15,
        child: Icon(
          iconData,
          size: 20,
          color: Colors.black54,
        ),
      ),
    );
  }
}