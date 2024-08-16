import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/settings.dart';
import 'timeslot_controller.dart';

// callback function
typedef TimeSelectedCallback = void Function(String? timeSelected);

// ignore: must_be_immutable
class TimeSlotList extends StatefulWidget {
  TimeSlotList({
    super.key,
    required this.endTime,
    required this.initialTime,
    required this.onTimeSelected,
  });
  String initialTime;
  String endTime;
  final TimeSelectedCallback onTimeSelected;

  @override
  State<TimeSlotList> createState() => _TimeSlotListState();
}

class _TimeSlotListState extends State<TimeSlotList> {
  final TimeSlotController timeSlotController = Get.put(TimeSlotController());

  bool isClicked = false;

  String? timeSelected;

  @override
  Widget build(BuildContext context) {
    int newInitialTime = int.parse(widget.initialTime.split(":")[0]);
    int newEndTime = int.parse(widget.endTime.split(":")[0]);

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 12,
      itemBuilder: (context, index) {
        int hour = index + 7; // Start from 7:00 AM
        return Obx(() {
          String timeLabel = (hour % 12 == 0)
              ? '12:00 ${hour < 12 ? 'PM' : 'AM'}'
              : '$hour:00 ${hour < 12 ? 'AM' : 'PM'}';
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  timeSelected = timeLabel;
                });
                if (timeSlotController.isavailable(
                    index, newInitialTime, newEndTime)) {
                  // Deselect previously selected slots
                  timeSlotController.deselectAllSlots();
                  // Toggle the selected slot
                  timeSlotController.toggleSlot(index);
                  // Call the callback function with the updated timeSelected value
                  widget.onTimeSelected(timeSelected);
                } else {
                  showUnavailableSnackbar(context);
                }
              },
              child: Container(
                width: 68,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: timeSlotController.isSlotSelected[index]
                      ? AppSettings.primaryColor
                      : Color(0xffE1E8ED).withOpacity(
                          timeSlotController.isavailable(
                                  index, newInitialTime, newEndTime)
                              ? 0.8
                              : 0.5,
                        ),
                ),
                child: Column(
                  children: [
                    Text(
                      timeLabel,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: timeSlotController.isSlotSelected[index]
                            ? Colors.white
                            : Colors.black.withOpacity(
                                timeSlotController.isavailable(
                                        index, newInitialTime, newEndTime)
                                    ? 1.0
                                    : 0.5,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void showUnavailableSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "doctorUnavailableTime",
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
