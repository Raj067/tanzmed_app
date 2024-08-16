import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrodhaModel {
  final String id;
  final String hospitalName;
  final String tenantUsername;
  final String? email;
  final String? imageUrl;
  final int featured;
  final int published;
  final String? isCtc;
  final String contact;
  final String? address;
  final Region? regionObject;
  final String postCode;
  final String video;
  final String website;
  final String ipAddress;
  final double latitude;
  final double longitude;
  final String createdAt;
  final String updatedAt;
  final HospitalTypeObject? hospitalTypeObject;
  final District? districtObject;
  final HospitalCategory? hospitalCategory;
  final bool isSubscribed;
  final List<WorkingHoours>? workingHours;
  final List<Specialities>? specialities;
  final dynamic rate;

  OrodhaModel({
    required this.id,
    required this.hospitalName,
    required this.tenantUsername,
    required this.email,
    required this.imageUrl,
    required this.featured,
    required this.published,
    required this.isCtc,
    required this.contact,
    required this.address,
    required this.regionObject,
    required this.postCode,
    required this.video,
    required this.website,
    required this.ipAddress,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.hospitalTypeObject,
    required this.districtObject,
    required this.hospitalCategory,
    required this.isSubscribed,
    required this.workingHours,
    required this.specialities,
    required this.rate,
  });

  factory OrodhaModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['specialities'] as List;
    List<Specialities> specialities =
        dataList.map((item) => Specialities.fromJson(item)).toList();

    var workingList = json['working_hours'] as List?;
    List<WorkingHoours> workingHours =
        workingList?.map((item) => WorkingHoours.fromJson(item)).toList() ?? [];

    return OrodhaModel(
      id: json['id'].toString(),
      hospitalName: json['hospital_name'],
      tenantUsername: json['tenant_username'],
      email: json['email'] ?? "",
      imageUrl: json['image_url'] ?? "",
      featured: json['featured'],
      published: json['published'],
      isCtc: json['is_ctc'],
      contact: json['contact'] ?? "",
      address: json['address'] ?? "",
      regionObject:
          json['region'] != null ? Region.fromJson(json['region']) : null,
      postCode: json['post_code'] ?? "",
      video: json['video'] ?? "",
      website: json['website'] ?? "",
      ipAddress: json['ip_address'] ?? "",
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      hospitalTypeObject: json['hospital_type'] != null
          ? HospitalTypeObject.fromJson(json['hospital_type'])
          : null,
      districtObject:
          json['district'] != null ? District.fromJson(json['district']) : null,
      hospitalCategory: HospitalCategory.fromJson(json['hospital_category']),
      isSubscribed: json['is_subscribed'],
      specialities: specialities,
      workingHours: workingHours,
      rate: json['rate'],
    );
  }

  String getTodaysWorkingHours(BuildContext context) {
    // Get today's day of the week (1 for Monday, 2 for Tuesday, ..., 7 for Sunday)
    final today = DateTime.now().weekday;

    // Find the working hours for today
    final todaysWorkingHours = workingHours!.firstWhereOrNull(
      (workingHour) => int.parse(workingHour.day_of_week) == today,
      // orElse: () => null,
    );

    if (todaysWorkingHours != null) {
      // Display start and end times for today
      return ' ${todaysWorkingHours.start_time} - ${todaysWorkingHours.end_time}';
    } else {
      // Handle the case when no working hours are available for today
      return "noAvailabilitySchedule";
    }
  }
}

class District {
  final int id;
  final int regionId;
  final String name;

  District({
    required this.id,
    required this.regionId,
    required this.name,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      regionId: json['region_id'],
      name: json['name'],
    );
  }
}

class Region {
  final int id;
  final String name;

  Region({
    required this.id,
    required this.name,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Specialities {
  final int id;
  final String name;
  final String? icon;

  Specialities({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Specialities.fromJson(Map<String, dynamic> json) {
    return Specialities(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }
}

class WorkingHoours {
  final int id;
  final String day_of_week;
  final String start_time;
  final String end_time;
  final String tenant_id;
  final String created_at;
  final String updated_at;
  WorkingHoours({
    required this.id,
    required this.day_of_week,
    required this.start_time,
    required this.end_time,
    required this.tenant_id,
    required this.created_at,
    required this.updated_at,
  });

  factory WorkingHoours.fromJson(Map<String, dynamic> json) {
    return WorkingHoours(
      id: json['id'],
      day_of_week: json['day_of_week'],
      start_time: json['start_time'],
      end_time: json['end_time'],
      tenant_id: json['tenant_id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}

class HospitalTypeObject {
  final int id;
  final String name;
  final String created_at;
  final String updated_at;

  HospitalTypeObject({
    required this.id,
    required this.name,
    required this.created_at,
    required this.updated_at,
  });

  factory HospitalTypeObject.fromJson(Map<String, dynamic> json) {
    return HospitalTypeObject(
      id: json['id'],
      name: json['name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}

class HospitalCategory {
  final int id;
  final String name;
  final String? nameEn;
  final String alias;
  final String iconUrl;
  final int ordering;
  final int published;

  HospitalCategory({
    required this.id,
    required this.name,
    this.nameEn,
    required this.alias,
    required this.iconUrl,
    required this.ordering,
    required this.published,
  });

  factory HospitalCategory.fromJson(Map<String, dynamic> json) {
    return HospitalCategory(
      id: json['id'],
      name: json['name'],
      nameEn: json['name_en'],
      alias: json['alias'],
      iconUrl: json['icon_url'],
      ordering: json['ordering'],
      published: json['published'],
    );
  }
}
