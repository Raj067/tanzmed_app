import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tanzmed/helpers/settings.dart';

import '../controllers/orodha_controller.dart';
import '../widgets/custom_loading.dart';
import '../widgets/grid_view_builder.dart';
import '../widgets/list_view_builder.dart';
import '../widgets/orodha_app.dart';
import 'categorized_ctc.dart';

class JifunzeZaidi extends StatefulWidget {
  const JifunzeZaidi({super.key});

  @override
  State<JifunzeZaidi> createState() => _JifunzeZaidiState();
}

class _JifunzeZaidiState extends State<JifunzeZaidi> {
  bool _isGridView = false;

  // final OrodhaCategoryController _orodhaCategoryController =
  //     Get.put(OrodhaCategoryController());

  final OrodhaController orodhaController = Get.put(OrodhaController());
  final _scrollController = ScrollController();
  final scrollController = ScrollController();
  int page = 1;
  bool isLoadingMore = false;
  bool showLeftButton = false;
  @override
  void initState() {
    orodhaController.isInitialCTCLoading.value = true;
    // _orodhaCategoryController;
    // _orodhaController;
    orodhaController.allCTC.clear();
    // if (ctcController.allOrodha.isEmpty) {
    //   ctcController.fetchOrodhaData(1);
    // }

    // fetchLocation(context);
    orodhaController.fetchCTCData(page);
    scrollController.addListener(_scrollListener);

    // Listen for scroll events and update the flag
    _scrollController.addListener(() {
      setState(() {
        showLeftButton = _scrollController.offset > 0;
      });
    });
    super.initState();
  }

  // String? _currentAddress;
  // Position? _currentPosition;

  // Future<void> _getAddressFromLatLng(Position position) async {
  //   await placemarkFromCoordinates(
  //           _currentPosition!.latitude, _currentPosition!.longitude)
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       _currentAddress = '${place.street}, ${place.subLocality}';
  //     });
  //   }).catchError((e) {
  //     print('this is the error: $e');
  //   });
  // }

  // fetchLocation(context) async {
  //   final hasPermission =
  //       await GetCustomLocation.handleLocationPermission(context);
  //   // Position position = await Geolocator.getCurrentPosition(
  //   //     desiredAccuracy: LocationAccuracy.high);
  //   // final hasPermission = await _handleLocationPermission();
  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
  //       .then((Position position) {
  //     setState(() => _currentPosition = position);
  //     _getAddressFromLatLng(_currentPosition!);
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vituo vya CTC",
          style: const TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
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
        // actions: [
        //   GestureDetector(
        //     onTap: () =>
        //         Get.to(const FilterPage(isSpecialist: true, isOrodha: true)),
        //     child: Container(
        //       margin: const EdgeInsets.all(8),
        //       height: 25,
        //       width: 25,
        //       decoration: const BoxDecoration(
        //         image: DecorationImage(
        //           image: AssetImage(
        //             'assets/icon/filter.png',
        //           ),
        //         ),
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: GestureDetector(
                onTap: () {
                  // Get.to(const SearchButtonFacilities());
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  color: Color(0xffE1E8ED).withAlpha(100),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 24,
                          color: AppSettings.primaryColor,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "Tafuta",
                          style: const TextStyle(
                            color: Color(0xffE1E8ED),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "categories",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // _orodhaCategoryController.orodhaCategoryLoading.value
            //     ?
            SizedBox(
              height: 100,
              child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                children: List.generate(
                  orodhaSelectedApps(context).length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        orodhaController.categorizedCTC.clear();
                        Get.to(
                          CTCCategory(
                            id: orodhaSelectedApps(context)[index].id,
                            title: orodhaSelectedApps(context)[index].name,
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: orodhaSelectedApps(context)[index].color,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: orodhaSelectedApps(context)[index].icon,
                            ),
                            Text(
                              orodhaSelectedApps(context)[index].name,
                              style: const TextStyle(
                                color: AppSettings.primaryColor,
                                fontSize: 12,
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

            const Icon(
              Icons.arrow_right,
              color: Colors.white,
            ),
            const SizedBox(height: 20),

            //.......nearest Facilities.......
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vilivyopendekezwa",
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
                  if (orodhaController.isLoading.value == false)
                    _isGridView
                        ? ListViewBuilder(
                            allData: orodhaController.allCTC,
                          )
                        : GridViewBuilder(
                            allData: orodhaController.allCTC,
                          ),
                  if (orodhaController.isInitialCTCLoading.value)
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
        orodhaController.isInitialCTCLoading.value = false;
      });
      page = page + 1;
      await orodhaController.fetchCTCData(page);
      setState(() {
        isLoadingMore = false;
      });
    }
  }
}
