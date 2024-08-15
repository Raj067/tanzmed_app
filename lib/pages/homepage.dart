import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanzmed/helpers/settings.dart';
import 'package:tanzmed/pages/ctc_centers.dart';
import 'package:tanzmed/pages/risk_assessment.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Homepage"),
      ),
      // body: ListView(
      //   padding: const EdgeInsets.symmetric(horizontal: 16),
      //   children: [
      //     const Text("Hello World"),
      //     Row(
      //       children: [
      //         Expanded(
      //           child: ElevatedButton(
      //             style: const ButtonStyle(
      //               elevation: WidgetStatePropertyAll(0),
      //               backgroundColor: WidgetStatePropertyAll(
      //                 AppSettings.primaryColor,
      //               ),
      //               foregroundColor: WidgetStatePropertyAll(
      //                 Colors.white,
      //               ),
      //             ),
      //             onPressed: () {},
      //             child: const Text("Risk Assessment"),
      //           ),
      //         ),
      //         const SizedBox(width: 20),
      //         Expanded(
      //           child: ElevatedButton(
      //             style: const ButtonStyle(
      //               elevation: WidgetStatePropertyAll(0),
      //               backgroundColor: WidgetStatePropertyAll(
      //                 AppSettings.secondaryColor,
      //               ),
      //               foregroundColor: WidgetStatePropertyAll(
      //                 Colors.white,
      //               ),
      //             ),
      //             onPressed: () {},
      //             child: const Text("CTC Centers"),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: Platform.isIOS ? 20 : 8,
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(
                    AppSettings.primaryColor,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    Colors.white,
                  ),
                ),
                onPressed: () {
                  Get.to(const RiskAssessment());
                },
                child: const Text("Risk Assessment"),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton(
                style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(
                    AppSettings.secondaryColor,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    Colors.white,
                  ),
                ),
                onPressed: () {
                  Get.to(const CTCCenters());
                },
                child: const Text("CTC Centers"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
