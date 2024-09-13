import 'dart:async';
import 'package:crafty_bay/presentation/state_holders/read_profile_data_controller.dart';
import 'package:crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/AppLogo.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class VerifyOtpScreen extends StatefulWidget {
  VerifyOtpScreen({super.key, required this.email});

  String? email;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController pinCodeTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ReadProfileDataController readProfileDataController=Get.find<ReadProfileDataController>();
  VerifyOtpController verifyOtpController=Get.find<VerifyOtpController>();
  int count = 120;
  String? currentText;

  @override
  void initState() {
    super.initState();
    timeCount();
  }

  void timeCount() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        count == 0 ? count : count--;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Applogo(),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Enter OTP Code',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'A 4 digit Otp code has been sent',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PinCodeTextField(
                    controller: pinCodeTEController,
                    length: 6,
                    obscureText: false,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldOuterPadding: const EdgeInsets.all(8),
                        fieldHeight: 40,
                        fieldWidth: 40,
                        activeFillColor: Colors.transparent,
                        selectedFillColor: Colors.transparent,
                        inactiveColor: AppColors.primaryColor,
                        selectedColor:Colors.purple,
                    ),
                    mainAxisAlignment: MainAxisAlignment.center,
                    onChanged: (value) {
                      setState(() {
                        currentText = value;
                      });
                    },
                    appContext: (context),
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child:
                        GetBuilder<VerifyOtpController>(builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress == false,
                        replacement: const CenterCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool result = await controller.otpVerification(
                                  widget.email ?? '',
                                  pinCodeTEController.text);
                              if (result) {
                                if (controller.shouldNavigateCompleteProfile) {
                                  Get.offAll(() => const CompleteProfileScreen());
                                } else {
                                  Get.offAll(() => const MainBottomNavScreen());
                                }
                              } else {
                                Get.showSnackbar(
                                  GetSnackBar(
                                    title: 'Otp verification failed',
                                    message: controller.errorMessage,
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Next'),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'This code will be expire in ',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                              text: '$count',
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                              )),
                        ]),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextButton(
                    onPressed: () {

                    },
                    child: count ==0
                        ? const Text(
                            'Resend Code',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )
                        : const Text('Resend Code'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
