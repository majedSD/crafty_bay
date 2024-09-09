import 'package:crafty_bay/presentation/ui/screens/reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatReviewScreen extends StatefulWidget {
  const CreatReviewScreen({super.key});

  @override
  State<CreatReviewScreen> createState() => _CreatReviewScreenState();
}

class _CreatReviewScreenState extends State<CreatReviewScreen> {
  TextEditingController firstNameTEController = TextEditingController();
  TextEditingController lastNameTEController = TextEditingController();
  TextEditingController reviewTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Creat Reviews',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: firstNameTEController,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: Validator,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: lastNameTEController,
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: Validator,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: reviewTEController,
                  decoration: const InputDecoration(
                    hintText: 'Write Review',
                  ),
                  textInputAction: TextInputAction.done,
                  maxLines: 8,
                  validator: Validator,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Get.to(const ReviewsScreen());
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  String? Validator(value) {
    if (value!.isEmpty) {
      return 'Enter a valid value';
    }
    return null;
  }
}
