import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/constants.dart';
import '../widgets/custom_loading.dart';
import '../widgets/network_error.dart';

favouriteFunction(
  BuildContext context, {
  required int favouriteType,
  required int favouriteId,
}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return CustomLoadingDialog();
    },
  );
  final apiClient = ApiClient();

  var data = {
    "favourite_type": favouriteType,
    "favourite_id": favouriteId,
  };
  try {
    var response = await apiClient.post(
      "/api/favourite/create",
      body: data,
    );

    // print("\n\n\nHello world ${response.body} \n\n\n\n");

    if (response.statusCode == 200) {
      Get.back();
    } else {
      Get.back();
      // Handle error
      // Get.bottomSheet(const NetworkErrorMessage());
    }
  } catch (e) {
    // // Handle exceptions that may occur during the request
    Get.back();
    // Handle error
    Get.bottomSheet(const NetworkErrorMessage());
  }
}
