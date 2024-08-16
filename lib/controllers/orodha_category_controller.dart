// import 'dart:convert';
// import 'package:get/get.dart';
// import '../../../apis/constants.dart';
// import '../models/orodha_category_model.dart';

// class OrodhaCategoryController extends GetxController {
//   RxList<OrodhaCategoryModel> allCategories = <OrodhaCategoryModel>[].obs;
//   final apiClient = ApiClient();

//   RxBool orodhaCategoryLoading = true.obs;
//   RxBool orodhaCategoryLoadingError = false.obs;

//   @override
//   void onInit() {
//     if (allCategories.isEmpty) {
//       fetchCategoryData();
//     }
//     super.onInit();
//   }

//   fetchCategoryData() async {
//     if (allCategories.isEmpty) {
//       final response =
//           await apiClient.get('/api/facilities/all-facility-categories');
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body)['data'];
//         // print('ahefkrgfffjf  $data');

//         // Handle the data here.
//         List<OrodhaCategoryModel> finalData = [];
//         for (var element in data) {
//           finalData.add(OrodhaCategoryModel.fromJson(element));
//         }

//         allCategories.value = finalData;
//         orodhaCategoryLoading.value = false;
//       } else {
//         // Handle the error here.
//         orodhaCategoryLoadingError.value = true;
//       }
//       return response;
//     }
//   }

//   List<OrodhaCategoryModel> getOrodhaCategory() {
//     return allCategories.toList();
//   }
// }
