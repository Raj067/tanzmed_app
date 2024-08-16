import '../helpers/remove_slash.dart';

class MyAppointmentModel {
  final int id;
  final int patientId;
  final int departmentId;
  late DateTime? opdDate; // Use this for appointments
  late DateTime? date; // Use this for consultations
  final String meetingId; // Use this for live consultations
  final String time;
  final int status;
  final int? isCompleted;
  final int appointmentType;
  final String doctorName;
  final int doctorId;
  final String doctorAvatar;
  final String doctorSpecialities;
  final String hospitalName;
  final String duration;
  final String specialist;

  MyAppointmentModel({
    required this.id,
    required this.patientId,
    required this.departmentId,
    required this.opdDate,
    required this.date,
    required this.meetingId,
    required this.time,
    required this.appointmentType,
    required this.status,
    required this.isCompleted,
    required this.doctorName,
    required this.doctorId,
    required this.doctorAvatar,
    required this.doctorSpecialities,
    required this.hospitalName,
    required this.duration,
    required this.specialist,
  });

  factory MyAppointmentModel.fromJson(Map<String, dynamic> json) {
    return MyAppointmentModel(
      id: json['id'] ?? 0, // Provide a default value or handle it accordingly
      patientId: json['patient_id'] ?? 0,
      departmentId: json['department_id'] ?? 0,
      opdDate: _parseDateTime(json['opd_date']),
      date: _parseDateTime(json['date']),
      meetingId: json['meeting_id'] ?? '',
      time: json['time'] ?? '',
      status: json['status'] ?? 0,
      isCompleted: json['is_completed'] ?? 0,
      appointmentType: json['appointment_type'] ?? 0,
      doctorId: json['doctor_id'] ?? 0,
      doctorName: json['doctor_name'] ?? '',
      doctorAvatar: json['doctor_avatar'] == null
          ? "https://ui-avatars.com/api/${json['doctor_name']}/?background=0D8ABC&color=fff"
          : removeDoubleSlash(json['doctor_avatar']),
      doctorSpecialities: json['doctor_specialities'] ?? '',
      hospitalName: json['hospital_name'] ?? '',
      specialist: json['specialist'],
      duration: json['duration'] == null ? "10" : json['duration'].toString(),
    );
  }
  static DateTime? _parseDateTime(String? dateString) {
    if (dateString != null && dateString.isNotEmpty) {
      try {
        return DateTime.parse(dateString);
      } catch (e) {
        print('Error parsing date: $e');
      }
    }
    return null;
  }
}
