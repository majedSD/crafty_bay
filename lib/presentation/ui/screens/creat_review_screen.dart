import 'package:crafty_bay/presentation/state_holders/creat_review_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatReviewScreen extends StatefulWidget {
  CreatReviewScreen({super.key, required this.id});
  int id;
  @override
  State<CreatReviewScreen> createState() => _CreatReviewScreenState();
}

class _CreatReviewScreenState extends State<CreatReviewScreen> {
  TextEditingController ratingTEController = TextEditingController();
  TextEditingController descriptionTEController = TextEditingController();
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
                  controller: ratingTEController,
                  decoration: const InputDecoration(
                    hintText: 'Rating',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: Validator,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: descriptionTEController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
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
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        bool result= await Get.find<CreatReviewController>().postProductReview(
                            body:{
                              "description":descriptionTEController.text.trim(),
                              "product_id":widget.id,
                              "rating":ratingTEController.text.trim()
                            }
                        );
                        if(result){
                          Get.to( ReviewsScreen(productId:widget.id,));
                        }else{
                          Get.showSnackbar(GetSnackBar(
                            title:'Failed',
                            message:'Api call not successful',
                          ));
                        }
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
