import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tanzmed/helpers/settings.dart';

class LabelDetails {
  LabelDetails(this.labelPoint, this.customizedLabel);
  int labelPoint;
  String customizedLabel;
}

class RiskFactorGauge extends StatefulWidget {
  const RiskFactorGauge({
    super.key,
    required this.gaugeValue,
  });
  final double gaugeValue;

  @override
  State<RiskFactorGauge> createState() => _RiskFactorGaugeState();
}

class _RiskFactorGaugeState extends State<RiskFactorGauge> {
  final double pointerValue = 150.0;

  final List<Color> segmentColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
  ];
  int segmentsCount = 5;
  late List<LabelDetails> _labels;

  @override
  void initState() {
    _labels = [];
    _calculateLabelsPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      // color: Colors.yellow,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 40,
            child: Container(
              height: 80,
              width: 160,
              // width: double.infinity,
              decoration: BoxDecoration(
                color: AppSettings.primaryColor.withOpacity(0.05),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(80),
                  topRight: Radius.circular(80),
                ),
              ),
              // child: Text("Hellow world"),
            ),
          ),
          Positioned(
            bottom: 45,
            child: Text(
              "${widget.gaugeValue.toInt()} %",
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                startAngle: 180,
                endAngle: 0,
                maximumLabels: 360,
                canScaleToFit: true,
                interval: 25,
                // onLabelCreated: _handleLabelCreated,
                // labelsPosition: ElementsPosition.inside,
                showTicks: true,
                showFirstLabel: true,
                showLastLabel: true,
                showLabels: true,
                radiusFactor: 1.1,
                axisLineStyle: const AxisLineStyle(
                  thickness: 30, // Adjust this value to increase the width
                ),
                pointers: <GaugePointer>[
                  MarkerPointer(
                    value: widget.gaugeValue,
                    color: Colors.black,
                    markerType: MarkerType.rectangle,
                    borderWidth: 30,
                    markerHeight: 5,
                    markerWidth: 45,
                  ),
                ],
                ranges: _buildRanges(),
                // annotations: _buildAnnotations(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _calculateLabelsPosition() {
    _labels.clear();
    // Length of each segment.
    double segmentLength = 320 / segmentsCount;
    double start = segmentLength / 2;
    for (int i = 0; i < segmentsCount; i++) {
      _labels.add(LabelDetails(start.toInt(), '£${i * 4} - £${(i + 1) * 4}'));
      start += segmentLength;
    }
  }

  void _handleLabelCreated(AxisLabelCreatedArgs args) {
    for (int i = 0; i < segmentsCount; i++) {
      LabelDetails details = _labels[i];
      if (details.labelPoint == int.parse(args.text)) {
        args.text = details.customizedLabel;
        return;
      }
    }

    args.text = '';
  }

  List<GaugeRange> _buildRanges() {
    List<GaugeRange> ranges = [
      GaugeRange(
        startValue: 0,
        endValue: 25,
        color: AppSettings.secondaryColor,
        label: "NDOGO",
        startWidth: 30,
        endWidth: 30,
        labelStyle: const GaugeTextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
      GaugeRange(
        startValue: 25.5,
        endValue: 50,
        color: AppSettings.primaryColor,
        label: "KAWAIDA",
        startWidth: 30,
        endWidth: 30,
        labelStyle: const GaugeTextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
      GaugeRange(
        startValue: 50.5,
        endValue: 75,
        color: Colors.orange,
        label: "KUBWA",
        startWidth: 30,
        endWidth: 30,
        labelStyle: const GaugeTextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
      GaugeRange(
        startValue: 75.5,
        endValue: 100,
        color: const Color.fromARGB(255, 241, 26, 11),
        label: "HATARI",
        startWidth: 30,
        endWidth: 30,
        labelStyle: const GaugeTextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    ];

    return ranges;
  }

  List<GaugeAnnotation> _buildAnnotations() {
    List<GaugeAnnotation> annotations = [
      const GaugeAnnotation(
        angle: 0,
        positionFactor: 1.01,
        widget: Text(
          '150',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      const GaugeAnnotation(
        angle: -36,
        positionFactor: 1.01,
        widget: Text(
          '125',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      const GaugeAnnotation(
        angle: -72,
        positionFactor: 1.01,
        widget: Text(
          '100',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      const GaugeAnnotation(
        angle: -108,
        positionFactor: 1.01,
        widget: Text(
          '75',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      const GaugeAnnotation(
        angle: -144,
        positionFactor: 1.01,
        widget: Text(
          '50',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      const GaugeAnnotation(
        angle: -180,
        positionFactor: 1.01,
        widget: Text(
          '25',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      // const GaugeAnnotation(
      //   angle: -180,
      //   positionFactor: 1.01,
      //   widget: Text(
      //     '0',
      //     style: TextStyle(
      //       fontSize: 14,
      //     ),
      //   ),
      // ),
    ];
    return annotations;
  }
}
