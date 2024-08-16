import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/doctor_controller.dart';
import '../models/doctor_model.dart';
import 'custom_loading.dart';
import 'single_hospital_widget.dart';

class HospitalWidget extends StatefulWidget {
  const HospitalWidget({super.key, this.hospitalId});
  final String? hospitalId;

  @override
  State<HospitalWidget> createState() => _HospitalWidgetState();
}

class _HospitalWidgetState extends State<HospitalWidget> {
  DoctorController doctorController = Get.put(DoctorController());
  final box = GetStorage();

  @override
  void initState() {
    doctorController.fetchDoctorDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => doctorController.isLoadingDoctors.value == true
          ? const Center(child: CustomLoadingDialog())
          : doctorController
                  .getAllDoctors(hospitalId: widget.hospitalId)
                  .isEmpty
              ? Center(child: Text("Hakuna Daktari yoyote"))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: doctorController
                      .getAllDoctors(hospitalId: widget.hospitalId)
                      .length,
                  itemBuilder: (context, index) {
                    DoctorModel doctor = doctorController.getAllDoctors(
                        hospitalId: widget.hospitalId)[index];
                    Color? backgroundColor = index % 2 == 0
                        ? Colors.white
                        : Color(0xffE1E8ED).withAlpha(100);
                    return Container(
                      color: backgroundColor,
                      child: SingleHospitalWidget(doctor: doctor),
                    );
                  }),
    );
  }
}
