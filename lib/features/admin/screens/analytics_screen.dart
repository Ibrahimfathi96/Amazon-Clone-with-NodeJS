import 'package:amazon_clone/common/widgets/custom_loader.dart';
import 'package:amazon_clone/features/admin/model/sales.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/admin/widgets/category_products_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices services = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  getEarnings() async {
    var earningData = await services.getEarnings(context: context);
    totalSales = earningData['totalEarning'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const CustomLoader()
        : Column(
            children: [
              Text(
                "\$$totalSales",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CategoryProductsChart(
                dataSource: earnings!,
              ),
            ],
          );
  }
}
