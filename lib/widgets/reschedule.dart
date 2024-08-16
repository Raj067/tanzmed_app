import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tanzmed/widgets/custom_loading.dart';

import '../controllers/appointment_controller.dart';
import '../helpers/settings.dart';
import '../models/appointment_model.dart';
import '../models/doctor_model.dart';
import 'funcs.dart';
import 'network_error.dart';
import 'psychologist_details.dart';
import 'time_widget.dart';

class RescheduleAppointment extends StatefulWidget {
  const RescheduleAppointment({
    super.key,
    required this.doctor,
    required this.date,
    required this.time,
    required this.appointment,
  });
  final DoctorModel doctor;
  final DateTime date;
  final String time;
  final MyAppointmentModel appointment;

  @override
  State<RescheduleAppointment> createState() => _RescheduleAppointmentState();
}

class _RescheduleAppointmentState extends State<RescheduleAppointment> {
  final box = GetStorage();

  DateTime? initialSelectedAppointmentDate;
  AppointmentController appointmentController =
      Get.put(AppointmentController());

  int selectedValue = 2;
  bool isSelectedClicked = false;
  // price calculation var
  int calculatedLivePrice = 0;
  int calculatedHomePrice = 0;
  // DateTime? appointmentDate;

  // initial time
  TimeOfDay? initialTime;
  // end time
  TimeOfDay? endTime;

  TimeOfDay? isSelectedTime;

  rescheduleApi() async {
    Get.back();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const CustomLoadingDialog();
      },
    );
    try {
      await appointmentController.updateAppointment(
        initialSelectedAppointmentDate!,
        formatTimeOfDay(isSelectedTime!),
        widget.appointment.appointmentType,
        widget.appointment.id,
        0,
      );

      Get.back();
      // // Trigger a rebuild of the widget
      // setState(() {});
    } catch (e) {
      Get.bottomSheet(const NetworkErrorMessage());
    }
  }

  @override
  void initState() {
    box.write('appointmentDate', widget.date);
    initialSelectedAppointmentDate = widget.date;
    var schedule = widget.doctor.doctorSchedule
        .where((element) =>
            getDate(element.day, initialSelectedAppointmentDate!) ==
            initialSelectedAppointmentDate)
        .toList()
        .firstOrNull;

    if (schedule != null) {
      initialTime = parseTimeString(schedule.fromDate);
      endTime = parseTimeString(schedule.toDate);
    }
    // initialTime = DateFormat('h:mm a').format(widget.time);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime originalDate =
        DateTime.now(); // Replace this with your original DateTime

    int numberOfDays =
        DateTime(originalDate.year, originalDate.month + 1, 0).day;

    return Container(
      // margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "availableDate",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Color(0xffE1E8ED).withAlpha(100),
                  height: 125,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DatePicker(
                        DateTime.now(),
                        height: 100,
                        deactivatedColor: Color(0xffE1E8ED),
                        daysCount: numberOfDays,
                        activeDates: getNextTwoWeeks(widget
                                .doctor.doctorSchedule
                                .map((e) => e.day)
                                .toList())
                            .toList(),
                        initialSelectedDate: initialSelectedAppointmentDate,
                        selectionColor: AppSettings.primaryColor,
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          setState(() {
                            initialSelectedAppointmentDate = date;
                            // box.read('appointmentTime');
                            box.write('appointmentDate', date.toString());
                            var schedule = widget.doctor.doctorSchedule
                                .where((element) =>
                                    getDate(element.day, date) == date)
                                .toList()
                                .firstOrNull;

                            initialTime = parseTimeString(schedule!.fromDate);
                            endTime = parseTimeString(schedule.toDate);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                widget.doctor.doctorSchedule.isEmpty
                    ? Container()
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "availableTime",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          // TimeWidget
                          TimeWidget(
                              fromTime: initialTime,
                              toTime: endTime,
                              selectedDate: initialSelectedAppointmentDate,
                              isSelectedTime: isSelectedTime,
                              doctor: widget.doctor,
                              updateTime: (timeLabel) {
                                setState(() {
                                  isSelectedTime = timeLabel;
                                });
                              }),
                        ],
                      )
              ],
            ),
          ),

          // const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.red,
                      ),
                      foregroundColor: MaterialStatePropertyAll(
                        Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("noText"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      elevation: MaterialStatePropertyAll(0),
                      backgroundColor: MaterialStatePropertyAll(
                        AppSettings.primaryColor,
                      ),
                      foregroundColor: MaterialStatePropertyAll(
                        Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (isSelectedTime != null) {
                        rescheduleApi();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('please select Time'),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Badili",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
