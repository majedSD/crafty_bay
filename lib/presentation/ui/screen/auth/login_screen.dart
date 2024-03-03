
import 'package:crafty_bay/presentation/state_holders/email_input_validation_controller.dart';
import 'package:crafty_bay/presentation/state_holders/send_otp_to_email_controller.dart';
import 'package:crafty_bay/presentation/ui/screen/auth/otp_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailInputTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  const Logo(width: 85),
                  const SizedBox(height: 16),
                  Text(
                    "Welcome Back",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "Please Inter Your Email Address",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailInputTEController,
                    decoration: const InputDecoration(
                      hintText: "Email Address",
                    ),
                    validator: EmailInputValidation.validate,
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<SendOtpToEmailController>(builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final bool result =
                              await controller.sendOtpToEmail(
                                _emailInputTEController.text.trim(),
                              );
                              if (result) {
                                Get.to(
                                      () => OtpScreen(
                                    email: _emailInputTEController.text.trim(),
                                  ),
                                );
                              } else {
                                Get.showSnackbar(GetSnackBar(
                                  title: 'Send OTP failed',
                                  message: controller.errorMessage,
                                  duration: const Duration(seconds: 2),
                                  isDismissible: true,
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                          },
                          child: const Text("Next"),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}