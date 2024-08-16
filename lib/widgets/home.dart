import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SpecialistsApps {
  int id;
  String name;
  Widget icon;
  bool value;
  SpecialistsApps({
    required this.name,
    required this.icon,
    required this.value,
    required this.id,
  });
}

class CommunicationType {
  int id;
  String name;
  String icon;
  bool value;
  CommunicationType(
      {required this.id,
      required this.name,
      required this.icon,
      required this.value});
}

List<CommunicationType> communicationType = [
  CommunicationType(
    id: 1,
    name: 'Live call',
    icon: 'assets/images/video-conference.png',
    value: false,
  ),
  CommunicationType(
      id: 2,
      name: 'Home visit',
      icon: 'assets/icon/home-icon-silhouette.png',
      value: false),
  CommunicationType(
    id: 3,
    name: 'On site',
    icon: 'assets/home/facility.png',
    value: false,
  ),
];

// assets/images/doctor.png

class SpecialityService {
  static final _box = GetStorage();

  static List<int> getSpecialityIds() {
    List<dynamic>? ids = _box.read('specilityIds');
    return ids?.cast<int>() ?? [];
  }
}

// assets/images/cancer.png
List<SpecialistsApps> specialitiesHomeApps(BuildContext context) => [
      SpecialistsApps(
        id: 1,
        value: false,
        name: "general",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/doctor.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 2,
        value: false,
        name: "pediatrics",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,

              image: DecorationImage(
                image: AssetImage(
                  'assets/images/pediatrics.png',
                ),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 3,
        value: false,
        name: "gynecology",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/gynacolo.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 5,
        value: false,
        name: "mentalHealth",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/Mental_Health.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 24,
        value: false,
        name: "diabetes",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/diabetes-test.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 6,
        value: false,
        name: "cardiology",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/moyeo.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 7,
        value: false,
        name: "dermatology",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/dermatology2.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 8,
        value: false,
        name: "eNT",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/ENsT.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 9,
        value: false,
        name: "urology",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/Urology_Mfumo_wa_mkojo.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 10,
        value: false,
        name: "ophthalmology",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/Ophthalmology.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 11,
        value: false,
        name: "internalMedicine",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/Internal_Medicine.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 12,
        value: false,
        name: "orthopedics",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/orthopedic.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 13,
        value: false,
        name: "neurology",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/neuroseurgery.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 14,
        value: false,
        name: "gastroenterology",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/stomach.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 15,
        value: false,
        name: "oncology",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/Oncology.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 16,
        value: false,
        name: "endocrinology",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/Endocrinology.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 17,
        value: false,
        name: "physiotherapy",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/Physiotherapy.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 18,
        value: false,
        name: "hivaidss",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/HIV-Aids.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 25,
        value: false,
        name: "nursing",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/nursing.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 26,
        value: false,
        name: "tibaYaUfahamu",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/ocupational-therapy.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SpecialistsApps(
        id: 27,
        value: false,
        name: "nutrition",
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/nutrition.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    ];
