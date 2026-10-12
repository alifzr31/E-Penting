import 'package:e_penting/app/utils/consts/app_colors.dart';
import 'package:e_penting/app/utils/extensions/number_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ToddlerGenderGraph extends StatefulWidget {
  const new({
    required this.totalMale,
    required this.percentageMale,
    required this.totalFemale,
    required this.percentageFemale,
    super.key,
  });

  final int totalMale;
  final double percentageMale;
  final int totalFemale;
  final double percentageFemale;

  @override
  State<ToddlerGenderGraph> createState() => _ToddlerGenderGraphState();
}

class _ToddlerGenderGraphState extends State<ToddlerGenderGraph> {
  int _touchedIndex = -1;
  int _total = 0;

  void _calculateTotal() {
    final totalMale = widget.totalMale;
    final totalFemale = widget.totalFemale;

    setState(() {
      _total = totalMale + totalFemale;
    });
  }

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                'Balita',
                maxLines: 1,
                overflow: .ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: .w600),
              ),
              Text(
                'Terdata',
                maxLines: 1,
                overflow: .ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: .w600),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            alignment: .center,
            children: [
              PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          _touchedIndex = -1;
                          return;
                        }
                        _touchedIndex = pieTouchResponse
                            .touchedSection!
                            .touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 4,
                  sections: _total == 0
                      ? [
                          PieChartSectionData(
                            color: Colors.grey.shade300,
                            value: 1,
                            title: '',
                            radius: 14.0,
                          ),
                        ]
                      : [
                          PieChartSectionData(
                            color: AppColors.maleColor,
                            value: widget.totalMale.toDouble(),
                            title: '',
                            radius: _touchedIndex == 0 ? 20 : 16,
                          ),
                          PieChartSectionData(
                            color: AppColors.femaleColor,
                            value: widget.totalFemale.toDouble(),
                            title: '',
                            radius: _touchedIndex == 1 ? 20 : 16,
                          ),
                        ],
                ),
              ),
              Column(
                mainAxisAlignment: .center,
                mainAxisSize: .min,
                children: [
                  Text(
                    _total.thousandFormat(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: .w600,
                      color: Colors.black87,
                    ),
                  ),
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: .w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              _buildLegend(
                color: AppColors.maleColor,
                title: 'Laki-laki',
                percentage: widget.percentageMale,
                value: widget.totalMale,
                isTouched: _touchedIndex == 0,
              ),
              const SizedBox(height: 12),
              _buildLegend(
                color: AppColors.femaleColor,
                title: 'Perempuan',
                percentage: widget.percentageFemale,
                value: widget.totalFemale,
                isTouched: _touchedIndex == 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegend({
    required Color color,
    required String title,
    required double percentage,
    required int value,
    required bool isTouched,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: .end,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isTouched ? 12 : 10,
              height: isTouched ? 12 : 10,
              decoration: BoxDecoration(
                color: color,
                shape: .circle,
                boxShadow: isTouched
                    ? [
                        BoxShadow(
                          color: color.withValues(alpha: 0.5),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                title,
                textAlign: .right,
                maxLines: 1,
                overflow: .ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isTouched ? .w600 : .w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Align(
          alignment: .centerRight,
          child: Text(
            '$percentage%',
            textAlign: .right,
            maxLines: 1,
            overflow: .ellipsis,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isTouched ? .w600 : .w500,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
