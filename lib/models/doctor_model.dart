class DoctorModel {
  final int? id;
  final UserModel user;
  final int? doctorDepartment;
  final SpecialistModel specialist;
  final String? createdAt;
  final String? updatedAt;
  final HospitalModel hospital;
  final String? about;
  final String? experience;
  final String? salutation;
  final int? rate;
  final int? live_call_price;
  final int? home_visit_price;
  final List<DoctorSchedule> doctorSchedule;
  final List<PastAppointment> appointments;
  final int langProficiency;

  DoctorModel({
    required this.id,
    required this.user,
    required this.doctorDepartment,
    required this.specialist,
    required this.createdAt,
    required this.updatedAt,
    required this.hospital,
    required this.rate,
    required this.about,
    required this.experience,
    required this.salutation,
    required this.doctorSchedule,
    required this.langProficiency,
    required this.appointments,
    this.live_call_price,
    this.home_visit_price,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    List<DoctorSchedule> data = [];
    List<PastAppointment> data1 = [];

    for (var schedule in json["doctor_schedule"]) {
      data.add(DoctorSchedule.fromJson(schedule));
    }

    for (var appoitntment in json["Miadi"]) {
      data1.add(PastAppointment.fromJson(appoitntment));
    }

// PastAppointment
    // var lang = json['lang_proficiency'] as List?;
    // List<LangProficiency> langProficiency =
    //     lang?.map((item) => LangProficiency.fromJson(item)).toList() ?? [];

    return DoctorModel(
      id: json['id'],
      user: UserModel.fromJson(json['user']),
      doctorDepartment: json['doctor_department'],
      specialist: SpecialistModel.fromJson(json['specialist']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      hospital: HospitalModel.fromJson(json['hospital']),
      about: json["about"],
      rate: json["rate"],
      experience: json["experience"],
      salutation: json["salutation"] ?? '',
      live_call_price: json["live_call_price"] ?? 0,
      home_visit_price: json["home_visit_price"] ?? 0,
      doctorSchedule: data,
      appointments: data1,
      langProficiency: json['lang_proficiency'],
    );
  }

  @override
  String toString() {
    return 'DoctorModel{id: $id, user: $user, doctorDepartment: $doctorDepartment, specialist: $specialist, createdAt: $createdAt, updatedAt: $updatedAt, hospital: $hospital, rate: $rate, about: $about, experience: $experience, doctorSchedule: $doctorSchedule, live_call_price: $live_call_price, home_visit_price: $home_visit_price}';
  }
}

class LangProficiency {
  final int id;
  final int userId;
  final String? language_proficiency;
  final String? createdAt;
  final String? updatedAt;

  LangProficiency({
    required this.id,
    required this.userId,
    required this.language_proficiency,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LangProficiency.fromJson(Map<String, dynamic> json) {
    return LangProficiency(
      id: json['id'],
      userId: json['user_id'],
      language_proficiency: json['language_proficiency'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class PastAppointment {
  final String? date;
  final String? time;

  PastAppointment({
    required this.date,
    required this.time,
  });

  factory PastAppointment.fromJson(Map<String, dynamic> json) {
    return PastAppointment(
      date: json['date'],
      time: json['time'],
    );
  }
}

class DoctorSchedule {
  String day;
  String fromDate;
  String toDate;

  DoctorSchedule({
    // ... other constructor parameters
    required this.day,
    required this.fromDate,
    required this.toDate,
  });

  factory DoctorSchedule.fromJson(Map<String, dynamic> json) {
    return DoctorSchedule(
      day: json['day'],
      fromDate: json['from'],
      toDate: json['to'],
    );
  }
}

class UserModel {
  final int id;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? gender;
  final int? departmentId;
  final String? city;
  final String? designation;
  final String? qualification;
  final String? bloodGroup;
  final String? dob;
  final String? emailVerifiedAt;
  final int? status;
  final String? language;
  final String? createdAt;
  final String? updatedAt;
  final int? age;
  final String? image;
  final Address? docAddress;
  // final DepartmentModel department;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.departmentId,
    required this.city,
    required this.designation,
    required this.qualification,
    required this.bloodGroup,
    required this.dob,
    required this.emailVerifiedAt,
    required this.status,
    required this.language,
    required this.createdAt,
    required this.updatedAt,
    required this.age,
    required this.image,
    required this.docAddress,
    // required this.department,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      departmentId: json['department_id'],
      city: json['city'],
      designation: json['designation'],
      qualification: json['qualification'],
      bloodGroup: json['blood_group'],
      dob: json['dob'],
      emailVerifiedAt: json['email_verified_at'],
      status: json['status'],
      language: json['language'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      age: json['age'],
      image: json['image'],
      docAddress:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      // department: DepartmentModel.fromJson(json['department']),
    );
  }

  // @override
  // String toString() {
  //   return 'UserModel{id: $id, fullName: $fullName, email: $email, phone: $phone, gender: $gender, departmentId: $departmentId, city: $city, designation: $designation, qualification: $qualification, bloodGroup: $bloodGroup, dob: $dob, emailVerifiedAt: $emailVerifiedAt, status: $status, language: $language, createdAt: $createdAt, updatedAt: $updatedAt, age: $age, image: $image}';
  // }
}

class Address {
  final RegionModel region;
  final DistrictModel district;

  Address({
    required this.region,
    required this.district,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      region: RegionModel.fromJson(json['region']),
      district: json['district'] != null
          ? DistrictModel.fromJson(json['district'])
          : DistrictModel(id: 0, regionId: 0, name: ''),
    );
  }
}

class RegionModel {
  final int id;
  final String? name;
  final String? lat;
  final String? lng;

  RegionModel({required this.id, this.name, this.lat, this.lng});

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'],
      name: json['name'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class DistrictModel {
  final int id;
  final int? regionId;
  final String? name;

  DistrictModel({required this.id, this.regionId, this.name});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'],
      name: json['name'],
      regionId: json['region_id'],
    );
  }
}

class SpecialistModel {
  final int? id;
  final String? name;
  final dynamic icon;

  SpecialistModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory SpecialistModel.fromJson(Map<String, dynamic> json) {
    return SpecialistModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }

  @override
  String toString() {
    return 'SpecialistModel{id: $id, name: $name, icon: $icon}';
  }
}

class HospitalModel {
  final String? id;
  final String? hospitalName;
  final String? address;
  final dynamic latitude;
  final dynamic longitude;
  final String? contact;
  final String image;
  final double? distance;
  final int isSubscribed;

  HospitalModel({
    required this.id,
    required this.hospitalName,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.contact,
    required this.distance,
    required this.image,
    required this.isSubscribed,
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      id: json['id'],
      hospitalName: json['hospital_name'] ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      contact: json['contact'] ?? '',
      distance: json['distance'] ?? 0.0,
      image: json['image'],
      isSubscribed: json['is_subscribed'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'HospitalModel{hospitalName: $hospitalName, address: $address, latitude: $latitude, longitude: $longitude, contact: $contact}';
  }
}
