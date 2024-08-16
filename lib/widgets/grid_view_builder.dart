import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanzmed/helpers/remove_slash.dart';
import 'package:tanzmed/helpers/settings.dart';

import '../controllers/orodha_controller.dart';
import '../models/orodha_model.dart';
import '../pages/appointment.dart';
import 'address_widget.dart';
import 'single_hospital.dart';

class GridViewBuilder extends StatelessWidget {
  GridViewBuilder({
    super.key,
    required this.allData,
  });
  RxList<OrodhaModel> allData;
  final OrodhaController orodhaController = Get.put(OrodhaController());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 150 / (186),
        ),
        itemCount: allData.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          OrodhaModel orodha = allData[index];

          if (index < allData.length) {
            return Container(
              // height: 200,
              padding: const EdgeInsetsDirectional.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(SingleHospital(
                        title: allData[index].hospitalName,
                        orodhaData: orodha,
                      ));
                    },
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      // width: 170,
                      height: 225,
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 0.5,
                        ),
                        // color: primaryColor,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 115,
                            top: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: AppSettings.primaryColor,
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
                          ),
                          Positioned(
                            left: 10,
                            top: 110,
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                orodha.hospitalName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppSettings.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            right: 10,
                            top: 150,
                            child: Container(
                              width: double
                                  .infinity, // Ensures the Row takes up all available space
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
                          ),
                          Positioned(
                            left: 10,
                            right: 10,
                            top: 167,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                          ),
                          Positioned(
                            left: 10,
                            right: 10,
                            top: 189,
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  orodha.isSubscribed
                                      ? GestureDetector(
                                          onTap: () {
                                            // go to appointment page
                                            Get.to(Appointments(
                                              appBar: AppBar(
                                                title:
                                                    Text(orodha.hospitalName),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
