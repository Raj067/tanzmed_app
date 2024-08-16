import 'dart:io';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rate/rate.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tanzmed/helpers/settings.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({
    super.key,
    required this.isSpecialist,
    required this.isOrodha,
  });
  final bool isSpecialist;
  final bool isOrodha;

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int selectedRadio = 0;
  int selectedRates = 0;
  int distance = 0;
  // bool isSelected = false;
  double customValue = 0;
  // double min = 0.0;

  final box = GetStorage();

  void setSelectedRadio(int val) {
    setState(() {
      box.write('selectedRadio', val);
      selectedRadio = val;
    });
    if (val == 0) {
      distance = 1;
    } else if (val == 1) {
      distance = 5;
    } else if (val == 2) {
      distance = 10;
    } else if (val == 3) {
      distance = 20;
    } else if (val == 4) {
      distance = 25;
    }
    box.write('umbaliSelected', distance);
  }

  // void setSelectedRates(int val) {
  //   setState(() {
  //     selectedRates = val;
  //   });
  //   box.write('selectedRates', selectedRates);
  // }

  // void selectFacility(int id) {
  //   box.write('FacilityCategoryId', id);
  // }

  // static List<int> getFacilityIds() {
  //   List<dynamic>? ids = _box.read('facilityIds');
  //   return ids?.cast<int>() ?? [];
  // }

  // static void toggleFacilityId(int id) {
  //   List<int> ids = getFacilityIds();

  //   if (ids.contains(id)) {
  //     ids.remove(id);
  //   } else {
  //     ids.add(id);
  //   }

  //   _box.write('facilityIds', ids);
  // }

  // List<int> selectedFacilityIds = FacilityService.getFacilityIds();

  List selectedBima = [];
  List selectedFacilities = [];
  List selectedGroup = [];
  List selectedRate = [];

  @override
  void initState() {
    selectedRadio = box.read('selectedRadio') ?? 0;
    selectedBima = box.read('selectedBima') ?? [];
    selectedFacilities = box.read('selectedFacilities') ?? [];
    selectedGroup = box.read('selectedGroup') ?? [];
    selectedRate = box.read('selectedRate') ?? [];
    customValue = box.read('customValue') ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "filters",
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            // Get.offAll(EntryPage());
          },
          icon: const Icon(Icons.arrow_back),
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
      ),
//       body: ListView(
//         padding: const EdgeInsets.only(top: 10, bottom: 10),
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 10.0, left: 10),
//             child: Row(
//               children: [
//                 const Icon(BootstrapIcons.geo_alt),
//                 const SizedBox(width: 10),
//                 // UserLocation(),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 8.0, left: 10, top: 10.0),
//             child: Text(
//               "umbali",
//               style: const TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ),

