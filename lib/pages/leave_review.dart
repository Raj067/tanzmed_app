import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rate/rate.dart';

import '../helpers/constants.dart';
import '../helpers/settings.dart';
import '../models/doctor_model.dart';
import '../widgets/custom_loading.dart';
import '../widgets/network_error.dart';

class LeaveProductReview extends StatefulWidget {
  const LeaveProductReview({super.key, required this.filteredDoctor});
  final DoctorModel filteredDoctor;

  @override
  State<LeaveProductReview> createState() => _LeaveProductReviewState();
}

class _LeaveProductReviewState extends State<LeaveProductReview> {
  final apiClient = ApiClient();

  double rate = 3;
  TextEditingController comment = TextEditingController();
  // /api/doctor-review/submit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "leaveReview",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppSettings.primaryColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          // systemNavigationBarColor: TwitterColor.black,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Center(
            child: Container(
              height: 200,
              width: 200,
              padding: const EdgeInsets.all(40),
              child: Image.asset("assets/images/rate-us.png"),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "yourCommentsAndSuggestionsHelpUsImproveTheServiceQualityBetter",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Rate(
              iconSize: 40,
              color: Colors.orange,
              allowHalf: true,
              allowClear: true,
              initialValue: rate,
              readOnly: false,
              onChange: (value) => {
                // print(value)
                // rate = value
                setState(() {
                  rate = value;
                })
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
            // height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            padding: const EdgeInsets.only(left: 10),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              controller: comment,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "enterYourComment",
                // helperText: 'Helper text',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(0),
            child: ElevatedButton(
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(0),
                backgroundColor:
                    MaterialStatePropertyAll(AppSettings.primaryColor),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              onPressed: () {
                // Get.back();
                sendForm();
              },
              child: const Text("submit"),
            ),
          ),
        ],
      ),
    );
  }

  sendForm() async {
    final data = {
      "comment": comment.text == "" ? "-" : comment.text,
      "rate": rate,
      "doctor_id": widget.filteredDoctor.id
    };
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const CustomLoadingDialog();
      },
    );

    try {
      final response = await apiClient.post(
        "/api/doctor-review/submit",
        body: data,
      );
      if (response.statusCode == 200) {
        Get.back();
        Get.back();
      } else {
        Get.back();
        // Handle error
        Get.bottomSheet(const NetworkErrorMessage());
      }
    } catch (e) {
      // Handle exceptions that may occur during the request
      Get.back();
      // Handle error
      Get.bottomSheet(const NetworkErrorMessage());
    }
  }
}
