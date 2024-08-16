import 'package:get/get.dart';

import 'doctor_controller.dart';

class TimeSlotController extends GetxController {
  final DoctorController doctorController = Get.put(DoctorController());

  RxList<bool> isSlotSelected = List.generate(12, (index) => false).obs;
  int? startavailableHour = 0;
  int? endavailableHour = 0;

  @override
  void onInit() {
    super.onInit();
    // Initialize 7:00 AM as selected by default
    toggleSlot(0);
  }

  void toggleSlot(int index) {
    if (isavailable(index, startavailableHour, endavailableHour)) {
      return; // Do nothing if the slot is within the unavailable range
    }
    isSlotSelected[index] = !isSlotSelected[index];
  }

  bool isavailable(int hour, startavailableHour, endavailableHour) {
    return hour >= startavailableHour && hour <= endavailableHour;
  }

  void deselectAllSlots() {
    for (int i = 0; i < isSlotSelected.length; i++) {
      isSlotSelected[i] = false;
    }
  }
}
