import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../helpers/remove_slash.dart';
import '../helpers/settings.dart';
import '../models/doctor_model.dart';
import '../utils/favourite.dart';
import 'funcs.dart';
import 'home.dart';
import 'time_widget.dart';
import 'track_checkbox.dart';
// import 'package:tanzmed/ui/themes/light/theme.dart';

class PsychologistPage extends StatefulWidget {
  final DoctorModel? doctor;

  // final int? firstDay;
  // final int? appointmentId;
  // final int? consultationType;
  // final DateTime?
  const PsychologistPage({
    super.key,
    required this.doctor,
    // this.appointmentId,
    // this.consultationType,
  });

  @override
  State<PsychologistPage> createState() => _PsychologistPageState();
}

class _PsychologistPageState extends State<PsychologistPage> {
  final GetStorage _likedDoctorsBox = GetStorage('likedDoctors');
  bool fav = false;
  final box = GetStorage();

  final List _dropdownValues = ["15", "30", "60", "120", "300"];
  Object? selectedTime = '15';

  int selectedValue = 2;
  bool isSelectedClicked = false;

  // price calculation var
  int calculatedLivePrice = 0;
  int calculatedHomePrice = 0;

  // DateTime? appointmentDate;

  // initial time
  TimeOfDay? initialTime;

  // end time
  TimeOfDay? endTime;

  TimeOfDay? isSelectedTime;

  void calculatePrice(Object timeSelected) {
    int multiplier = 1;

    if (timeSelected is String) {
      switch (timeSelected) {
        case '15':
          multiplier = 1;
          break;
        case '30':
          multiplier = 2;
          break;
        case '60':
          multiplier = 3;
          break;
        case '120':
          multiplier = 4;
          break;
        case '300':
          multiplier = 5;
          break;
        default:
          // Handle unexpected cases
          return;
      }

      setState(() {
        calculatedLivePrice = widget.doctor!.live_call_price! * multiplier;
        calculatedHomePrice = (widget.doctor!.home_visit_price! * multiplier);
      });
    }
  }

  DateTime originalDate = DateTime.now();
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  String itemMethod() {
    return "minutes";
  }

  bool isLiked = false;

// this help to track the checkbox selected at a time..
  String selectedMethod = '';

  DateTime? initialSelectedAppointmentDate;

