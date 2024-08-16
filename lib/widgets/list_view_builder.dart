import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanzmed/helpers/settings.dart';

import '../controllers/orodha_controller.dart';
import '../helpers/remove_slash.dart';
import '../models/orodha_model.dart';
import '../pages/appointment.dart';
import 'address_widget.dart';
import 'single_hospital.dart';

class ListViewBuilder extends StatelessWidget {
  ListViewBuilder({
    super.key,
    required this.allData,
  });
  RxList<OrodhaModel> allData;
  final OrodhaController orodhaController = Get.put(OrodhaController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allData.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        OrodhaModel orodha = allData[index];

        if (index < allData.length) {
          return InkWell(
            onTap: () {
              Get.to(
                SingleHospital(
                  title: allData[index].hospitalName,
                  orodhaData: orodha,
                ),
              );
            },
            child: Container(
              // height: 100,
              width: double.infinity,
              // padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
                top: 10,
              ),
              decoration: BoxDecoration(
                // color: ujauzitoColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppSettings.primaryColor.withOpacity(0.05),
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                          orodha.imageUrl!.contains('ui-avatars.com')
                              ? removeDoubleSlash(orodha.imageUrl
                                  .toString()) // Use the UI Avatar URL directly
                              : orodha.imageUrl.toString(),
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
                          orodha.hospitalName,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        // SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Icon(
                                    BootstrapIcons.geo_alt,
                                    color: Colors.grey,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: AddressWidget(
                                      latitude: orodha.latitude,
                                      longitude: orodha.longitude,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  BootstrapIcons.star_fill,
                                  color: Colors.orange,
                                  size: 12,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  orodha.rate.toString(),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            orodha.isSubscribed
                                ? GestureDetector(
                                    onTap: () {
                                      // go to appointment page
                                      Get.to(Appointments(
                                        appBar: AppBar(
                                          title: const Text(
                                            "bookAppointment",
                                          ),
                                        ),
                                        isHidden: true,
                                        isCategory: false,
                                        hospitalId: orodha.id,
                                      ));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: AppSettings.secondaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        "bookNow",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text('No more data'),
          );
        }
      },
    );
  }
}
