import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tanzmed/helpers/settings.dart';

import '../controllers/orodha_controller.dart';
import '../widgets/custom_loading.dart';
import '../widgets/grid_view_builder.dart';
import '../widgets/list_view_builder.dart';

class HospitaliCategory extends StatefulWidget {
  const HospitaliCategory({
    super.key,
    required this.title,
    required this.id,
  });
  final String title;
  final int id;

  @override
  State<HospitaliCategory> createState() => _HospitaliCategoryState();
}

class _HospitaliCategoryState extends State<HospitaliCategory> {
  bool _isGridView = false;

  final OrodhaController orodhaController = Get.put(OrodhaController());
  final scrollController = ScrollController();
  int page = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    // fetchLocation(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      orodhaController.isInitialCategoryLoading.value = true;
    });
    orodhaController.filterOrodhaCategory(widget.id, page);
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
            onTap: () {},
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
                  const Text(
                    "Vilivyopendekezwa",
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
                  if (orodhaController.isLoadingCategory.value == false)
                    _isGridView
                        ? ListViewBuilder(
                            allData: orodhaController.categorizedOrodha,
                          )
                        : GridViewBuilder(
                            allData: orodhaController.categorizedOrodha,
                          ),
                  if (orodhaController.isInitialCategoryLoading.value == true)
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
        orodhaController.isInitialCategoryLoading.value = false;
      });

      page = page + 1;
      await orodhaController.filterOrodhaCategory(widget.id, page);
      setState(() {
        isLoadingMore = false;
      });
    }
  }
}
