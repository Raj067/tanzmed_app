import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../helpers/constants.dart';
import '../models/orodha_model.dart';
import '../widgets/network_error.dart';

class OrodhaController extends GetxController {
  RxList<OrodhaModel> allOrodha = <OrodhaModel>[].obs;
  RxList<OrodhaModel> allCTC = <OrodhaModel>[].obs;
  final categorizedOrodha = <OrodhaModel>[].obs;
  final categorizedCTC = <OrodhaModel>[].obs;
  final apiClient = ApiClient();
  static final _box = GetStorage(); //used to create a list of categories ids
  final box = GetStorage();

  // create API endpoint parameters
  RxBool orodhaLoading = true.obs;
  RxBool orodhaLoadingError = false.obs;
  RxBool isLoading = false.obs;
  RxBool isInitialLoading = true.obs;
  RxBool isInitialCTCLoading = true.obs;
  RxBool isInitialCategoryLoading = true.obs;
  var isLoadingCategory = false.obs;
  var isLoadingCTCCategory = false.obs;
  int currentPage = 1;
  int lastPage = 1;
  int id = 1;
  String? text = '';

  @override
  void onInit() {
    if (allOrodha.isEmpty) {
      fetchOrodhaData(currentPage);
      fetchCTCData(currentPage);
    }
    super.onInit();
  }

// this string used to generate API endpoint for filtering based on categories
  RxString generatedString = ''.obs; // Initialize with an empty string
// this function used to generate API endpoint for filtering based on categories
  Future<void> generateString(List<dynamic> a) async {
    if (a.isEmpty) {
      return; // Return early if the array is empty
    }
    generatedString.value = ''; // Reset the string before generating again
    for (int element in a) {
      generatedString.value += 'filterCategories[]=$element&';
    }
  }

// this function fetch all orodha data by pagination
  Future<void> fetchOrodhaData(currentPage) async {
    if (isInitialLoading.value) {
      isLoading.value = true;
    }
    orodhaLoading.value = true;
    List<dynamic>? facilityIds = _box.read('facilityIds');
    String currentString = "";
    if (facilityIds != null && facilityIds.isNotEmpty) {
      await generateString(facilityIds);
      currentString = generatedString.value;
    }

    try {
      // if current page exceed the last page return to the last page
      if (currentPage > lastPage) return;

      final response = await apiClient.get(
          '/api/facilities/all-facilities?page=$currentPage&${currentString}filterDistance=${box.read("umbaliSelected")}');
      if (response.statusCode == 200) {
        orodhaLoading.value = false;
        isLoading.value = false;
        final dynamic data = json.decode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('data')) {
          final List<dynamic> orodhaData = data['data'];
          final List<OrodhaModel> newOrodhaList =
              orodhaData.map((item) => OrodhaModel.fromJson(item)).toList();
          allOrodha.addAll(newOrodhaList);
          if (data['current_page'] is int) {
            currentPage = data['current_page'];
          }

          if (data['last_page'] is int) {
            lastPage = data['last_page'];
          }
        } else {
          orodhaLoading.value = false;
          isLoading.value = false;
          // Get.back();
          // Get.bottomSheet(NetworkErrorMessage(
          //   message: AppLocalizations.of(Get.context!)!.requestProblem,
          // ));
        }
      } else {
        orodhaLoading.value = false;
        isLoading.value = false;
        // Get.back();
        Get.bottomSheet(const NetworkErrorMessage());
      }
    } catch (e) {
      isLoading.value = false;
      // Get.back();
      // Get.bottomSheet(NetworkErrorMessage(
      //   message: AppLocalizations.of(Get.context!)!.requestProblem,
      // ));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCTCData(currentPage) async {
    if (isInitialCTCLoading.value) {
      isLoading.value = true;
    }
    orodhaLoading.value = true;
    List<dynamic>? facilityIds = _box.read('facilityIds');
    if (facilityIds != null && facilityIds.isNotEmpty) {
      await generateString(facilityIds);
      String currentString = generatedString.value;
      try {
        // if current page exceed the last page return to the last page
        if (currentPage > lastPage) return;

        // isLoading.value = true;
        final response = await apiClient.get(
            '/api/facilities/all-ctc?page=$currentPage&${currentString}filterDistance=${box.read("umbaliSelected")}');
        if (response.statusCode == 200) {
          isLoading.value = false;
          final dynamic data = json.decode(response.body);
          if (data is Map<String, dynamic> && data.containsKey('data')) {
            final List<dynamic> orodhaData = data['data'];
            final List<OrodhaModel> newOrodhaList =
                orodhaData.map((item) => OrodhaModel.fromJson(item)).toList();
            allCTC.addAll(newOrodhaList);
            if (data['current_page'] is int) {
              currentPage = data['current_page'];
            }

            if (data['last_page'] is int) {
              lastPage = data['last_page'];
            }
            orodhaLoading.value = false;
          } else {
            orodhaLoading.value = false;
            throw Exception('Invalid data structure in the response');
          }
        } else {
          isLoading.value = false;
          // Get.back();
          // Get.bottomSheet(NetworkErrorMessage(
          //   message: AppLocalizations.of(Get.context!)!.requestProblem,
          // ));
        }
      } catch (e) {
        isLoading.value = false;
        // Get.back();
        // Get.bottomSheet(NetworkErrorMessage(
        //   message: AppLocalizations.of(Get.context!)!.requestProblem,
        // ));
      } finally {
        isLoading.value = false;
      }
    } else {
      // FacilityIds are null or empty, handle this case if needed
      try {
        orodhaLoading.value = true;
        // if current page exceed the last page return to the last page
        if (currentPage > lastPage) return;
        orodhaLoading.value = true;
        // isLoading.value = true;
        final response =
            await apiClient.get('/api/facilities/all-ctc?page=$currentPage');
        if (response.statusCode == 200) {
          orodhaLoading.value = false;
          isLoading.value = false;
          final dynamic data = json.decode(response.body);
          if (data is Map<String, dynamic> && data.containsKey('data')) {
            final List<dynamic> orodhaData = data['data'];
            final List<OrodhaModel> newOrodhaList =
                orodhaData.map((item) => OrodhaModel.fromJson(item)).toList();

            allCTC.addAll(newOrodhaList);
            // print(orodhaData);
            if (data['current_page'] is int) {
              currentPage = data['current_page'];
            }

            if (data['last_page'] is int) {
              lastPage = data['last_page'];
            }
          } else {
            isLoading.value = false;
            // Get.back();
            // Get.bottomSheet(NetworkErrorMessage(
            //   message: AppLocalizations.of(Get.context!)!.requestProblem,
            // ));
          }
        } else {
          isLoading.value = false;
          // Get.back();
          // Get.bottomSheet(NetworkErrorMessage(
          //   message: AppLocalizations.of(Get.context!)!.requestProblem,
          // ));
        }
      } catch (e) {
        isLoading.value = false;
        // Get.back();
        // Get.bottomSheet(NetworkErrorMessage(
        //   message: AppLocalizations.of(Get.context!)!.requestProblem,
        // ));
      } finally {
        isLoading.value = false;
      }
    }
  }