//           //.......Set Distance ...........
//           Container(
//             height: 100,
//             padding: const EdgeInsets.all(10),
//             margin: const EdgeInsets.only(left: 10, right: 10),
//             decoration: BoxDecoration(
//               // shape: BoxShape.circle,
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(10),
//               ),
//               color: Color(0xffE1E8ED).withAlpha(100), //.withAlpha(50),
//             ),
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: [
//                 Column(
//                   children: [
//                     Row(
//                       // mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         for (int i = 0; i < 5; i++)
//                           Row(
//                             children: [
//                               Radio(
//                                 value: i,
//                                 groupValue: selectedRadio,
//                                 onChanged: (val) {
//                                   setSelectedRadio(val as int);
//                                 },
//                               ),
//                               if (i < 4)
//                                 Container(
//                                   width: 25.0,
//                                   height: 2.0,
//                                   color: Color(0xffE1E8ED),
//                                 ),
//                             ],
//                           ),
//                       ],
//                     ),
//                     const SizedBox(
//                       width: 320,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("1Km"),
//                           Text("5Km"),
//                           Text("10Km"),
//                           Text("20Km"),
//                           Text("25Km"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           //.......price slider........
//           widget.isOrodha == false
//               ? Padding(
//                   padding:
//                       const EdgeInsets.only(bottom: 0.0, left: 10, top: 10.0),
//                   child: Text(
//                     '${AppLocalizations.of(context)!.price} ${AppLocalizations.of(context)!.from}: ${AppLocalizations.of(context)!.dolarSign}${0 + 1 * 10 * int.parse(AppLocalizations.of(context)!.dollarToTsh)}  ${AppLocalizations.of(context)!.to}: ${AppLocalizations.of(context)!.dolarSign}${customValue * 10 * int.parse(AppLocalizations.of(context)!.dollarToTsh)}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 )
//               : Container(),
//           widget.isOrodha == false
//               ? Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     height: 45,
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           const Icon(
//                             BootstrapIcons.coin,
//                             size: 20,
//                           ),
//                           sizedBoxW7,
//                           Expanded(
//                             child: Slider(
//                               value: 0.2,
//                               min: 0.0,
//                               max: 1.0,
//                               divisions: 5,
//                               activeColor: primaryColor,
//                               inactiveColor: primaryColor.withOpacity(0.2),

//                               // label:AppLocalizations.of(context)!.setPriceValue,

//                               onChanged: (double newValue) {
//                                 setState(() {
//                                   customValue = newValue;
//                                   box.write("customValue", customValue);
//                                 });
//                               },
//                               semanticFormatterCallback: (double newValue) {
//                                 return '${newValue.round()} dollars';
//                               },
//                             ),
//                           ),
//                         ]),
//                   ),
//                 )
//               : Container(),
//           //.......name specialists........
//           widget.isOrodha == false || widget.isSpecialist == true
//               ? Padding(
//                   padding:
//                       const EdgeInsets.only(bottom: 8.0, left: 10, top: 10.0),
//                   child: Text(
//                     AppLocalizations.of(context)!.specialities,
//                     style: const TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 )
//               : Container(),

//           //........List of specialists..........

//           widget.isSpecialist == true
//               ? SizedBox(
//                   height: 100,
//                   // color: Colors.green,
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.symmetric(horizontal: 0),
//                     children: List.generate(
//                       specialitiesHomeApps(context).length,
//                       (index) => Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: GestureDetector(
//                           onTap: () {
//                             // selectedGroup
//                             List myData1 = box.read('selectedGroup') ?? [];
//                             if (!myData1.contains(
//                                 specialitiesHomeApps(context)[index].id)) {
//                               myData1
//                                   .add(specialitiesHomeApps(context)[index].id);
//                               box.write('selectedGroup', myData1);
//                             } else {
//                               myData1.remove(
//                                   specialitiesHomeApps(context)[index].id);
//                               box.write('selectedGroup', myData1);
//                             }
//                             setState(() {
//                               selectedGroup = myData1;
//                             });

//                             // setState(() {
//                             //   specialitiesHomeApps(context)[index].value =
//                             //       !specialitiesHomeApps(context)[index]
//                             //           .value;
//                             // });
//                             // print(specialitiesHomeApps(context)[index]
//                             //     .value);
//                           },
//                           child: Container(
//                             width: 100,
//                             height: 100,
//                             decoration: BoxDecoration(
//                               // shape: BoxShape.circle,
//                               borderRadius: const BorderRadius.all(
//                                 Radius.circular(20),
//                               ),
//                               color: selectedGroup.contains(
//                                 specialitiesHomeApps(context)[index].id,
//                               )
//                                   ? orodhaColor
//                                   : orodhaColor.withOpacity(0.2),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Center(
//                                   child:
//                                       specialitiesHomeApps(context)[index].icon,
//                                 ),
//                                 // const SizedBox(height: 10),
//                                 Padding(
//                                   padding: const EdgeInsets.fromLTRB(
//                                       8.0, 0, 8.0, 4.0),
//                                   child: Text(
//                                     specialitiesHomeApps(context)[index].name,
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 12,
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               : Container(),

//           //....Name Facility.....
//           widget.isOrodha == false
//               ? Padding(
//                   padding:
//                       const EdgeInsets.only(bottom: 8.0, left: 10, top: 10.0),
//                   child: Text(
//                     AppLocalizations.of(context)!.type,
//                     style: const TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 )
//               : Padding(
//                   padding:
//                       const EdgeInsets.only(bottom: 8.0, left: 10, top: 10.0),
//                   child: Text(
//                     AppLocalizations.of(context)!.facilityType,
//                     style: const TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),

//           //........Lists of Facilities ...........
//           widget.isOrodha == true
//               ? SizedBox(
//                   height: 100,
//                   // color: Colors.green,
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     padding: const EdgeInsets.symmetric(horizontal: 0),
//                     children: List.generate(
//                       orodhaSelectedApps(context).length,
//                       (index) => Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: GestureDetector(
//                           onTap: () {
//                             // selectFacility(orodhaSelectedApps[index].id);
//                             // toggleFacilityId(orodhaSelectedApps[index].id);

//                             // selectedFacilities
//                             List myData = box.read('selectedFacilities') ?? [];
//                             if (!myData.contains(
//                                 orodhaSelectedApps(context)[index].id)) {
//                               myData.add(orodhaSelectedApps(context)[index].id);
//                               box.write('selectedFacilities', myData);
//                             } else {
//                               myData.remove(
//                                   orodhaSelectedApps(context)[index].id);
//                               box.write('selectedFacilities', myData);
//                             }
//                             setState(() {
//                               selectedFacilities = myData;
//                             });
//                           },
//                           child: Container(
//                             width: 100,
//                             height: 100,
//                             decoration: BoxDecoration(
//                               // shape: BoxShape.circle,
//                               borderRadius: const BorderRadius.all(
//                                 Radius.circular(20),
//                               ),
//                               color: selectedFacilities.contains(
//                                       orodhaSelectedApps(context)[index].id)
//                                   ? Color(0xffE1E8ED).withOpacity(0.3)
//                                   : orodhaSelectedApps(context)[index]
//                                       .color, //.withAlpha(50),
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Center(
//                                   child:
//                                       orodhaSelectedApps(context)[index].icon,
//                                 ),
//                                 // const SizedBox(height: 10),
//                                 Text(
//                                   orodhaSelectedApps(context)[index].name,
//                                   style: const TextStyle(
//                                     color: orodhaColor,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               : SizedBox(
//                   width: 100,
//                   height: 115,
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     children: List.generate(
//                       communicationType.length,
//                       (index) => GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             communicationType[index].value =
//                                 !communicationType[index].value;
//                           });
//                         },
//                         child: communicationType[index].value == false
//                             ? selectMethods(context,
//                                 icon: communicationType[index].icon,
//                                 title: communicationType[index].name,
//                                 color: Colors.transparent)
//                             : GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     communicationType[index].value =
//                                         !communicationType[index].value;
//                                   });
//                                 },
//                                 child: selectMethods(context,
//                                     icon: communicationType[index].icon,
//                                     title: communicationType[index].name,
//                                     color: primaryColor.withOpacity(0.2)),
//                               ),
//                       ),
//                     ),
//                   ),
//                 ),

// //.....insurance title........

//           Padding(
//             padding: const EdgeInsets.only(bottom: 8.0, left: 10, top: 10.0),
//             child: Text(
//               AppLocalizations.of(context)!.insurance,
//               style: const TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ),

//           //......Insurance Lists......
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             height: 50,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.only(right: 10),
//               children: List.generate(
//                 bimaModel.length,
//                 (index) => Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: GestureDetector(
//                     onTap: () {
//                       List myData = box.read('selectedBima') ?? [];
//                       if (!myData.contains(bimaModel[index].id)) {
//                         myData.add(bimaModel[index].id);
//                         box.write('selectedBima', myData);
//                       } else {
//                         myData.remove(bimaModel[index].id);
//                         box.write('selectedBima', myData);
//                       }
//                       setState(() {
//                         selectedBima = myData;
//                       });
//                     },
//                     child: Container(
//                       // width: 100,
//                       height: 50,
//                       padding: const EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         // shape: BoxShape.circle,
//                         borderRadius: const BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                         border: !selectedBima.contains(bimaModel[index].id)
//                             ? null
//                             : Border.all(color: kgreyColor),
//                         color: AppColor.extraLightGrey
//                             .withAlpha(100), //.withAlpha(50),
//                       ),
//                       child: Container(
//                         height: 42,
//                         width: 50,
//                         decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                           // image: DecorationImage(
//                           //   fit: BoxFit.fitWidth,
//                           //   image: AssetImage(
//                           //     bimaModel[index].label,
//                           //   ),
//                           // ),
//                         ),
//                         child: Image.asset(
//                           bimaModel[index].label,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           //......Rating title.......
//           Padding(
//             padding: const EdgeInsets.only(bottom: 8.0, left: 10, top: 8.0),
//             child: Text(
//               AppLocalizations.of(context)!.rating,
//               style: const TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ),

//           //.......Rating List......
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             height: 50,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.only(right: 10),
//               children: List.generate(
//                 5,
//                 (index) => Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: GestureDetector(
//                     onTap: () {
//                       // setSelectedRates(index);
//                       List myData = box.read('selectedRate') ?? [];
//                       if (!myData.contains(index)) {
//                         myData.add(index);
//                         box.write('selectedRate', myData);
//                       } else {
//                         myData.remove(index);
//                         box.write('selectedRate', myData);
//                       }
//                       setState(() {
//                         selectedRate = myData;
//                       });
//                     },
//                     child: Container(
//                       // width: 100,
//                       height: 50,
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                           // shape: BoxShape.circle,
//                           borderRadius: const BorderRadius.all(
//                             Radius.circular(10),
//                           ),
//                           color: AppColor.extraLightGrey.withAlpha(100),
//                           border: selectedRate.contains(index)
//                               ? Border.all(color: kgreyColor)
//                               : null //.withAlpha(50),
//                           ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Rate(
//                             iconSize: 16,
//                             color: Colors.orange,
//                             allowHalf: true,
//                             allowClear: true,
//                             initialValue: index.toDouble() + 1,
//                             readOnly: true,
//                             onChange: (value) {},
//                             // {setSelectedRates(value as int)},
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         padding: Platform.isIOS ? const EdgeInsets.only(bottom: 20) : null,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ElevatedButton(
//                 style:  const ButtonStyle(
//                   elevation: MaterialStatePropertyAll(0),
//                   backgroundColor: MaterialStatePropertyAll<Color>(kred500Color),
//                   foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
//                 ),
//                 onPressed: () {
//                   box.remove('facilityIds');
//                   box.remove('umbaliSelected');
//                   box.remove('selectedRadio');
//                   box.write('selectedBima', []);
//                   box.write('selectedFacilities', []);
//                   box.write('selectedGroup', []);
//                   box.write('selectedRate', []);
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return ResetPopUp(
//                         confirmationMessage: AppLocalizations.of(context)!
//                             .yourChangesHasBeenResetted,
//                       );
//                     },
//                   );
//                 },
//                 child: Text(AppLocalizations.of(context)!.reset),
//               ),
//               ElevatedButton(
//                 style:  const ButtonStyle(
//                   elevation: MaterialStatePropertyAll(0),
//                   backgroundColor: MaterialStatePropertyAll<Color>(orodhaColor),
//                   foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
//                 ),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return ConfirmationDialog(
//                         confirmationMessage:
//                             AppLocalizations.of(context)!.yourChangesHasBeenSaved,
//                       );
//                     },
//                   );
//                 },
//                 child: Text(AppLocalizations.of(context)!.save),
//               ),
//             ],
//           ),
//         ),
//       ),
    );
  }

  // Widget selectMethods(BuildContext context,
  //     {required String icon, required String title, required Color color}) {
  //   return Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Container(
  //         padding: const EdgeInsets.all(10.0),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             color: color,
  //             border: Border.all(color: kgreyColor)),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Container(
  //               height: 45,
  //               width: 45,
  //               padding: const EdgeInsets.all(13),
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 color: primaryColor.withOpacity(0.2),
  //               ),
  //               child: Image.asset(icon),
  //             ),

  //             //......column for text Massaging.......

  //             sizedBoxH7,
  //             SizedBox(
  //               width: 70,
  //               child: Text(
  //                 title,
  //                 maxLines: 1,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ),
  //             // sizedBoxW7,
  //           ],
  //         ),
  //       ));
  // }
}
