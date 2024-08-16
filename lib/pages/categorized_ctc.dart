import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tanzmed/helpers/settings.dart';
import 'package:tanzmed/widgets/custom_loading.dart';

import '../controllers/orodha_controller.dart';
import '../widgets/filter.dart';
import '../widgets/grid_view_builder.dart';
import '../widgets/list_view_builder.dart';

class CTCCategory extends StatefulWidget {
  const CTCCategory({
    super.key,
    required this.title,
    required this.id,
  });
  final String title;
  final int id;

  @override
  State<CTCCategory> createState() => _CTCCategoryState();
}

class _CTCCategoryState extends State<CTCCategory> {
  bool _isGridView = false;

  final OrodhaController orodhaController = Get.put(OrodhaController());
  final scrollController = ScrollController();
  int page = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    // fetchLocation(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Your state update code here
      orodhaController.isInitialCTCLoading.value = true;
    });
    orodhaController.filterCTCCategory(widget.id, page);
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          GestureDetector(
            onTap: () => Get.to(
              const FilterPage(isSpecialist: true, isOrodha: true),
            ),
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/icon/filter.png',
                  ),
                ),
              ),
            ),
          )
          // IconButton(
          //   onPressed: () {
          //     setState(() {
          //       _isGridView = !_isGridView;
          //     });
          //   },
          //   icon: Icon(_isGridView ? Icons.view_list : Icons.grid_on),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            const SizedBox(height: 20),

            //.......nearest Facilities.......
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "nearestHealthFacility",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isGridView = !_isGridView;
                      });
                    },
                    icon: Icon(
                      _isGridView
                          ? BootstrapIcons.grid_3x3_gap_fill
                          : BootstrapIcons.list_task,
                      color: AppSettings.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  if (orodhaController.isLoadingCTCCategory.value == false)
                    _isGridView
                        ? ListViewBuilder(
                            allData: orodhaController.categorizedCTC,
                          )
                        : GridViewBuilder(
                            allData: orodhaController.categorizedCTC,
                          ),
                  if (orodhaController.isInitialCTCLoading.value == true)
                    const Center(
                      child: CustomLoadingDialog(),
                    ),

                  // show circular progress if load more data
                  if (isLoadingMore)
                    const Center(child: CircularProgressIndicator.adaptive()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// listen to scroll event
  Future<void> _scrollListener() async {
    if (isLoadingMore) return;
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !orodhaController.isLoading.value) {
      setState(() {
        isLoadingMore = true;
      });

      page = page + 1;
      await orodhaController.filterCTCCategory(widget.id, page);
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  // Widget _buildListView() {
  //   return ListView.builder(
  //     itemCount: orodhaController.categorizedCTC.length,
  //     physics: const NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     itemBuilder: (context, index) {
  //       OrodhaModel orodha = orodhaController.categorizedCTC[index];
  //       // FutureBuilder for the getAddress function
  //       Widget addressWidget = FutureBuilder<String>(
  //         future: orodhaController.getAddress(
  //           orodha.latitude,
  //           orodha.longitude,
  //         ),
  //         builder: (context, snapshot) {
  //           if (snapshot.hasError) {
  //             return const Text(
  //               '-',
  //               style: TextStyle(
  //                 color: Colors.grey,
  //                 fontSize: 12,
  //               ),
  //             );
  //           } else {
  //             return Text(
  //               '${snapshot.data}',
  //               style: const TextStyle(
  //                 color: Colors.grey,
  //                 fontSize: 12,
  //               ),
  //               maxLines: 1,
  //               overflow: TextOverflow.ellipsis,
  //             );
  //           }
  //         },
  //       );

  //       if (index < orodhaController.categorizedCTC.length) {
  //         return InkWell(
  //           onTap: () {
  //             Get.to(
  //               SingleHospital(
  //                 title: orodhaController.categorizedCTC[index].hospitalName,
  //                 orodhaData: orodha,
  //               ),
  //             );
  //           },
  //           child: Container(
  //             // height: 100,
  //             width: double.infinity,
  //             // padding: const EdgeInsets.all(10),
  //             margin: const EdgeInsets.only(
  //                 left: 10, right: 10, bottom: 10, top: 10),
  //             decoration: BoxDecoration(
  //               // color: ujauzitoColor.withOpacity(0.2),
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   height: 80,
  //                   width: 80,
  //                   decoration: BoxDecoration(
  //                     color: AppSettings.primaryColor.withOpacity(0.05),
  //                     // shape: BoxShape.circle,
  //                     borderRadius: BorderRadius.circular(20),
  //                     image: DecorationImage(
  //                       image: NetworkImage(
  //                         orodha.imageUrl!.contains('ui-avatars.com')
  //                             ? removeDoubleSlash(orodha.imageUrl
  //                                 .toString()) // Use the UI Avatar URL directly
  //                             : orodha.imageUrl.toString(),
  //                       ),
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(width: 20),
  //                 Expanded(
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         orodha.hospitalName,
  //                         style: const TextStyle(
  //                           fontSize: 16,
  //                         ),
  //                       ),
  //                       // SizedBox(height: 10),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               const Icon(
  //                                 BootstrapIcons.geo_alt,
  //                                 color: Colors.grey,
  //                                 size: 12,
  //                               ),
  //                               const SizedBox(width: 5),
  //                               SizedBox(
  //                                 width:
  //                                     MediaQuery.of(context).size.width / 2.0,
  //                                 child: addressWidget,
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               const Icon(
  //                                 BootstrapIcons.star_fill,
  //                                 color: Colors.orange,
  //                                 size: 12,
  //                               ),
  //                               const SizedBox(width: 5),
  //                               Text(
  //                                 orodha.rate.toString(),
  //                                 style: const TextStyle(
  //                                   color: Colors.grey,
  //                                   fontSize: 12,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                       const SizedBox(height: 10),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         children: [
  //                           orodha.isSubscribed
  //                               ? Container(
  //                                   padding: const EdgeInsets.symmetric(
  //                                       vertical: 5, horizontal: 10),
  //                                   decoration: BoxDecoration(
  //                                     color: AppSettings.secondaryColor,
  //                                     borderRadius: BorderRadius.circular(10),
  //                                   ),
  //                                   child: Text(
  //                                     "bookNow",
  //                                     style: const TextStyle(
  //                                       fontSize: 12,
  //                                       color: Colors.white,
  //                                     ),
  //                                   ),
  //                                 )
  //                               : Container()
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 const SizedBox(height: 10),
  //               ],
  //             ),
  //           ),
  //         );
  //       } else {
  //         return const Center(
  //           child: Text('No more data'),
  //         );
  //       }
  //     },
  //   );
  // }

  // Widget _buildGridView() {
  //   return GridView.builder(
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 2,
  //         mainAxisSpacing: 2,
  //         childAspectRatio: 150 / (186),
  //       ),
  //       itemCount: orodhaController.categorizedCTC.length,
  //       physics: const NeverScrollableScrollPhysics(),
  //       shrinkWrap: true,
  //       itemBuilder: (BuildContext context, int index) {
  //         OrodhaModel orodha = orodhaController.categorizedCTC[index];
  //         // FutureBuilder for the getAddress function
  //         Widget addressWidget = FutureBuilder<String>(
  //           future: orodhaController.getAddress(
  //             orodha.latitude,
  //             orodha.longitude,
  //           ),
  //           builder: (context, snapshot) {
  //             // if (snapshot.connectionState ==
  //             //     ConnectionState.waiting) {
  //             //   return const Text(
  //             //     'Loading...',
  //             //     style: TextStyle(
  //             //       color: Colors.grey,
  //             //       fontSize: 12,
  //             //     ),
  //             //   );
  //             // } else
  //             if (snapshot.hasError) {
  //               return const Text(
  //                 '-',
  //                 style: TextStyle(
  //                   color: Colors.grey,
  //                   fontSize: 12,
  //                 ),
  //               );
  //             } else {
  //               return Text(
  //                 '${snapshot.data}',
  //                 style: const TextStyle(
  //                   color: Colors.grey,
  //                   fontSize: 12,
  //                 ),
  //                 maxLines: 1,
  //                 overflow: TextOverflow.ellipsis,
  //               );
  //             }
  //           },
  //         );

  //         if (index < orodhaController.categorizedCTC.length) {
  //           return Container(
  //             // height: 200,
  //             padding: const EdgeInsetsDirectional.all(8),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 InkWell(
  //                   onTap: () {
  //                     Get.to(SingleHospital(
  //                       title:
  //                           orodhaController.categorizedCTC[index].hospitalName,
  //                       orodhaData: orodha,
  //                     ));
  //                   },
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(20),
  //                   ),
  //                   child: Container(
  //                     // width: 170,
  //                     height: 200,
  //                     decoration: BoxDecoration(
  //                       // shape: BoxShape.circle,
  //                       borderRadius: const BorderRadius.all(
  //                         Radius.circular(10),
  //                       ),
  //                       border: Border.all(
  //                         color: Colors.grey.withOpacity(0.5),
  //                         width: 0.5,
  //                       ),
  //                       // color: primaryColor,
  //                     ),
  //                     child: Stack(
  //                       children: [
  //                         Positioned(
  //                           left: 0,
  //                           right: 0,
  //                           bottom: 100,
  //                           top: 0,
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               // shape: BoxShape.circle,
  //                               borderRadius: const BorderRadius.all(
  //                                 Radius.circular(10),
  //                               ),
  //                               color: AppSettings.primaryColor,
  //                               image: DecorationImage(
  //                                 image: NetworkImage(
  //                                   orodha.imageUrl!.contains('ui-avatars.com')
  //                                       ? removeDoubleSlash(orodha.imageUrl
  //                                           .toString()) // Use the UI Avatar URL directly
  //                                       : orodha.imageUrl.toString(),
  //                                 ),
  //                                 fit: BoxFit.cover,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Positioned(
  //                           left: 10,
  //                           // right: 0,
  //                           top: 110,
  //                           child: Text(
  //                             orodha.hospitalName,
  //                             style: const TextStyle(
  //                               color: AppSettings.primaryColor,
  //                               fontSize: 12,
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                           ),
  //                         ),
  //                         Positioned(
  //                           left: 10,
  //                           right: 10,
  //                           top: 130,
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   const Icon(
  //                                     BootstrapIcons.geo_alt,
  //                                     color: Colors.grey,
  //                                     size: 12,
  //                                   ),
  //                                   const SizedBox(width: 5),
  //                                   SizedBox(
  //                                     width: MediaQuery.of(context).size.width /
  //                                         4.0,
  //                                     child: addressWidget,
  //                                   ),
  //                                 ],
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   const Icon(
  //                                     BootstrapIcons.star_fill,
  //                                     color: Colors.orange,
  //                                     size: 12,
  //                                   ),
  //                                   const SizedBox(width: 5),
  //                                   Text(
  //                                     orodha.rate.toString(),
  //                                     style: const TextStyle(
  //                                       color: Colors.grey,
  //                                       fontSize: 12,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         Positioned(
  //                           left: 10,
  //                           right: 10,
  //                           bottom: 10,
  //                           child: SizedBox(
  //                             child: Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 // Row(
  //                                 //   children: [
  //                                 //     GestureDetector(
  //                                 //       onTap: () {},
  //                                 //       child: Container(
  //                                 //         padding: const EdgeInsets.only(
  //                                 //             right: 10),
  //                                 //         child: const Icon(
  //                                 //           BootstrapIcons.telephone_fill,
  //                                 //           color: secondaryColor,
  //                                 //           size: 18,
  //                                 //         ),
  //                                 //       ),
  //                                 //     ),
  //                                 //     GestureDetector(
  //                                 //       onTap: () {},
  //                                 //       child: Container(
  //                                 //         padding: const EdgeInsets.only(
  //                                 //             right: 10),
  //                                 //         child: const Icon(
  //                                 //           BootstrapIcons.chat_dots_fill,
  //                                 //           color: secondaryColor,
  //                                 //           size: 18,
  //                                 //         ),
  //                                 //       ),
  //                                 //     ),
  //                                 //   ],
  //                                 // ),
  //                                 orodha.isSubscribed
  //                                     ? Container(
  //                                         padding: const EdgeInsets.symmetric(
  //                                             vertical: 5, horizontal: 10),
  //                                         decoration: BoxDecoration(
  //                                           color: AppSettings.secondaryColor,
  //                                           borderRadius:
  //                                               BorderRadius.circular(10),
  //                                         ),
  //                                         child: Text(
  //                                           "bookNow",
  //                                           style: const TextStyle(
  //                                             fontSize: 12,
  //                                             color: Colors.white,
  //                                           ),
  //                                         ),
  //                                       )
  //                                     : Container()
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }
  //         return null;
  //       });
  // }
}
