import 'package:crafty_bay/data/models/create_profile_params.dart';
import 'package:crafty_bay/presentation/state_holders/complete_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/otp_verification_controller.dart';
import 'package:crafty_bay/presentation/ui/screen/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _shippingAddressTEController =
  TextEditingController();
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
                  const SizedBox(height: 80),
                  const Logo(width: 85),
                  const SizedBox(height: 16),
                  Text(
                    "Complete Profile",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "Get started with us with your details",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _firstNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "First Name",
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter First Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _lastNameTEController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Last Name",
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter Last Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _mobileTEController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Mobile Number",
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter Mobile Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _cityTEController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "City Name",
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter City Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _shippingAddressTEController,
                    maxLines: 5,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      hintText: "Shipping Address",
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter Shipping Address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<CompleteProfileController>(
                        builder: (completeProfileController) {
                          return Visibility(
                            visible: completeProfileController.inProgress == false,
                            replacement: const CenterCircularProgressIndicator(),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final createProfileParams = CreateProfileParams(
                                    firstname: _firstNameTEController.text.trim(),
                                    lastname: _lastNameTEController.text.trim(),
                                    mobile: _mobileTEController.text.trim(),
                                    city: _cityTEController.text.trim(),
                                    shippingAddress:
                                    _shippingAddressTEController.text.trim(),
                                  );
                                  final result =
                                  await Get.find<CompleteProfileController>()
                                      .createProfile(
                                    Get.find<OtpVerificationController>().token,
                                    createProfileParams,
                                  );
                                  if (result) {
                                    Get.offAll(() => const MainBottomNavScreen());
                                  } else {
                                    Get.showSnackbar(GetSnackBar(
                                      title: "Complete Profile Failed!",
                                      message:
                                      completeProfileController.errorMessage,
                                      duration: const Duration(seconds: 2),
                                      isDismissible: true,
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                }
                              },
                              child: const Text("Complete"),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _cityTEController.dispose();
    _shippingAddressTEController.dispose();
    super.dispose();
  }
}