import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/extensions/number_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MeasurementGraph extends StatelessWidget {
  const new({
    required this.intervalData,
    required this.unitData,
    required this.labels,
    required this.datas,
    super.key,
  });

  final double intervalData;
  final String unitData;
  final List<String> labels;
  final List<double> datas;

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> chartSpots = datas.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value);
    }).toList();

    final double maxTinggi = datas.isNotEmpty
        ? datas.reduce((curr, next) => curr > next ? curr : next)
        : 120.0;
    final double dinamisMaxY = ((maxTinggi / 10).ceil() * 10) + 20;

    final double chartWidth = chartSpots.isNotEmpty
        ? chartSpots.length * 60.0
        : 0.0;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: chartWidth,
        height: 300,
        child: Padding(
          padding: const .symmetric(horizontal: 16),
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                handleBuiltInTouches: true,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => AppColors.orangeColor,
                  tooltipBorderRadius: .circular(8),
                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                    return touchedSpots.map((spot) {
                      final int xIndex = spot.x.toInt();
                      final date = (xIndex >= 0 && xIndex < labels.length)
                          ? labels[xIndex]
                          : "";
                      return LineTooltipItem(
                        '${spot.y} $unitData\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: .w500,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    }).toList();
                  },
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: 30,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: Colors.black12,
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  );
                },
                getDrawingVerticalLine: (value) {
                  return const FlLine(
                    color: Colors.black12,
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    interval: intervalData,
                    reservedSize: 30,
                    showTitles: true,
                    maxIncluded: false,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().thousandFormat(),
                        textAlign: .left,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    interval: 1,
                    reservedSize: 40,
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value != value.roundToDouble()) {
                        return const SizedBox.shrink();
                      }

                      final int index = value.toInt();
                      if (index < 0 || index >= labels.length) {
                        return const SizedBox.shrink();
                      }

                      final String fullLabel = labels[index];
                      final List<String> parts = fullLabel.split(' ');
                      String displayText = fullLabel;

                      if (parts.length >= 2) {
                        final String month = parts[0];
                        final String year = parts[1];
                        final String shortMonth = month.length >= 3
                            ? month.substring(0, 3)
                            : month;
                        final String shortYear = year.length >= 4
                            ? year.substring(2)
                            : year;
                        displayText = "$shortMonth\n'$shortYear";
                      } else if (fullLabel.length >= 3) {
                        displayText = fullLabel.substring(0, 3);
                      }

                      return Text(
                        displayText,
                        textAlign: .center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              maxX: (chartSpots.length - 1).toDouble() + 0.2,
              minY: 0,
              maxY: dinamisMaxY,
              lineBarsData: [
                LineChartBarData(
                  spots: chartSpots,
                  isCurved: false,
                  color: AppColors.orangeColor,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 6,
                        color: AppColors.orangeColor,
                        strokeWidth: 2,
                        strokeColor: Colors.white,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.orangeColor.withValues(alpha: 0.4),
                        AppColors.orangeColor.withValues(alpha: 0.1),
                      ],
                      begin: .topCenter,
                      end: .bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
