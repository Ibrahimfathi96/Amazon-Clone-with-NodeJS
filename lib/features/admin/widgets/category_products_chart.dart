import 'package:amazon_clone/features/admin/model/sales.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> dataSource;
  const CategoryProductsChart({
    super.key,
    required this.dataSource,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <ColumnSeries<Sales, String>>[
        ColumnSeries<Sales, String>(
          dataSource: dataSource,
          xValueMapper: (Sales sales, _) => sales.label,
          yValueMapper: (Sales sales, _) => sales.earning,
        ),
      ],
    );
  }
}
