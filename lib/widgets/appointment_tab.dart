// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tanzmed/helpers/settings.dart';
import 'package:tanzmed/widgets/custom_loading.dart';
import 'package:tanzmed/widgets/network_error.dart';

import '../controllers/appointment_controller.dart';
import '../controllers/doctor_controller.dart';
import '../models/appointment_model.dart';
import '../models/doctor_model.dart';
import '../pages/leave_review.dart';
import 'home.dart';
import 'psychologist_details.dart';
import 'reschedule.dart';

// import 'package:videosdk/videosdk.dart';

class SingleAppointmentWidget extends StatefulWidget {
  const SingleAppointmentWidget({
    super.key,
    required this.appointmentData,
    required this.status,
  });
  final MyAppointmentModel appointmentData;
  final int status;

  @override
  State<SingleAppointmentWidget> createState() =>
      _SingleAppointmentWidgetState();
}

class _SingleAppointmentWidgetState extends State<SingleAppointmentWidget> {
  AppointmentController appointmentController =
      Get.put(AppointmentController());

  DoctorController doctorController = Get.put(DoctorController());

  bool isLive = false;

  String goLive = "GO LIVE";

  fetchFunc() async {
    // var statusText = await checkMeetingStatus(widget.appointmentData.meetingId);
    // print("\n\n\n\n");
    // print(statusText);

    // if (widget.appointmentData.meetingId.isNotEmpty) {
    //   setState(() {
    //     if (statusText != "ended") {
    //       isLive = true;
    //     }
    //     // goLive = v;
    //   });

    // print("\n\n\nHello World\n\n$isLive\n\n\n");
    // }
  }

