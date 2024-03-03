
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/ui/screen/auth/login_screen.dart';
import 'package:crafty_bay/presentation/ui/screen/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const Logo(width: 115),
            const Spacer(),
            const CircularProgressIndicator(),
            const SizedBox(height: 28),
            Text(
              "Version 1.0",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    splashScreenTimeOut();
  }

  Future<void> splashScreenTimeOut() async {
    await Future.delayed(const Duration(seconds: 2));
    final bool isLoggedIn = await Get.find<AuthController>().isUserLoggedIn();
    if (isLoggedIn) {
      Get.offAll(() => const MainBottomNavScreen());
    } else {
      Get.offAll(const LoginScreen());
    }
  }
}