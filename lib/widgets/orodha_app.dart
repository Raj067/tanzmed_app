// import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class OrodhaSelectionApps {
  String name;
  int id;
  Widget icon;
  Color color;
  bool isSelected = true;

  OrodhaSelectionApps({
    required this.name,
    required this.id,
    required this.icon,
    required this.color,
    required this.isSelected,
  });
}

// class FacilityService {
//   static final _box = GetStorage();

//   static List<int> getFacilityIds() {
//     List<dynamic>? ids = _box.read('facilityIds');
//     return ids?.cast<int>() ?? [];
//   }
// }

List<OrodhaSelectionApps> orodhaSelectedApps(BuildContext context) => [
      OrodhaSelectionApps(
        isSelected: false,
        id: 2,
        name: "Hospitali",
        color: const Color(0xffedfeff),
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,

              image: DecorationImage(
                image: AssetImage(
                  'assets/images/hospital.png',
                ),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      OrodhaSelectionApps(
        isSelected: false,
        id: 3,
        name: "Zahanati",
        color: const Color(0xfff7ebf9),
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/dispensary.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      OrodhaSelectionApps(
        isSelected: false,
        id: 4,
        name: "Vituo Vya Afya",
        color: const Color(0xfffff8ed),
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/health-center.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      OrodhaSelectionApps(
        isSelected: false,
        id: 5,
        name: "Maduka",
        color: const Color(0xffeef9eb),
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/pharmacy.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      OrodhaSelectionApps(
        isSelected: false,
        id: 9,
        name: "laboratory",
        color: const Color.fromARGB(255, 235, 237, 249),
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/laboratory.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      OrodhaSelectionApps(
        isSelected: false,
        id: 6,
        name: "Kliniki Maalumu",
        color: const Color(0xfffff1ee),
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/images/Specialized-clinic.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      OrodhaSelectionApps(
        isSelected: false,
        id: 13,
        name: "Tiba Popote",
        color: Color.fromARGB(255, 235, 249, 242),
        icon: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              // color: Colors.green,
              image: DecorationImage(
                image: AssetImage('assets/home-visit.png'),
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    ];
