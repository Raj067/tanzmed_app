import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../helpers/settings.dart';
import '../models/doctor_model.dart';

class TimeWidget extends StatefulWidget {
  TimeWidget({
    super.key,
    this.fromTime,
    this.toTime,
    this.isSelectedTime,
    required this.updateTime,
    required this.selectedDate,
    required this.doctor,
  });
  final DoctorModel doctor;
  final TimeOfDay? fromTime;
  final TimeOfDay? toTime;
  final DateTime? selectedDate;
  Function updateTime;
  TimeOfDay? isSelectedTime;

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  // TimeOfDay? isSelected;

  @override
  Widget build(BuildContext context) {
    int val = widget.toTime != null && widget.fromTime != null
        ? (widget.toTime!.hour - widget.fromTime!.hour).abs()
        : 0;

    List<int> available =
        List.generate(val, (index1) => index1 + widget.fromTime!.hour);
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 16,
        itemBuilder: (context, index) {
          int hour = index + 6; // Start from 7:00 AM
          // val

          TimeOfDay timeLabel = TimeOfDay(hour: hour, minute: 0);

          PastAppointment? appointment = widget.doctor.appointments
              .where((e) =>
                  DateTime.tryParse(e.date!) == widget.selectedDate &&
                  formatTime(e.time!).hour == hour)
              .firstOrNull;
          bool isBooked = appointment != null;

          bool isTodayTimePassed = widget.selectedDate != null &&
              widget.selectedDate!.day == DateTime.now().day &&
              timeLabel.hour < TimeOfDay.now().hour;
          if (isTodayTimePassed || isBooked) {
            return Container();
          }
          return GestureDetector(
            onTap: () {
              if (available.contains(timeLabel.hour)) {
                if (isTodayTimePassed) {
                  showUnavailableSnackbar(context);
                } else {
                  setState(() {
                    // widget.isSelectedTime = timeLabel;
                    widget.updateTime(timeLabel);
                    handleTimeSelected(timeLabel);
                  });
                }
              } else {
                showUnavailableSnackbar(context);
              }

              // if (available.contains(timeLabel.hour)) {
              //   setState(() {
              //     // widget.isSelectedTime = timeLabel;
              //     widget.updateTime(timeLabel);
              //     handleTimeSelected(timeLabel);
              //   });
              // } else {
              //   showUnavailableSnackbar(context);
              // }
              // if (timeSlotController.isavailable(
              //     index, newInitialTime, newEndTime)) {
              //   // Deselect previously selected slots
              //   timeSlotController.deselectAllSlots();
              //   // Toggle the selected slot
              //   timeSlotController.toggleSlot(index);
              //   // Call the callback function with the updated timeSelected value
              //   widget.onTimeSelected(timeSelected);
              // } else {
              //   showUnavailableSnackbar(context);
              // }
            },
            child: available.contains(timeLabel.hour) && !isTodayTimePassed
                ? Padding(
                    padding:
                        const EdgeInsets.only(right: 7.0, top: 5, bottom: 5),
                    child: Container(
                      width: 68,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.isSelectedTime != null &&
                                widget.isSelectedTime!.hour == timeLabel.hour
                            ? AppSettings.primaryColor
                            : Color(0xffE1E8ED).withOpacity(
                                available.contains(timeLabel.hour) &&
                                        !isTodayTimePassed
                                    ? 0.9
                                    : 0.4,
                              ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            formatTimeOfDay(timeLabel),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: widget.isSelectedTime != null &&
                                      widget.isSelectedTime!.hour ==
                                          timeLabel.hour
                                  ? Colors.white
                                  : Colors.black.withOpacity(
                                      available.contains(timeLabel.hour) &&
                                              !isTodayTimePassed
                                          ? 0.6
                                          : 0.2,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          );
        },
      ),
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

  void handleTimeSelected(TimeOfDay appointmentTime) {
    final box = GetStorage();
    box.write('appointmentTime', formatTimeOfDay(appointmentTime));
    // print(box.read('appointmentTime'));
  }
}

String formatTimeOfDay(TimeOfDay time) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return DateFormat('h:mm a').format(dateTime);
}

DateTime formatTime(String timeString) {
  // Define the format pattern
  DateFormat format = DateFormat("HH:mm a");

  // Parse the string into a DateTime object
  DateTime dateTime = format.parse(timeString);
  return dateTime;
}
