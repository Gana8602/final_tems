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
    interval: 1,
  );
  final zoom = ZoomPanBehavior(
      enableMouseWheelZooming: true,
      enablePinching: true,
      enablePanning: true,
      enableDoubleTapZooming: true,
      enableSelectionZooming: true);
}
