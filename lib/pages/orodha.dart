import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tanzmed/helpers/settings.dart';

import '../controllers/orodha_controller.dart';
import '../widgets/custom_loading.dart';
import '../widgets/custom_location_widget.dart';
import '../widgets/grid_view_builder.dart';
import '../widgets/list_view_builder.dart';
import '../widgets/orodha_app.dart';
import 'category_hospitali.dart';

class OrodhaPage extends StatefulWidget {
  const OrodhaPage({super.key});

  @override
  State<OrodhaPage> createState() => _OrodhaPageState();
}

class _OrodhaPageState extends State<OrodhaPage> {
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
    orodhaController.isInitialLoading.value = true;
    // _orodhaCategoryController;
    // _orodhaController;
    orodhaController.allOrodha.clear();
    // if (orodhaController.allOrodha.isEmpty) {
    //   orodhaController.fetchOrodhaData(1);
    // }

    fetchLocation(context);
    orodhaController.fetchOrodhaData(page);
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
  Position? _currentPosition;

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      // // Placemark place = placemarks[0];
      // setState(() {
      //   // String _currentAddress = '${place.street}, ${place.subLocality}';
      // });
    }).catchError((e) {
      print('this is the error: $e');
    });
  }

  fetchLocation(context) async {
    final hasPermission =
        await GetCustomLocation.handleLocationPermission(context);
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "orodha",
          style: TextStyle(color: Colors.white),
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
            onTap: () => {},
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
        ],
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
                          "findOrodha",
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
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                "categories",
                style: TextStyle(
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
                        orodhaController.categorizedOrodha.clear();
                        Get.to(
                          HospitaliCategory(
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
                              textAlign: TextAlign.center,
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
                  const Text(
                    "nearestHealthFacility",
                    style: TextStyle(
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
                            allData: orodhaController.allOrodha,
                          )
                        : GridViewBuilder(
                            allData: orodhaController.allOrodha,
                          ),
                  if (orodhaController.isInitialLoading.value == true)
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
        orodhaController.isInitialLoading.value = false;
      });
      page = page + 1;
      await orodhaController.fetchOrodhaData(page);
      setState(() {
        isLoadingMore = false;
      });
    }
  }
}