  @override
  Widget build(BuildContext context) {
    int customStatus = widget.appointmentData.status;
    // if (widget.status == 1 && widget.appointmentData.status != 1) {
    //   customStatus = 1;
    // }

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(100),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // ElevatedButton(onPressed: (){fetchFunc();}, child: Text(goLive)),
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: AppSettings.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.appointmentData.doctorAvatar.isEmpty
                          ? "https://ui-avatars.com/api/?name=${widget.appointmentData.doctorName}&rounded=true&background=random"
                          : "${AppSettings.baseUrl}/avatars/${widget.appointmentData.doctorAvatar}",
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.appointmentData.doctorName,
                        ),
                        const SizedBox(
                          height: 16,
                          child: VerticalDivider(
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.appointmentData.hospitalName,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      getSpecialityName(),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: widget.status == 2
                                      ? Colors.red
                                      : AppSettings.primaryColor,
                                ),
                              ),
                              child: Text(
                                widget.status == 0
                                    ? "upcoming"
                                    : widget.status == 1
                                        ? "completed"
                                        : "cancelled",
                                style: TextStyle(
                                  color: widget.status == 2
                                      ? Colors.red
                                      : AppSettings.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: AppSettings.primaryColor),
                            ),
                            child: Image.asset(
                              widget.appointmentData.meetingId.isEmpty
                                  ? (widget.appointmentData.appointmentType) ==
                                          1
                                      ? 'assets/home/facility.png'
                                      : 'assets/icon/home-icon-silhouette.png'
                                  : 'assets/images/video-conference.png',
                              height: 22,
                              width: 22,
                            ),
                          ),
                          if (widget.appointmentData.meetingId.isNotEmpty &&
                              isLive)
                            GestureDetector(
                              onTap: () {
                                // Get.to(SpeakerJoinScreen(
                                //   customMeetingId:
                                //       widget.appointmentData.meetingId,
                                //   duration: widget.appointmentData.duration,
                                // ));
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "GO LIVE",
                                  style: TextStyle(
                                    color: AppSettings.secondaryColor,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat('MMM d yyyy').format(
                              widget.appointmentData.date ??
                                  widget.appointmentData.opdDate!),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                          child: VerticalDivider(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          widget.appointmentData.time,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 10),
                        customStatus == 0
                            ? Icon(
                                Icons.circle,
                                size: 10,
                                color: widget.appointmentData.isCompleted == 0
                                    ? Colors.orange
                                    : widget.appointmentData.isCompleted == 1
                                        ? AppSettings.secondaryColor
                                        : Colors.red,
                              )
                            : customStatus == 1
                                ? const Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: AppSettings.primaryColor,
                                  )
                                : customStatus == 2
                                    ? const Icon(
                                        Icons.circle,
                                        size: 10,
                                        color: Colors.red,
                                      )
                                    : Container(),
                        const SizedBox(width: 5),
                        Expanded(
                          child: customStatus == 0
                              ? widget.appointmentData.appointmentType == 0
                                  ? Text(
                                      "${widget.appointmentData.duration} mins",
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : Text(
                                      widget.appointmentData.isCompleted == 0
                                          ? "notConfirmed"
                                          : widget.appointmentData
                                                      .isCompleted ==
                                                  1
                                              ? "confirmed"
                                              : "cancelled",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                              : customStatus == 1
                                  ? const Text(
                                      "confirmed",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  : customStatus == 2
                                      ? const Text(
                                          "cancelled",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        )
                                      : Container(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          widget.status == 2
              ? Container()
              : Divider(
                  color: Colors.grey.withOpacity(0.5),
                  thickness: 0.5,
                ),
          widget.status == 2
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (customStatus == 0) {
                          DoctorModel filteredDoctor =
                              doctorController.allDoctors.firstWhere(
                            (doc) => doc.id == widget.appointmentData.doctorId,
                          );
                          // get the first available day of a doctor
                          // String keyValue = 'available_day';
                          // List<DateTime>? dateTimeList = extractDates(
                          //     filteredDoctor.doctorSchedule, keyValue);
                          // redirect to reschedule the appointment
                          // ----
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: RescheduleAppointment(
                                doctor: filteredDoctor,
                                date: widget.appointmentData.date ??
                                    widget.appointmentData.opdDate!,
                                appointment: widget.appointmentData,
                                time: widget.appointmentData.time,
                              ),
                            ),
                          );

                          // Get.to(PsychologistPage(
                          //   doctor: filteredDoctor,
                          //   // firstDay: dateTimeList.isEmpty
                          //   //     ? 0
                          //   //     : dateTimeList.first.day,
                          // ));
                        } else {
                          DoctorModel filteredDoctor =
                              doctorController.allDoctors.firstWhere(
                            (doc) => doc.id == widget.appointmentData.doctorId,
                          );
                          Get.to(LeaveProductReview(
                              filteredDoctor: filteredDoctor));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppSettings.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppSettings.primaryColor),
                        ),
                        child: Text(
                          customStatus == 0 ? "reschedule" : "leaveReview",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // String location = box.read('user_location');
                        if (customStatus == 0) {
                          // cancel widget
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              // title: const Text("Error"),
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "onCancelAppointmentText",
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            style: const ButtonStyle(
                                              elevation:
                                                  WidgetStatePropertyAll(0),
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                Colors.grey,
                                              ),
                                              foregroundColor:
                                                  WidgetStatePropertyAll(
                                                Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text(
                                              "noText",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: const ButtonStyle(
                                              elevation:
                                                  WidgetStatePropertyAll(0),
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                Colors.red,
                                              ),
                                              foregroundColor:
                                                  WidgetStatePropertyAll(
                                                Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              appointmentController
                                                  .allAppointments
                                                  .remove(
                                                      widget.appointmentData);
                                              cancel();
                                            },
                                            child: const Text("yesText"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          // cancel();
                        } else {
                          DoctorModel filteredDoctor =
                              doctorController.allDoctors.firstWhere(
                            (doc) => doc.id == widget.appointmentData.doctorId,
                          );

                          // get the first available day of a doctor
                          // String keyValue = 'available_day';
                          // List<DateTime>? dateTimeList = extractDates(
                          //     filteredDoctor.doctorSchedule, keyValue);
                          // redirect to reschedule the appointment
                          // -------------------------
                          Get.to(PsychologistPage(
                            doctor: filteredDoctor,
                          ));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppSettings.primaryColor),
                        ),
                        child: Text(
                          customStatus == 0 ? "cancel" : "bookAgain",
                          style: const TextStyle(
                            color: AppSettings.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  String getSpecialityName() {
    String speciality = "";
    SpecialistsApps? specialistsApps = specialitiesHomeApps(context)
        .firstWhereOrNull((element) =>
            element.id.toString() == widget.appointmentData.specialist);
    if (specialistsApps != null) {
      speciality = specialistsApps.name;
    }
    return speciality;
  }

  void cancel() async {
    Get.back();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const CustomLoadingDialog();
      },
    );
    try {
      await appointmentController.cancelAppointment(
        widget.appointmentData.date ?? widget.appointmentData.opdDate!,
        widget.appointmentData.time,
        widget.appointmentData.appointmentType,
        widget.appointmentData.id,
        2,
      );
      // appointmentController.allAppointments.remove(widget.appointmentData);
      // await appointmentController.fetchAppointments();
      Get.back();
      // // Trigger a rebuild of the widget
      // setState(() {});
    } catch (e) {
      Get.bottomSheet(const NetworkErrorMessage());
    }
  }
}
