import 'package:budy_buddy/data/transaction_model.dart';
import 'package:budy_buddy/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({
    Key? key,
    required this.inflowData,
    required this.outflowData,
  }) : super(key: key);

  final List<TransactionModel> inflowData;
  final List<TransactionModel> outflowData;

  int calculateTotalAmount(List<TransactionModel> data) {
    int total = 0;
    for (var transaction in data) {
      total += transaction.amount;
    }
    return total;
  }

  int categoryTypeToNumeric(String categoryType) {
    switch (categoryType) {
      case 'payments':
        return 1;
      case 'salary':
        return 2;
      case 'transportation':
        return 3;
      case 'food':
        return 4;
      case 'health':
        return 5;
      case 'gifts':
        return 6;
      case 'entertainment':
        return 7;
      case 'sport':
        return 8;
      default:
        return 1;
    }
  }

  List<PieChartSectionData> getChartData(List<TransactionModel> data) {
    List<PieChartSectionData> chartData = [];
    int totalAmount = calculateTotalAmount(data);

    // Define custom colors for each category
    final List<Color> categoryColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.amber,
      Colors.teal,
      Colors.pink,
    ];

    for (int i = 0; i < data.length; i++) {
      double amount = data[i].amount.toDouble();
      double percentage = amount / totalAmount;

      final int colorIndex = categoryTypeToNumeric(data[i].categoryType) - 1;
      final Color categoryColor = categoryColors[colorIndex];

      chartData.add(
        PieChartSectionData(
          title: data[i].categoryType,
          color: categoryColor,
          value: percentage,
          radius: 120,
        ),
      );
    }

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: defaultSpacing * 2,
            ),
            const Text(
              'Inflow Chart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              height: 400, // Increase the chart's height
              child: PieChart(
                PieChartData(
                  sections: getChartData(inflowData),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  centerSpaceRadius: 0,
                  sectionsSpace: 0,
                ),
              ),
            ),
            const SizedBox(
              height: defaultSpacing,
            ),
            const Text(
              'Outflow Chart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              height: 400, // Increase the chart's height
              child: PieChart(
                PieChartData(
                  sections: getChartData(outflowData),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  centerSpaceRadius: 0,
                  sectionsSpace: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
