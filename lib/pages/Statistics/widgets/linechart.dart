import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Tems/config/data.dart';
import 'package:Tems/pages/Statistics/widgets/sampledata.dart';
import 'package:Tems/pages/Statistics/widgets/wid.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../model/chart_model.dart';

// class LineChartView extends StatelessWidget {

//   const LineChartView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const ChartF();
//   }
// }

class ChartF extends StatefulWidget {
  final bool isSelected;

  const ChartF({super.key, required this.isSelected});

  @override
  State<StatefulWidget> createState() => ChartFState();
}

class ChartFState extends State<ChartF> {
  final ChartWidget _widget = Get.put(ChartWidget());

  bool dataempty = false;
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior: _widget.zoom,
      primaryXAxis: DateTimeAxis(
        initialZoomFactor: 1,
        interval: 0.1,
        intervalType: widget.isSelected
            ? DateTimeIntervalType.days
            : DateTimeIntervalType.hours,
        isInversed: false,
        labelStyle: const TextStyle(fontSize: 10),
        dateFormat: DateFormat('yyyy-MM-dd HH:mm'),
        labelRotation: -80,
      ),
      primaryYAxis: _widget.y,
      title: _widget.title,
      series: <CartesianSeries>[
        ScatterSeries<ChartData, DateTime>(
          name: Data.stationNames.first,
          dataSource: chartDatafill.chartData,
          xValueMapper: (ChartData data, _) => data.x, // Cast to double
          yValueMapper: (ChartData data, _) => data.y,

          markerSettings: const MarkerSettings(
              shape: DataMarkerType.circle, height: 3, width: 3),
        ),
      ],
      tooltipBehavior: _widget.toolTip,
    );
  }
}

class ChartFm extends StatefulWidget {
  final bool isSelected;
  const ChartFm({super.key, required this.isSelected});

  @override
  State<StatefulWidget> createState() => ChartFmState();
}

class ChartFmState extends State<ChartFm> {
  final ChartWidget _widget = Get.put(ChartWidget());

  bool dataempty = false;
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior: _widget.zoom,
      primaryXAxis: DateTimeAxis(
        initialZoomFactor: 1,
        interval: 1,
        intervalType: widget.isSelected
            ? DateTimeIntervalType.days
            : DateTimeIntervalType.hours,
        isInversed: false,
        // isVisible: false,
        labelStyle: const TextStyle(fontSize: 8),
        dateFormat: DateFormat('MM-dd  HH:mm'),
        labelRotation: -80,
      ),
      primaryYAxis: _widget.y,
      title: _widget.title,
      series: <CartesianSeries>[
        ScatterSeries<ChartData, DateTime>(
          name: Data.stationNames.first,
          dataSource: chartDatafill.chartData,
          xValueMapper: (ChartData data, _) => data.x, // Cast to double
          yValueMapper: (ChartData data, _) => data.y,

          markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              height: 3,
              width: 3),
        ),
      ],
      tooltipBehavior: _widget.toolTip,
    );
  }
}