  @override
  void initState() {
    box.write('appointmentDuration', "15");
    calculatedLivePrice = widget.doctor!.live_call_price!;
    calculatedHomePrice = widget.doctor!.home_visit_price!;
    isLiked =
        _likedDoctorsBox.read("doctor-${widget.doctor!.user.id}") ?? false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DoctorModel? doctor = widget.doctor;
    // get the doctor id and store in get_storage
    if (box.read('appointed_doctor_id') == null) {
      // If the current value is null, write the new value
      box.write('appointed_doctor_id', doctor!.id);
      box.write('department_id', doctor.doctorDepartment);
      box.write('tenant_id', doctor.hospital.id);
    } else {
      // If the current value exists, remove it and write the new value
      box.remove('appointed_doctor_id');
      box.remove('department_id');
      box.remove('tenant_id');
      box.write('appointed_doctor_id', doctor!.id);
      box.write('department_id', doctor.doctorDepartment);
      box.write('tenant_id', doctor.hospital.id);
    }
    double defVal = 15.0;
    num pricePerMinuteLive = doctor.live_call_price ?? defVal / 15;
    num pricePerMinuteHome = doctor.home_visit_price ?? defVal / 15;

    int numberOfDays = 28;

    // String keyValue = 'available_day';
    // List<DateTime>? dateTimeList =
    //     extractDates(doctor.doctorSchedule, keyValue);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            box.remove('home_visit_price');
            box.remove('live_call_price');
            box.remove('consultation_type');
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          doctor.user.fullName.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          // systemNavigationBarColor: TwitterColor.black,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppSettings.primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          InkResponse(
            onTap: () {
              // Share.share(
              //     'Hey! Check out ${doctor.user.fullName} from TanzMed app\n'
              //     'https://portal.tanzmed.africa/doctors/${doctor.id}');
            },
            child: Image.asset(
              'assets/icon/share-icon.png',
              height: 32,
              width: 32,
            ),
          ),
          IconButton(
            onPressed: () {
              if (box.read("access_token") == null) {
                // Get.to(const LoginPage());
              } else {
                favouriteFunction(context,
                    favouriteId: doctor.user.id, favouriteType: 0);
                setState(() {
                  isLiked = !isLiked;
                  box.write("doctor-${doctor.user.id}", isLiked);
                });
                setState(() {
                  fav = !isLiked;
                  _likedDoctorsBox.write(doctor.user.id.toString(), fav);
                });
              }
            },
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.white : Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 120,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                image: AssetImage('assets/images/doctors-background.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppSettings.primaryColor.withOpacity(0.05),
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        doctor.user.image!.contains('ui-avatars.com')
                            ? removeDoubleSlash(doctor.user.image
                                .toString()) // Use the UI Avatar URL directly
                            : doctor.user.image.toString(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        doctor.user.fullName ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        children: [
                          const Text(
                            'speciality :',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              getSpecialityName(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "experience",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                          Text(
                            '${doctor.experience ?? 1}+ '
                            ' experienceYears',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "rating",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                          Text(
                            doctor.rate == 0 ? '--' : doctor.rate.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "about",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  doctor.about.toString(),
                  style: const TextStyle(color: Colors.grey),
                  // maxLines: 2,
                  // overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          //.....Column Showing Available Date.....
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "availableDate",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  color: Colors.grey.withAlpha(100),
                  height: 125,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.doctor!.doctorSchedule.isEmpty
                          ? const Center(
                              child: Text(
                                "doctorUnavailable",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            )
                          : DatePicker(
                              DateTime.now(),
                              height: 100,
                              deactivatedColor: Colors.grey.shade400,
                              daysCount: numberOfDays,
                              activeDates: getNextTwoWeeks(widget
                                      .doctor!.doctorSchedule
                                      .map((e) => e.day)
                                      .toList())
                                  .toList(),
                              initialSelectedDate:
                                  initialSelectedAppointmentDate,
                              selectionColor: AppSettings.primaryColor,
                              selectedTextColor: Colors.white,
                              onDateChange: (date) {
                                setState(() {
                                  initialSelectedAppointmentDate = date;
                                  // box.read('appointmentTime');
                                  box.write('appointmentDate', date.toString());
                                  var schedule = widget.doctor!.doctorSchedule
                                      .where((element) =>
                                          getDate(element.day, date) == date)
                                      .toList()
                                      .firstOrNull;
                                  // print(widget
                                  // .doctor.doctorSchedule
                                  // .where((element) =>
                                  //     getDate(element.day, date) == date)
                                  // .toList());
                                  // print(initialSelectedAppointmentDate);
                                  isSelectedTime = null;

                                  initialTime =
                                      parseTimeString(schedule!.fromDate);
                                  endTime = parseTimeString(schedule.toDate);
                                });
                              },
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                widget.doctor!.doctorSchedule.isEmpty
                    ? Container()
                    : Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "availableTime",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // TimeWidget
                          TimeWidget(
                              fromTime: initialTime,
                              toTime: endTime,
                              isSelectedTime: isSelectedTime,
                              selectedDate: initialSelectedAppointmentDate,
                              doctor: widget.doctor!,
                              updateTime: (timeLabel) {
                                setState(() {
                                  isSelectedTime = timeLabel;
                                });
                              }),

                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Text(
                                "selectDuration",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: AppSettings.primaryColor.withOpacity(0.05),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                items: _dropdownValues
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                BootstrapIcons.clock_fill,
                                                color: AppSettings.primaryColor,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 10),
                                              Text('$value minutes'),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedTime = value;
                                    calculatePrice(selectedTime!);
                                  });
                                  box.write(
                                      'appointmentDuration', selectedTime);
                                },
                                isExpanded: true,
                                value: selectedTime,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              Text(
                                "selectPackage",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          if (widget.doctor!.live_call_price != null &&
                              widget.doctor!.live_call_price != 0)
                            selectMethods(
                              context,
                              icon: 'assets/images/video-conference.png',
                              title: "liveCall",
                              description: "liveCallDesc",
                              amount: calculatedLivePrice == 0
                                  ? 'Tsh ${NumberFormat("#,###", "sw_TZ").format(doctor.live_call_price)}'
                                      " /$selectedTime minutes"
                                  : 'Tsh ${NumberFormat("#,###", "sw_TZ").format(calculatedLivePrice)}'
                                      " /$selectedTime minutes",
                              duration:
                                  '${pricePerMinuteLive.round().toString()}/ minutes',
                              isSelected: selectedMethod == "liveCall",
                              onChanged: (selected) {
                                setState(() {
                                  selectedMethod = selected ? "liveCall" : '';
                                });
                                if (selected == true) {
                                  box.write('consultation_type', 0);
                                  box.write(
                                    'live_call_price',
                                    calculatedLivePrice == 0
                                        ? doctor.live_call_price
                                        : calculatedLivePrice,
                                  );
                                  box.write(
                                      'pricePerMinuteLive', pricePerMinuteLive);
                                } else {
                                  box.remove('home_visit_price');
                                  box.remove('live_call_price');
                                  box.remove('consultation_type');
                                  box.remove('pricePerMinuteLive');
                                }
                              },
                            ),
                          if (widget.doctor!.home_visit_price != null &&
                              widget.doctor!.home_visit_price != 0)
                            selectMethods(
                              context,
                              icon: 'assets/icon/home-icon-silhouette.png',
                              title: "homeVisit",
                              description: "physicalMeetWithDoctorDesc",
                              amount: calculatedHomePrice == 0
                                  ? 'Tsh ${NumberFormat("#,###", "sw_TZ").format(doctor.home_visit_price)}'
                                      " /$selectedTime minutes"
                                  : ' Tsh ${NumberFormat("#,###", "sw_TZ").format(calculatedHomePrice)}'
                                      " /$selectedTime minutes",
                              duration:
                                  '${pricePerMinuteHome.round().toString()}/minutes',
                              isSelected: selectedMethod == "honeVisit",
                              onChanged: (selected) {
                                setState(() {
                                  selectedMethod = selected ? "honeVisit" : '';
                                });
                                if (selected == true) {
                                  box.write('consultation_type', 2);
                                  box.write(
                                      'home_visit_price',
                                      calculatedHomePrice == 0
                                          ? doctor.home_visit_price
                                          : calculatedHomePrice);
                                  box.write(
                                      'pricePerMinuteHome', pricePerMinuteHome);
                                } else {
                                  box.remove('home_visit_price');
                                  box.remove('live_call_price');
                                  box.remove('consultation_type');
                                  box.remove('pricePerMinuteHome');
                                }
                              },
                            ),
                          doctor.hospital.isSubscribed == 0
                              ? Container()
                              : selectMethods(
                                  context,
                                  icon: 'assets/home/facility.png',
                                  title: "physicalMeetWithDoctor",
                                  description: "freeOfCharge",
                                  amount: "Free",
                                  duration: 'Free',
                                  isSelected: selectedMethod == "freeOfCharge",
                                  onChanged: (selected) {
                                    setState(() {
                                      selectedMethod =
                                          selected ? "freeOfCharge" : '';
                                    });
                                    if (selected == true) {
                                      box.remove('home_visit_price');
                                      box.remove('live_call_price');
                                      box.remove('consultation_type');
                                      box.write('consultation_type', 1);
                                      box.remove('pricePerMinuteLive');
                                      box.remove('pricePerMinuteHome');
                                    } else {
                                      box.remove('home_visit_price');
                                      box.remove('live_call_price');
                                      box.remove('consultation_type');
                                    }
                                  },
                                ),
                          const SizedBox(height: 10),
                          box.read('consultation_type') == null
                              ? GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(
                                          'Please selectPackage',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppSettings.primaryColor,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "addToCart",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    if (isSelectedTime == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text("pleaseSelectTime"),
                                        ),
                                      );
                                    } else {
                                      // Get.to(CartMainPage(
                                      //   doctor: doctor,
                                      //   psychologist: 'psychologist',
                                      //   consultation_type:
                                      //       box.read('consultation_type'),
                                      //   live_call_price: calculatedLivePrice,
                                      //   home_visit_price: calculatedHomePrice,
                                      //   selectedDuration:
                                      //       int.parse(selectedTime.toString()),
                                      //   appointmentDate:
                                      //       initialSelectedAppointmentDate,
                                      //   appointmentTime: isSelectedTime,
                                      // ));
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppSettings.primaryColor,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "addToCart",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      )
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget selectMethods(
    BuildContext context, {
    required String icon,
    required String title,
    required String description,
    required String amount,
    required String duration,
    required bool isSelected,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppSettings.primaryColor.withOpacity(0.2),
                  ),
                  child: Image.asset(icon),
                ),
                const SizedBox(width: 10),
                //......column for text Massaging.......
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          description,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 7.0),
                Text(
                  amount,
                  // style: TextStyle(fontSize: 12,),
                ),
                const SizedBox(width: 7.0),
                TrackCheckBox(
                  title: title,
                  onChanged: onChanged,
                  isSelected: isSelected,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String getSpecialityName() {
    String speciality = "";
    SpecialistsApps? specialistsApps = specialitiesHomeApps(context)
        .firstWhereOrNull(
            (element) => element.id == widget.doctor!.specialist.id);
    if (specialistsApps != null) {
      speciality = specialistsApps.name;
    }
    return speciality;
  }
}

TimeOfDay parseTimeString(String timeString) {
  DateTime dateTime = DateFormat('hh:mm').parse(timeString);
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}
