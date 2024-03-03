import 'package:crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double? width;
  final double? height;

  const Logo({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsPath.logo,
      width: width,
      height: height,
    );
  }
}