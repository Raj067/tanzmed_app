import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/doctor_controller.dart';
import '../helpers/settings.dart';
import '../widgets/custom_loading.dart';
import '../widgets/filter.dart';
import '../widgets/single_hospital_widget.dart';
import 'doctor_model.dart';

class AppointmentCategory extends StatefulWidget {
  const AppointmentCategory({
    super.key,
    required this.title,
    required this.id,
    this.hospitalId,
  });
  final String title;
  final int id;
  final String? hospitalId;

  @override
  State<AppointmentCategory> createState() => _AppointCategoryState();
}

class _AppointCategoryState extends State<AppointmentCategory> {
  DoctorController doctorController = Get.put(DoctorController());
  // final GetStorage _likedDoctorsBox = GetStorage('likedDoctors');
  final box = GetStorage();

  bool fav = false;
  selectFav() {
    setState(() {
      fav = !fav;
    });
  }

  @override
  void initState() {
    doctorController.fetchDoctorDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(doctorController.filteredDoctors.length);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (widget.id == 5) {
              Get.back();
            } else {
              // Get.offAll(EntryPage());
            }
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppSettings.primaryColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          // systemNavigationBarColor: TwitterColor.black,
          statusBarIconBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const FilterPage(isSpecialist: false, isOrodha: false));
            },
            icon: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon/filter.png'),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => doctorController.isLoadingDoctors.value == true
            ? const Center(child: CustomLoadingDialog())
            : doctorController
                    .filterDoctorsSpecialities(widget.id,
                        hospitalId: widget.hospitalId)
                    .isEmpty
                ? Center(child: Text("noDoctorFound"))
                : ListView.builder(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: doctorController
                        .filterDoctorsSpecialities(widget.id,
                            hospitalId: widget.hospitalId)
                        .length,
                    itemBuilder: (context, index) {
                      DoctorModel doctor =
                          doctorController.filterDoctorsSpecialities(widget.id,
                              hospitalId: widget.hospitalId)[index];

                      return SingleHospitalWidget(doctor: doctor);
                    }),
      ),
    );
  }
}
