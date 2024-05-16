import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:route_between_two_points/pages/Statistics/widgets/sampledata.dart';
import 'package:route_between_two_points/pages/Statistics/widgets/wid.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../model/chart_model.dart';

class LineChartView extends StatelessWidget {
  const LineChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChartF();
  }
}

class ChartF extends StatefulWidget {
  const ChartF({super.key});

  @override
  State<StatefulWidget> createState() => ChartFState();
}

class ChartFState extends State<ChartF> {
  final ChartWidget _widget = Get.put(ChartWidget());
  // EmptyData _empty = Get.put(EmptyData());
  bool dataempty = false;
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      zoomPanBehavior: _widget.zoom,
      primaryXAxis: const DateTimeAxis(),
      primaryYAxis: _widget.y,
      title: _widget.title,
      series: <CartesianSeries>[
        ScatterSeries<ChartData, DateTime>(
          dataSource: chartDatafill.chartData,
          xValueMapper: (ChartData data, _) => data.x, // Cast to double
          yValueMapper: (ChartData data, _) => data.y,

          // data: (ChartData data, _) => data.size,
        ),
        // ScatterSeries<ChartData, int>(
        //   dataSource: _fill.chartData2,
        //   xValueMapper: (ChartData data, _) => data.x as int,
        //   yValueMapper: (ChartData data, _) => data.y,
        //   // sizeValueMapper: (ChartData data, _) => data.size,
        // ),
      ],
      tooltipBehavior: _widget.toolTip,
    );
  }
}
