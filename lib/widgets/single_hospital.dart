import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rate/rate.dart';
import 'package:tanzmed/helpers/settings.dart';

import '../controllers/orodha_controller.dart';
import '../helpers/remove_slash.dart';
import '../models/orodha_model.dart';
import '../pages/appointment.dart';
import '../pages/my_appointments.dart';
import '../utils/map_widget.dart';
import 'filter.dart';
import 'home.dart';

class SingleHospital extends StatefulWidget {
  const SingleHospital({
    super.key,
    required this.orodhaData,
    required this.title,
  });
  final String title;
  final OrodhaModel orodhaData;

  @override
  State<SingleHospital> createState() => _SingleHospitalState();
}

class _SingleHospitalState extends State<SingleHospital> {
  final OrodhaController orodhaController = OrodhaController();
  // launch phone number
  void launchPhone(String phoneNumber) async {
    // final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    // if (await canLaunchUrl(phoneUri)) {
    //   await launchUrl(phoneUri);
    // } else {
    //   print('Could not launch $phoneUri');
    // }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrodhaModel? orodha = widget.orodhaData;
    // print(orodha.workingHours);
    String todaysWorkingHours = orodha.getTodaysWorkingHours(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            orodha.hospitalName,
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
        ),
        body: Column(
          children: [
            Container(
              height: 370,
              width: double.infinity,
              color: AppSettings.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  singleHospital(),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "availaility",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.timelapse,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            todaysWorkingHours,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(
                      "specialities",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      children: List.generate(
                        orodha.specialities!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              // Get.to(
                              //   HospitaliCategory(
                              //     title: specialitiesHospital(context)[index].name,
                              //   ),
                              // );
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                border: Border.all(color: Colors.white),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color:
                                    AppSettings.primaryColor, //.withAlpha(50),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                        // color: Colors.green,
                                        // image: getSpecialityIcon()
                                        ),
                                    child: getSpecialityIcon(
                                        orodha.specialities![index].id),
                                  ),
                                  // const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Text(
                                      getSpecialityName(
                                          orodha.specialities![index].id),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
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
                  const SizedBox(height: 15),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.green.withOpacity(0.3),
                width: double.infinity,
                child: FacilityLocations(
                  latitude: orodha.latitude,
                  longitude: orodha.longitude,
                  facilityName: orodha.hospitalName,
                ),
              ),
            ),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: orodha.isSubscribed
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        elevation: WidgetStatePropertyAll(0),
                        backgroundColor:
                            WidgetStatePropertyAll(AppSettings.primaryColor),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {
                        Get.to(Appointments(
                          appBar: AppBar(
                            title: Text(widget.title),
                          ),
                          isHidden: true,
                          isCategory: false,
                          hospitalId: orodha.id,
                        ));
                      },
                      child: const Text("bookAppointment"),
                    ),
                  ),
                ],
              )
            : Container());
  }

  Widget getSpecialityIcon(int id) {
    Widget specialityIcon = Container();
    SpecialistsApps? specialistsApps = specialitiesHomeApps(context)
        .firstWhereOrNull((element) => element.id == id);
    if (specialistsApps != null) {
      specialityIcon = specialistsApps.icon;
    }
    return specialityIcon;
  }

  String getSpecialityName(int id) {
    String speciality = "";
    SpecialistsApps? specialistsApps = specialitiesHomeApps(context)
        .firstWhereOrNull((element) => element.id == id);
    if (specialistsApps != null) {
      speciality = specialistsApps.name;
    }
    return speciality;
  }

  Widget singleHospital() {
    return InkWell(
      onTap: () {
        // Get.to(const SingleHospital());
      },
      child: Container(
        // height: 100,
        width: double.infinity,
        // padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        decoration: BoxDecoration(
          // color: ujauzitoColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                // color: ujauzitoColor,
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(
                    widget.orodhaData.imageUrl!.contains('ui-avatars.com')
                        ? removeDoubleSlash(widget.orodhaData.imageUrl
                            .toString()) // Use the UI Avatar URL directly
                        : widget.orodhaData.imageUrl.toString(),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // SizedBox(height: 10),
                  FutureBuilder<String>(
                    future: orodhaController.getAddress(
                      widget.orodhaData.latitude,
                      widget.orodhaData.longitude,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "loading",
                          style: TextStyle(
                            color: Color(0xffE1E8ED),
                            fontSize: 12,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Text(
                          "noAddress",
                          style: TextStyle(
                            color: Color(0xffE1E8ED),
                            fontSize: 12,
                          ),
                        );
                      } else {
                        return Row(
                          children: [
                            const Icon(
                              Icons.navigation_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                            Expanded(
                              child: Text(
                                '${snapshot.data}',
                                style: TextStyle(
                                  color: Color(0xffE1E8ED),
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 10),
                  Rate(
                    iconSize: 16,
                    color: Colors.orange,
                    allowHalf: true,
                    allowClear: true,
                    initialValue: 3.5,
                    readOnly: false,
                    onChange: (value) => {
                      // print(value)
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          launchPhone(widget.orodhaData.contact.toString());
                        },
                        child: Text(
                          widget.orodhaData.contact,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget appBarMethod(BuildContext context) {
  return AppBar(
    // bottom: PreferredSize(
    //   preferredSize: const Size.fromHeight(0.0),
    //   child: Container(
    //     decoration: BoxDecoration(
    //         // ignore: deprecated_member_use
    //         color: Theme.of(context).bottomAppBarTheme.color,
    //         boxShadow: const [
    //           BoxShadow(
    //             color: Colors.black,
    //             blurStyle: BlurStyle.solid,
    //           )
    //         ]),
    //     height: 1.0,
    //   ),
    // ),
    title: const Text(
      "appointments",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          Get.to(const MyAppointmentPage());
        },
        icon: Container(
          height: 20,
          width: 20,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/icon/miadi-appointment-main-topright.png',
              ),
            ),
          ),
        ),
      ),
      IconButton(
        onPressed: () {
          Get.to(const FilterPage(isSpecialist: true, isOrodha: false));
        },
        icon: Container(
          height: 20,
          width: 20,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/icon/filter_blue.png',
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