  List<OrodhaModel> getOrodha() {
    return allOrodha.toList();
  }

  final RxList<OrodhaModel> searchedOrodha = <OrodhaModel>[].obs;

  void searchOrodha(String query) {
    searchedOrodha.assignAll(
      allOrodha.where((orodha) =>
          orodha.hospitalName.toLowerCase().contains(query.toLowerCase())),
    );
    if (searchedOrodha.isEmpty) {
      text = 'No Search Result found!';
    } else {
      text = '';
    }
  }

// get address of an orodha data from it's latitude and longitudes
  Future<String> getAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark firstPlacemark = placemarks.first;

        String address = '${firstPlacemark.street}, ${firstPlacemark.locality}';

        return address;
      } else {
        return "noAddress";
      }
    } catch (e) {
      return "noAddress";
    }
  }

  Future<void> filterOrodhaCategory(int id, currentPage) async {
    if (isInitialCategoryLoading.value) {
      isLoadingCategory.value = true;
      // print('\n\n mwanzo ${id} ${currentPage}');
    }
    try {
      // if current page exceed the last page return to the last page
      if (currentPage > lastPage) return;

      final response = await apiClient
          .get('/api/facilities/all-facilities?page=$currentPage&category=$id');
      // print(response.statusCode);
      if (response.statusCode == 200) {
        // print('\n\n\nobject');
        isInitialCategoryLoading.value = false;
        isLoadingCategory.value = false;
        final dynamic data = json.decode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('data')) {
          final List<dynamic> orodhaData = data['data'];
          final List<OrodhaModel> newOrodhaList =
              orodhaData.map((item) => OrodhaModel.fromJson(item)).toList();

          categorizedOrodha.addAll(newOrodhaList
              .where((orodha) => orodha.hospitalCategory!.id == id));

          // categorizedOrodha.addAll(newOrodhaList);

          if (data['current_page'] is int) {
            currentPage = data['current_page'];
          }

          if (data['last_page'] is int) {
            lastPage = data['last_page'];
          }
        } else {
          throw Exception('Invalid data structure in the response');
        }
      } else {
        isLoading.value = false;
        // Get.back();
        Get.bottomSheet(const NetworkErrorMessage());
      }
    } catch (e) {
      orodhaLoadingError.value = true;
      isLoading.value = false;
      // Get.back();
      Get.bottomSheet(const NetworkErrorMessage());
    } finally {
      isLoadingCategory.value = false;
      // isLoading.value = false;
    }
  }

  Future<void> filterCTCCategory(int id, currentPage) async {
    if (isInitialCTCLoading.value) {
      isLoadingCTCCategory.value = true;
    }
    try {
      // if current page exceed the last page return to the last page
      if (currentPage > lastPage) return;

      final response = await apiClient
          .get('/api/facilities/all-ctc?page=$currentPage&category=$id');
      if (response.statusCode == 200) {
        isInitialCTCLoading.value = false;
        isLoadingCTCCategory.value = false;
        final dynamic data = json.decode(response.body);
        if (data is Map<String, dynamic> && data.containsKey('data')) {
          final List<dynamic> orodhaData = data['data'];
          final List<OrodhaModel> newOrodhaList =
              orodhaData.map((item) => OrodhaModel.fromJson(item)).toList();

          categorizedCTC.addAll(newOrodhaList
              .where((orodha) => orodha.hospitalCategory!.id == id));

          // categorizedOrodha.addAll(newOrodhaList);

          if (data['current_page'] is int) {
            currentPage = data['current_page'];
          }

          if (data['last_page'] is int) {
            lastPage = data['last_page'];
          }
        } else {
          throw Exception('Invalid data structure in the response');
        }
      } else {
        isLoading.value = false;
        // Get.back();
        Get.bottomSheet(const NetworkErrorMessage());
      }
    } catch (e) {
      orodhaLoadingError.value = true;
      isLoading.value = false;
      // Get.back();
      // Get.bottomSheet(NetworkErrorMessage(
      //   message: AppLocalizations.of(Get.context!)!.requestProblem,
      // ));
    } finally {
      isLoadingCTCCategory.value = false;
    }
  }
}
