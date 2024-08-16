import 'dart:convert';

import 'package:get/get.dart';

import '../helpers/constants.dart';
import '../models/appointment_model.dart';

class AppointmentController extends GetxController {
  RxList<MyAppointmentModel> allAppointments = <MyAppointmentModel>[].obs;
  RxBool isLoadingAppointment = true.obs;
  RxBool isLoadingAppointmentError = false.obs;
  ApiClient apiClient = ApiClient();

  @override
  void onInit() {
    // if (allAppointments.isEmpty) {
    fetchAppointments();
    // }
    super.onInit();
  }

// fetch appointments
  Future fetchAppointments() async {
    // if (allAppointments.isEmpty) {
    final apiResponse = await apiClient.get('/api/appointments/all');
    if (apiResponse.statusCode == 200) {
      final dynamic rawData = jsonDecode(apiResponse.body);
      // if (rawData is Map<String, dynamic>) {
      final List<Map<String, dynamic>> appointmentDataList =
          (rawData['appointments'] as List<dynamic>?)
                  ?.cast<Map<String, dynamic>>() ??
              [];
      final List<Map<String, dynamic>> liveConsultationDataList =
          (rawData['liveconsultation'] as List<dynamic>?)
                  ?.cast<Map<String, dynamic>>() ??
              [];

      final List<MyAppointmentModel> myAppointments = [
        ...appointmentDataList.map(
            (appointmentData) => MyAppointmentModel.fromJson(appointmentData)),
        ...liveConsultationDataList.map((liveConsultationData) =>
            MyAppointmentModel.fromJson(liveConsultationData)),
      ];

      // Add appointments to the list
      allAppointments.value = myAppointments;

      isLoadingAppointment.value = false;

      // Print or do something with the appointments
      // } else {
      //   print('Invalid data format: $rawData');
      //   // Handle the case where the data format is not as expected
      // }
    } else {
      isLoadingAppointmentError.value = true;
      isLoadingAppointment.value = false;
    }
    return apiResponse;
    // }
  }

  // List<MyAppointmentModel> getAppointments() {
  //   return allAppointments.toList();
  // }

// create appointment
  Future<void> createAppointment(
    DateTime date,
    String time,
    String duration,
    int doctorId,
    int departmentId,
    String tenantId,
    String location,
    int consultationType,
    double amount,
    String description,
  ) async {
    try {
      final Map<String, dynamic> requestBody = {
        'date': date.toIso8601String().substring(0, 10),
        'time': time,
        'duration': duration,
        'doctor_id': doctorId,
        'department_id': departmentId,
        'tenant_id': tenantId,
        'location': location,
        'consultation_type': consultationType,
        "amount": amount.toInt(),
        "description": description
      };

      final apiResponse =
          await apiClient.post('/api/appointments/create', body: requestBody);

      if (apiResponse.statusCode == 200) {
        // print('POST Request Successful');
        fetchAppointments();
      } else {
        // print(
        //     'POST Request Failed with status code: ${apiResponse.statusCode.toString()}');
        // print('Response: ${apiResponse.body.toString()}');
        throw Exception(
            "Failed to create appointment. Status code: ${apiResponse.statusCode}");
      }
    } catch (e) {
      // print('Error: $e');
      throw Exception("Failed to create appointment. Status code: $e");
    }
  }

// cancel appointment
  Future<void> cancelAppointment(
    DateTime date,
    String time,
    int consultationType,
    int appointmentId,
    int status,
  ) async {
    try {
      final Map<String, dynamic> requestBody = {
        'date': date.toIso8601String(),
        'time': time,
        'consultation_type': consultationType,
        'id': appointmentId,
        'status': status,
      };
      final apiResponse =
          await apiClient.post('/api/appointments/update', body: requestBody);

      if (apiResponse.statusCode == 200) {
        fetchAppointments();
      } else {
        throw Exception(
            "Failed to create appointment. Status code: ${apiResponse.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to create appointment. Status code: $e");
    }
  }

// update appointment
  Future<void> updateAppointment(
    DateTime date,
    String time,
    int consultationType,
    int appointmentId,
    double amount,
  ) async {
    try {
      final Map<String, dynamic> requestBody = {
        'date': date.toIso8601String(),
        'time': time,
        'consultation_type': consultationType,
        'id': appointmentId,
        'status': 0,
        "amount": amount,
      };
      final apiResponse =
          await apiClient.post('/api/appointments/update', body: requestBody);

      if (apiResponse.statusCode == 200) {
        fetchAppointments();
      } else {
        throw Exception(
            "Failed to create appointment. Status code: ${apiResponse.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to create appointment. Status code: $e");
    }
  }

// update appointment
  Future<void> rescheduleAppointment(
    DateTime date,
    String time,
    int consultationType,
    int appointmentId,
    int appointmentType,
  ) async {
    try {
      final Map<String, dynamic> requestBody = {
        'date': date.toIso8601String(),
        'time': time,
        'consultation_type': consultationType,
        'id': appointmentId,
        'status': appointmentType,
      };
      final apiResponse =
          await apiClient.post('/api/appointments/update', body: requestBody);

      if (apiResponse.statusCode == 200) {
        // print('Response: ${apiResponse.body}');
        fetchAppointments();
      } else {
        throw Exception(
            "Failed to create appointment. Status code: ${apiResponse.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to create appointment. Status code: $e");
    }
  }
}
