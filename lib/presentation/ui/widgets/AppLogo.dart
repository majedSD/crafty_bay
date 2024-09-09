// ignore: duplicate_ignore
// ignore: file_names

// ignore_for_file: file_names

import 'package:crafty_bay/presentation/ui/utility/imagePath.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Applogo extends StatelessWidget {
  Applogo({super.key, this.height, this.width});

  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImagePath.logo,
      height: height ?? 100,
      width: width ?? 100,
    );
  }
}
