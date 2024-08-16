import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rate/rate.dart';

import '../helpers/remove_slash.dart';
import '../helpers/settings.dart';
import '../models/doctor_model.dart';
import '../utils/favourite.dart';
import '../utils/format_money.dart';
import 'home.dart';

class SingleHospitalWidget extends StatefulWidget {
  const SingleHospitalWidget({super.key, required this.doctor});
  final DoctorModel doctor;

  @override
  State<SingleHospitalWidget> createState() => _SingleHospitalWidgetState();
}

class _SingleHospitalWidgetState extends State<SingleHospitalWidget> {
  final box = GetStorage();
  int langProficiency = 1;

  @override
  Widget build(BuildContext context) {
    // print(widget.doctor.langProficiency);
    // perform is liked
    bool isLiked =
        box.read("doctor-${widget.doctor.user.id.toString()}") ?? false;
    // String keyValue = 'available_day';
    // List<DateTime>? dateTimeList =
    //     extractDates(widget.doctor.doctorSchedule, keyValue);
    return InkWell(
      onTap: () {
        // if (box.read("access_token") == null) {
        //   Get.to(const LoginPage());
        // } else {
        //   Get.to(PsychologistPage(
        //     doctor: widget.doctor,
        //   ));
        // }
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
            Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppSettings.primaryColor.withOpacity(0.05),
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.doctor.user.image!.contains('ui-avatars.com')
                            ? removeDoubleSlash(widget.doctor.user.image
                                .toString()) // Use the UI Avatar URL directly
                            : widget.doctor.user.image.toString(),
                      ),
                    ),
                  ),
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
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    buildFlagContainer('assets/microphone.png'),
                    SizedBox(width: 5),
                    Text(
                      widget.doctor.langProficiency == 1
                          ? 'Kisw'
                          : widget.doctor.langProficiency == 2
                              ? ' | Eng'
                              : widget.doctor.langProficiency == 0
                                  ? 'Kisw'
                                  : 'Kisw | Eng',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.doctor.user.fullName ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (box.read("access_token") == null) {
                              // Get.to(const LoginPage());
                            } else {
                              favouriteFunction(context,
                                  favouriteId: widget.doctor.user.id,
                                  favouriteType: 0);
                              setState(() {
                                isLiked = !isLiked;
                                box.write(
                                    "doctor-${widget.doctor.user.id.toString()}",
                                    isLiked);
                              });
                            }
                          },
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: AppSettings.primaryColor,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      buildFlagContainer('assets/professional.png'),
                      SizedBox(width: 5),
                      Text(
                        widget.doctor.salutation ?? '',
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppSettings.primaryColor.withOpacity(0.05),
                    ),
                    child: Text(
                      getSpecialityName(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  // sizedBoxH7,
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        BootstrapIcons.geo_alt,
                        size: 12,
                      ),
                      // sizedBoxW7,
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          widget.doctor.user.docAddress != null
                              ? '${widget.doctor.user.docAddress?.region.name}, ${widget.doctor.user.docAddress?.district.name}'
                              : '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  // sizedBoxH7,
                  Row(
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          // color: ujauzitoColor,
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(3),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.doctor.hospital.image
                                      .contains('ui-avatars.com')
                                  ? removeDoubleSlash(widget
                                      .doctor.hospital.image
                                      .toString()) // Use the UI Avatar URL directly
                                  : widget.doctor.hospital.image.toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                          // image: DecorationImage(
                          //   fit: BoxFit.cover,
                          //   // image: AssetImage(
                          //   //   "assets/images/lab.png",
                          //   // ),
                          //   image: NetworkImage(
                          //     widget.doctor.hospital.image,
                          //   ),
                          // ),
                          color: AppSettings.primaryColor.withOpacity(
                            0.05,
                          ),
                        ),
                      ),
                      SizedBox(width: 7),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Text(
                          widget.doctor.hospital.hospitalName ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),
                  Row(
                    children: [
                      if (widget.doctor.live_call_price != null &&
                          widget.doctor.live_call_price != 0)
                        singleRowData(
                            "${formatMoney(widget.doctor.live_call_price)}/15 mins",
                            "assets/images/video-conference.png"),
                      const SizedBox(width: 20),
                      if (widget.doctor.home_visit_price != null &&
                          widget.doctor.home_visit_price != 0)
                        singleRowData(
                            formatMoney(widget.doctor.home_visit_price),
                            "assets/icon/home-icon-silhouette.png"),
                      if (widget.doctor.hospital.isSubscribed == 1)
                        singleRowData('', "assets/home/facility.png"),
                    ],
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Container buildFlagContainer(String imageAsset) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imageAsset),
        ),
        color: AppSettings.primaryColor.withOpacity(0.05),
      ),
    );
  }

  Widget singleRowData(String title, String icon) {
    return Expanded(
      child: Row(
        children: [
          Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              // color: ujauzitoColor,
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  icon,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String getSpecialityName() {
    String speciality = "";
    SpecialistsApps? specialistsApps = specialitiesHomeApps(context)
        .firstWhereOrNull(
            (element) => element.id == widget.doctor.specialist.id);
    if (specialistsApps != null) {
      speciality = specialistsApps.name;
    }
    return speciality;
  }
}
