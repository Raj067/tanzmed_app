import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/doctor_controller.dart';
import '../helpers/settings.dart';
import '../models/category.dart';
import '../widgets/home.dart';
import '../widgets/hospital_widget.dart';
import '../widgets/location_widget.dart';

class Appointments extends StatefulWidget {
  const Appointments({
    super.key,
    required this.appBar,
    required this.isHidden,
    required this.isCategory,
    this.hospitalId,
  });
  final PreferredSizeWidget? appBar;
  final bool isHidden;
  final bool isCategory;
  final String? hospitalId;

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  bool fav = false;
  bool isLoading = false;
  DoctorController doctorController = Get.put(DoctorController());
  final box = GetStorage();

  @override
  void initState() {
    doctorController.getDoctors();
    doctorController.fetchDoctorDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: ListView(
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Icon(BootstrapIcons.geo_alt),
                SizedBox(width: 10),
                UserLocation(),
              ],
            ),
          ),
          //.......search button..........
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: GestureDetector(
              onTap: () {
                // Get.to(SearchPage(
                //   firstDay: 0,
                //   hospitalId: widget.hospitalId,
                // ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
                color: Colors.grey.withAlpha(100),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 24,
                        color: AppSettings.primaryColor,
                      ),
                      SizedBox(width: 16),
                      Text(
                        "findDoctor",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          //......Popular Specialists title......
          widget.isCategory == true
              ? Container()
              : const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    "popularSpecialist",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
          const SizedBox(height: 20),
          //......Popular specialists......
          widget.isCategory
              ? Container()
              : SizedBox(
                  height: 105,
                  // color: Colors.green,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    children: List.generate(
                      specialitiesHomeApps(context).length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              AppointmentCategory(
                                id: specialitiesHomeApps(context)[index].id,
                                title:
                                    specialitiesHomeApps(context)[index].name,
                                hospitalId: widget.hospitalId,
                              ),
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              // shape: BoxShape.circle,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: AppSettings.primaryColor, //.withAlpha(50),
                            ),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                  child:
                                      specialitiesHomeApps(context)[index].icon,
                                ),
                                // const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0, 8.0, 4.0),
                                  child: Text(
                                    specialitiesHomeApps(context)[index].name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          widget.isCategory == true
              ? const SizedBox()
              : const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              "featureRecommendedHospital",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 20),
          HospitalWidget(hospitalId: widget.hospitalId),
        ],
      ),
      // drawer: widget.isHidden == false ? const CustomDrower() : null,
      // bottomNavigationBar: widget.isHidden == false ? BottomNavBar() : null,
    );
  }
}
