import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/appointment_controller.dart';
import '../controllers/doctor_controller.dart';
import '../models/appointment_model.dart';
import '../widgets/appointment_tab.dart';
import '../widgets/custom_loading.dart';

class MyAppointmentPage extends StatefulWidget {
  const MyAppointmentPage({super.key});

  @override
  State<MyAppointmentPage> createState() => _MyAppointmentPageState();
}

class _MyAppointmentPageState extends State<MyAppointmentPage> {
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  DoctorController doctorController = Get.put(DoctorController());
  final box = GetStorage();

  // bool _dataLoaded = false;
  @override
  void initState() {
    appointmentController.fetchAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Get.to(EntryPage());
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "myAppointments",
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurStyle: BlurStyle.solid,
                )
              ],
            ),
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                body: Column(
                  children: [
                    const TabBar(
                      labelPadding: EdgeInsets.all(0),
                      dividerHeight: 0,
                      tabs: [
                        Tab(text: "upcoming"),
                        Tab(text: "pastAppointment"),
                        Tab(text: "cancelled"),
                      ],
                    ),
                    Expanded(
                      child: Obx(
                        () => !appointmentController.isLoadingAppointment.value
                            ? const TabBarView(
                                children: [
                                  SingleTabView(status: 0),
                                  SingleTabView(status: 1),
                                  SingleTabView(status: 2),
                                ],
                              )
                            : const Center(
                                child: CustomLoadingDialog(),
                                //  CircularProgressIndicator(),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SingleTabView extends StatefulWidget {
  const SingleTabView({super.key, required this.status});
  final int status;

  @override
  State<SingleTabView> createState() => _SingleTabViewState();
}

class _SingleTabViewState extends State<SingleTabView> {
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  @override
  void initState() {
    appointmentController.fetchAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<MyAppointmentModel> filteredAppointments = appointmentController
          .allAppointments
          .where((appointment) => appointment.status == widget.status)
          .toList();
      if (widget.status == 0) {
        filteredAppointments = filteredAppointments.where((element) {
          DateTime? date = element.date ?? element.opdDate;

          DateTime newDate = date!.add(const Duration(days: 1));
          return DateTime.now().difference(newDate).inHours <= 0;
        }).toList();
      }
      if (widget.status == 1) {
        filteredAppointments =
            appointmentController.allAppointments.where((element) {
          DateTime? date = element.date ?? element.opdDate;

          DateTime newDate = date!.add(const Duration(days: 1));
          return (DateTime.now().difference(newDate).inHours >= 0 &&
                  element.status == 0) ||
              element.status == widget.status;
        }).toList();
      }
      return filteredAppointments.isEmpty
          ? const Center(
              child: Text("noAppointmentFound"),
            )
          : ListView.builder(
              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredAppointments.length,
              itemBuilder: (context, index) {
                final MyAppointmentModel appointmentData =
                    filteredAppointments[index];
                // SingleAppointmentWidget
                return SingleAppointmentWidget(
                  appointmentData: appointmentData,
                  status: widget.status,
                );
              });
    });
  }
}
