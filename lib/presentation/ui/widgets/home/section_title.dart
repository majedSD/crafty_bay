import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SectionTitle({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: const Text(
            "See All",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}