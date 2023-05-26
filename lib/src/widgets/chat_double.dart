import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rateioapp/src/widgets/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ResultadoGrafico extends StatelessWidget {
  final List<double> resultados;

  const ResultadoGrafico({super.key, required this.resultados});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      title: ChartTitle(text: 'Grafico de Proporções'),
      legend: Legend(isVisible: true, toggleSeriesVisibility: false),
      tooltipBehavior: TooltipBehavior(enable: true),
      palette: Utils().coresPadrao,
      series: <ChartSeries<ChrtData, String>>[
        ColumnSeries<ChrtData, String>(
          dataSource: getData(),
          xValueMapper: (ChrtData sales, _) => sales.x,
          yValueMapper: (ChrtData sales, _) => sales.y,
          name: '',
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          width: .6,
        ),
      ],
    );
  }

  List<ChrtData> getData() {
    List<ChrtData> chartData = [];
    for (int i = 0; i < resultados.length; i++) {
      chartData.add(
        ChrtData(
          'Peso ${i + 1}',
          double.parse(NumberFormat("0.00").format(resultados[i])),
        ),
      );
    }
    return chartData;
  }
}

class ChrtData {
  ChrtData(this.x, this.y);

  final String x;
  final double y;
}
