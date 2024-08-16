import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tanzmed/helpers/settings.dart';
import 'package:tanzmed/pages/jifunze_zaidi.dart';
import 'package:tanzmed/pages/risk_assessment.dart';

import '../ctc_centers.dart';
import 'custom_risk_factor_gauge.dart';

class TabiaAnswersPage extends StatefulWidget {
  final List<dynamic> answerValues;
  final dynamic totalContribution;

  const TabiaAnswersPage({
    Key? key,
    required this.answerValues,
    required this.totalContribution,
  }) : super(key: key);

  @override
  State<TabiaAnswersPage> createState() => _TabiaAnswersPageState();
}

class _TabiaAnswersPageState extends State<TabiaAnswersPage> {
  final double angle = 0;

  final box = GetStorage();

  getText(dynamic intervalVariable) {
    String textToShow = '';
    if (intervalVariable >= 0 && intervalVariable <= 25) {
      textToShow = "Ndogo";
    } else if (intervalVariable >= 26 && intervalVariable <= 50) {
      textToShow = "Kawaida";
    } else if (intervalVariable >= 51 && intervalVariable <= 74) {
      textToShow = "Kubwa";
    } else {
      textToShow = "Hatari";
    }
    return textToShow;
  }

  getResultText(dynamic intervalVariable) {
    String textToShow = '';
    if (intervalVariable >= 0 && intervalVariable <= 25) {
      textToShow =
          "Hongera! matokeo ya kikokotozi yanaonesha upo kwenye nafasi ya ndogo ya kupata maambukizi ya virusi vya Ukimwi, unashauriwa kuendelea kuzingatia kanuni sahihi za kujilinda na virusi vya ukimwi na kujiepusha na tabia hatarishi. Pia, tunakushauri utembelee kituo cha Afya kilicho karibu nawe kwa ajili ya vipimo  vya virusi vya Ukimwi ili kujua hali yako.";
    } else if (intervalVariable >= 26 && intervalVariable <= 50) {
      textToShow =
          "Matokeo ya kikokotozi yanaonesha upo kwenye wastani wa kati wa kupata maambukizi ya virusi vya Ukimwi. Unashauriwa kubadili mwenendo wa tabia hatarishi na kutembelea kituo cha kutolea huduma za afya kwa  ajili ya ushauri nasaa kuhusu Ukimwi na Virusi vya ukimwi ikiwemo upimaji.";
    } else if (intervalVariable >= 51 && intervalVariable <= 74) {
      textToShow =
          "Matokeo ya kikokotozi yanaonesha upo kwenye nafasi kubwa ya kupata maambukizi ya virusi vya Ukimwi. Kulingana na taarifa zako, unashauriwa haraka iwezekanavyo kutembelea kituo cha kutolea huduma za afya kwa ajili ya ushauri nasaa kuhusu Ukimwi na Virusi vya ukimwi ikiwemo upimaji.";
    } else {
      textToShow =
          "Matokeo ya kikokotozi yanaonesha upo kwenye hatari kubwa mno ya kupata maambukizi ya virusi vya Ukimwi. Kulingana na taarifa zako, unashauriwa haraka iwezekanavyo kutembelea kituo cha kutolea huduma za afya kwa ajili ya ushauri nasaa kuhusu Ukimwi na Virusi vya ukimwi ikiwemo upimaji.";
    }
    return textToShow;
  }

  getEmoji(dynamic intervalVariable) {
    Widget icon = const Icon(
      BootstrapIcons.emoji_angry_fill,
      color: Colors.white,
      size: 80,
    );
    if (intervalVariable >= 0 && intervalVariable <= 25) {
      icon = const Icon(
        BootstrapIcons.emoji_laughing_fill,
        color: Colors.white,
        size: 80,
      );
    } else if (intervalVariable >= 26 && intervalVariable <= 50) {
      icon = const Icon(
        BootstrapIcons.emoji_neutral_fill,
        color: Colors.white,
        size: 80,
      );
    } else if (intervalVariable >= 51 && intervalVariable <= 74) {
      icon = const Icon(
        BootstrapIcons.emoji_astonished_fill,
        color: Colors.white,
        size: 80,
      );
    } else {
      icon = const Icon(
        BootstrapIcons.emoji_angry_fill,
        color: Colors.white,
        size: 80,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.answerValues);
    // print(widget.totalContribution);
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Matokeo ya kikokotozi",
            style: TextStyle(
              color: Colors.white,
            ),
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
          leading: IconButton(
            onPressed: () {
              Get.back();
              Get.back();
              Get.to(() => const RiskAssessment());
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          )),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(height: 10),
          RiskFactorGauge(
            gaugeValue: widget.totalContribution,
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.grey),
          Center(
            child: Text(
              getText(widget.totalContribution),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 120,
            width: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppSettings.primaryColor,
            ),
            child: Center(
              child: getEmoji(widget.totalContribution),
            ),
          ),
          const SizedBox(height: 10),
          Text(getResultText(widget.totalContribution)),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              children: [
                singleApp(
                    title: "Pata Ushauri \nNasaha",
                    icon: "assets/icon/patient.png",
                    color: Colors.purple,
                    action: () {},
                    isUshauri: true),
                singleApp(
                    title: "Kapime au \nPata Zana",
                    icon: "assets/hospital.png",
                    color: AppSettings.primaryColor,
                    action: () {
                      Get.to(const CTCCenters());
                    },
                    isUshauri: false),
                singleApp(
                    title: "Jifunze \nzaidi",
                    icon: "assets/elimika.png",
                    color: AppSettings.ushauriColor,
                    action: () {
                      Get.to(const JifunzeZaidi());
                    },
                    isUshauri: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  singleApp({
    required String title,
    required String icon,
    required var color,
    required Function() action,
    required bool isUshauri,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: action,
        child: Container(
          height: 100,
          width: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  // color: Colors.green,
                  image: DecorationImage(
                    image: AssetImage(icon),
                    // fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class HalfCircleGauge extends StatelessWidget {
//   const HalfCircleGauge({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SfRadialGauge(
//       axes: <RadialAxis>[
//         RadialAxis(
//           startAngle: 180,
//           endAngle: 0,
//           // backgroundImage: const AssetImage("assets/images/Gauge-meter.png"),
//           pointers: const <GaugePointer>[
//             NeedlePointer(
//               value: 65.0,
//               enableAnimation: true,
//               animationDuration: 1000,
//               needleLength: 0.9,
//               lengthUnit: GaugeSizeUnit.factor,
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }

class HalfCircleGauge extends StatefulWidget {
  const HalfCircleGauge({super.key});

  @override
  _HalfCircleGaugeState createState() => _HalfCircleGaugeState();
}

class _HalfCircleGaugeState extends State<HalfCircleGauge> {
  double value = 65.0; // Set the initial value between 0 and 100

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          showLabels: true,
          showLastLabel: true,
          showTicks: false,
          startAngle: 180,
          endAngle: 0,
          // backgroundImage: AssetImage("assets/images/Gauge-meter.png"),
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  _getTextForValue(value),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            )
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: value,
              enableAnimation: true,
              animationDuration: 1000,
              needleLength: 0.7,
              lengthUnit: GaugeSizeUnit.factor,
            )
          ],
        ),
      ],
    );
  }

  String _getTextForValue(double value) {
    if (value >= 0 && value < 25) {
      return 'Ndogo';
    } else if (value >= 25 && value < 50) {
      return 'Kawaida';
    } else if (value >= 50 && value < 75) {
      return 'Kubwa';
    } else {
      return 'Hatari';
    }
  }
}
