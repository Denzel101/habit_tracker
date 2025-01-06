import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';

class HabitChartWidget extends StatefulWidget {
  const HabitChartWidget({super.key});

  @override
  State<StatefulWidget> createState() => HabitChartWidgetState();
}

class HabitChartWidgetState extends State<HabitChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: const EdgeInsets.all(AppStyles.kAppPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.greyColor,
        ),
      ),
      child: AspectRatio(
        aspectRatio: 0.9,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Analytics',
                    style: AppStyles.kTextLabelStyle3.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.004,
                  ),
                  Text(
                    '67 Habits',
                    style: AppStyles.kTextLabelStyle3.copyWith(
                      color: AppColors.activeColor,
                    ),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(
                        mainBarData(),
                        duration: const Duration(milliseconds: 250),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? AppColors.activeColor : AppColors.greyColor,
          width: width,
          borderSide: isTouched
              ? const BorderSide(color: AppColors.activeColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: Colors.white,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => Colors.black,
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Monday';
              case 1:
                weekDay = 'Tuesday';
              case 2:
                weekDay = 'Wednesday';
              case 3:
                weekDay = 'Thursday';
              case 4:
                weekDay = 'Friday';
              case 5:
                weekDay = 'Saturday';
              case 6:
                weekDay = 'Sunday';
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              AppStyles.kTextLabelStyle3,
              children: <TextSpan>[
                TextSpan(
                  text: '${rod.toY - 1} Habits',
                  style: AppStyles.kTextLabelStyle2.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: const FlTitlesData(
        rightTitles: AxisTitles(),
        topTitles: AxisTitles(),
        bottomTitles: AxisTitles(),
        leftTitles: AxisTitles(),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(
        drawVerticalLine: false,
        horizontalInterval: 3,
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
      case 1:
        text = const Text('T', style: style);
      case 2:
        text = const Text('W', style: style);
      case 3:
        text = const Text('T', style: style);
      case 4:
        text = const Text('F', style: style);
      case 5:
        text = const Text('S', style: style);
      case 6:
        text = const Text('S', style: style);
      default:
        text = const Text('', style: style);
    }
    return SideTitleWidget(
      meta: meta,
      space: 16,
      child: text,
    );
  }
}
