import 'package:crafty_bay/data/model/creat_profile_params.dart';
import 'package:crafty_bay/presentation/state_holders/complete_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/AppLogo.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  TextEditingController firstNameTEController = TextEditingController();
  TextEditingController lastNameTEController = TextEditingController();
  TextEditingController mobileTEController = TextEditingController();
  TextEditingController cityTEController = TextEditingController();
  TextEditingController shippingAddressTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  VerifyOtpController controllerr = Get.find<VerifyOtpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Applogo(),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Complete Profile',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Get started with us with your details',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      controller: firstNameTEController,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: ValidatorMessage),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      controller: lastNameTEController,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: ValidatorMessage),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      controller: mobileTEController,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: ValidatorMessage),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      controller: cityTEController,
                      decoration: const InputDecoration(
                        hintText: 'City',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: ValidatorMessage),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      controller: shippingAddressTEController,
                      decoration: const InputDecoration(
                        hintText: 'Shipping Address',
                      ),
                      textInputAction: TextInputAction.done,
                      maxLines: 4,
                      validator: ValidatorMessage),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<CompleteProfileController>(builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: const CenterCircularProgressIndicator(),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final result = await Get.find<CompleteProfileController>().createProfile(
                                Get.find<VerifyOtpController>().token,
                                  CreateProfileParams(
                                    firstname: firstNameTEController.text.trim(),
                                    lastname: lastNameTEController.text.trim(),
                                    mobile: mobileTEController.text.trim(),
                                    city: cityTEController.text.trim(),
                                    shippingAddress:
                                    shippingAddressTEController.text.trim(),
                                  ),
                              );
                              if (result) {
                                Get.to(() => const MainBottomNavScreen());
                              } else {
                                Get.showSnackbar(
                                  GetSnackBar(
                                    title: 'Can not complete profile',
                                    message: controller.errorMessage,
                                    duration: const Duration(seconds: 3),
                                    isDismissible: true,
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Complete'),
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

  // ignore: non_constant_identifier_names
  String? ValidatorMessage(value) {
    if (value!.isEmpty) {
      return 'Please Enter a valid value!!!!';
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    firstNameTEController.dispose();
    lastNameTEController.dispose();
    mobileTEController.dispose();
    shippingAddressTEController.dispose();
    cityTEController.dispose();
  }
}
