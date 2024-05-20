import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends GetxController {
  final toolTip =
      TooltipBehavior(enable: true, activationMode: ActivationMode.singleTap);
  final title = const ChartTitle(text: 'water Level');
  final x = const NumericAxis(
    interval: 1,
    labelRotation: -47,
    enableAutoIntervalOnZooming: true,
  );
  final y = const NumericAxis(
    title: AxisTitle(
      text: 'm',
      alignment: ChartAlignment.center, // Align the title to the far end
      textStyle: TextStyle(
        fontSize: 12, // Adjust the font size as needed
      ),
    ),
    isVisible: true,
    interval: 0.5,
    majorGridLines: MajorGridLines(width: 0),
    minorGridLines: MinorGridLines(width: 0),
  );
  final zoom = ZoomPanBehavior(
      enableMouseWheelZooming: false,
      enablePinching: true,
      enablePanning: true,
      enableDoubleTapZooming: true,
      enableSelectionZooming: false);
}
