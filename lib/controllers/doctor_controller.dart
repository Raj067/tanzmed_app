import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../helpers/constants.dart';
import '../models/doctor_model.dart';
import '../models/time_slot_model.dart';
import '../widgets/home.dart';

class DoctorController extends GetxController {
  final RxList<DoctorModel> allDoctors = <DoctorModel>[].obs;
  // final RxList<DoctorModel> allAppointments = <DoctorModel>[].obs;
  // final filteredDoctors = <DoctorModel>[].obs;

  // final filteredDoctorsFromFacility = <DoctorModel>[].obs;
  RxBool isLoadingDoctors = true.obs;
  final RxBool isLoadingDoctorsError = false.obs;
  final ApiClient apiClient = ApiClient();
  String? text = '';
  List<int> selectedSpecialityIds = SpecialityService.getSpecialityIds();
  static final _box = GetStorage();
  @override
  void onInit() {
    if (allDoctors.isEmpty) {
      fetchDoctorDetails();
    }
    super.onInit();
  }

  fetchDoctorsMain() {
    if (allDoctors.isEmpty) {
      fetchDoctorDetails();
    }
  }

  static List<int> getSpecialityIds() {
    List<dynamic>? ids = _box.read('specilityIds');
    return ids?.cast<int>() ?? [];
  }

  static List<int> getCommunicationIds() {
    List<dynamic>? ids = _box.read('communicationIds');
    return ids?.cast<int>() ?? [];
  }

  static String getRegionId() {
    String? ids = _box.read('selectedRegion');
    return ids ?? '';
  }

  static String getDistrictId() {
    String? ids = _box.read('selectedDistrict');
    return ids ?? '';
  }

  // fetch doctors details
  fetchDoctorDetails() async {
    try {
      if (allDoctors.isEmpty) {
        final apiResponse = await apiClient.get('/api/doctors/all');
        if (apiResponse.statusCode == 200) {
          // Get data
          final data = jsonDecode(apiResponse.body)['data'];
          List<DoctorModel> finalDoctors = [];

          // Handle data add them to a model
          for (var element in data) {
            finalDoctors.add(DoctorModel.fromJson(element));
          }

          // Retrieve IDs from local storage
          List<int> specialityIds = getSpecialityIds();
          List<int> communicationIds = getCommunicationIds();
          String regionId = getRegionId();
          String districtId = getDistrictId();

          // Filter doctors based on the criteria
          finalDoctors = finalDoctors.where((doctor) {
            return doctorMeetsCriteria(
                doctor, specialityIds, communicationIds, regionId, districtId);
          }).toList();

          // Shuffle data
          finalDoctors.shuffle();

          // Add in all doctors list
          allDoctors.assignAll(finalDoctors);

          // Stop loading and show doctors
          isLoadingDoctors.value = false;
        } else {
          isLoadingDoctorsError.value = true;
          isLoadingDoctors.value = false;
        }
        return apiResponse;
      }
    } catch (e) {
      // Loading is complete, set isLoading to false
      isLoadingDoctors.value = false;

      throw Exception("An unexpected error occurred while loading Doctors.$e");
    }
  }

  List<DoctorModel> getDoctors() {
    return allDoctors.toList();
  }

  List<DoctorModel> filterDoctorsSpecialities(int id, {String? hospitalId}) {
    List<DoctorModel> val = getAllDoctors(hospitalId: hospitalId)
        .where((doctor) => doctor.specialist.id == id)
        .toList();
    return val;
  }

  List<DoctorModel> getAllDoctors({String? hospitalId}) {
    if (hospitalId == null) {
      return allDoctors;
    } else {
      return allDoctors
          .where((doctor) => doctor.hospital.id == hospitalId)
          .toList();
    }
  }

  bool doctorMeetsCriteria(
    DoctorModel doctor,
    List<int> specialityIds,
    List<int> communicationIds,
    String region,
    String district,
  ) {
    if (specialityIds.isNotEmpty &&
        !specialityIds.contains(doctor.specialist.id)) {
      return false;
    }

    if (communicationIds.isNotEmpty &&
        communicationIds.contains(1) &&
        (doctor.live_call_price == null || doctor.live_call_price == 0)) {
      return false;
    }

    if (communicationIds.isNotEmpty &&
        communicationIds.contains(2) &&
        (doctor.home_visit_price == null || doctor.home_visit_price == 0)) {
      return false;
    }

    if (communicationIds.isNotEmpty &&
        communicationIds.contains(3) &&
        doctor.hospital.isSubscribed != 1) {
      return false;
    }

    if (region.isNotEmpty &&
        (doctor.user.docAddress?.region.id.toString() != region)) {
      return false;
    }

    if (district.isNotEmpty &&
        (doctor.user.docAddress?.district.id.toString() != district)) {
      return false;
    }

    return true;
  }

  final RxList<DoctorModel> searchedDoctors = <DoctorModel>[].obs;

  void searchDoctors(String query) {
    searchedDoctors.assignAll(
      allDoctors.where((doctor) =>
          doctor.user.fullName!.toLowerCase().contains(query.toLowerCase()) ||
          doctor.specialist.name!.toLowerCase().contains(query.toLowerCase())),
    );
    if (searchedDoctors.isEmpty) {
      text = 'No Search Result found!';
    } else {
      text = '';
    }
  }
}

DateTime originalDate = DateTime.now();
int month = DateTime.now().month;
int year = DateTime.now().year;
int day = DateTime.now().day;

// generate time slots
List<TimeSlot> generateTimeSlots(String? initialTime, String? endTime) {
  final List<TimeSlot> timeSlots = [];

  DateTime startDateTime = DateTime.parse('$year-$month-$day ${initialTime!}');
  DateTime endDateTime = DateTime.parse('$year-$month-$day ${endTime!}');

  while (startDateTime.isBefore(endDateTime)) {
    int startTime = startDateTime.hour;
    startDateTime = startDateTime.add(const Duration(hours: 1));

    int endTime = startDateTime.hour;

    timeSlots.add(TimeSlot(startTime: startTime, endTime: endTime));
  }
  return timeSlots;
}

// map the doctor schedule to date list
List<DateTime> extractDates(List<Map<String, dynamic>> mapList, String key) {
  return mapList.map((map) {
    // Assuming the date values are stored as strings in the 'date' key
    int dateString = map[key];

    return DateTime.utc(originalDate.year, month, dateString);
  }).toList();
}
