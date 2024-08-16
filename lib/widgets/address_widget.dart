import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/orodha_controller.dart';

class AddressWidget extends StatelessWidget {
  final double latitude;
  final double longitude;
  final OrodhaController orodhaController = Get.put(OrodhaController());
  AddressWidget({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: orodhaController.getAddress(
        latitude,
        longitude,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            "noAddress",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            "loading",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          );
        } else {
          return Text(
            '${snapshot.data}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }
      },
    );
  }
}
