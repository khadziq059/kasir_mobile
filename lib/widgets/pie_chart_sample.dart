import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kasir_controller.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  final KasirController kasirController = Get.put(KasirController());
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final salesData = kasirController.getSalesByProduct();
      final totalSales = salesData.values.fold(0.0, (sum, value) => sum + value);

      return AspectRatio(
        aspectRatio: 1.3,
        child: Column(
          children: <Widget>[
            Expanded(
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(salesData, totalSales),
                ),
              ),
            ),
            Column(
              children: salesData.keys.map((productName) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Indicator(
                    color: getColorForProduct(productName),
                    text: productName,
                    isSquare: true,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }

  List<PieChartSectionData> showingSections(
      Map<String, double> salesData, double totalSales) {
    int index = 0;
    return salesData.entries.map((entry) {
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;

      final section = PieChartSectionData(
        color: getColorForProduct(entry.key),
        value: entry.value,
        title: '${((entry.value / totalSales) * 100).toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

      index++;
      return section;
    }).toList();
  }

  Color getColorForProduct(String productName) {
    // Assign colors based on product name
    final colors = [
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.green,
      Colors.orange,
      Colors.red,
    ];
    return colors[productName.hashCode % colors.length];
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;

  const Indicator({
    required this.color,
    required this.text,
    this.isSquare = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
