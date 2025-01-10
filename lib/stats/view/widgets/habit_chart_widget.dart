import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/home/home.dart';

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
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.004,
                  ),
                  BlocBuilder<CompleteHabitDetailsCubit,
                      CompleteHabitDetailsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: SizedBox.new,
                        loaded: (result) => Text(
                          '${result.completedHabits.length} Habits',
                          style: AppStyles.kTextLabelStyle3.copyWith(
                            color: AppColors.activeColor,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: analyticsBarChart(),
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
            color: context.isDarkMode ? Colors.black : Colors.white,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  Widget analyticsBarChart() {
    return BlocBuilder<CompleteHabitDetailsCubit, CompleteHabitDetailsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: SizedBox.new,
          loaded: (result) {
            final weekData = List.generate(7, (_) => 0);
            for (final habitDay in result.completedHabits) {
              final index = habitDay.day.weekday - 1;
              weekData[index] += habitDay.habits.length;
            }
            return BarChart(
              BarChartData(
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) =>
                        context.isDarkMode ? Colors.white : Colors.black,
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
                        AppStyles.kTextLabelStyle3.copyWith(
                          color:
                              context.isDarkMode ? Colors.black : Colors.white,
                        ),
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
                      touchedIndex =
                          barTouchResponse.spot!.touchedBarGroupIndex;
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
                barGroups: weekData
                    .asMap()
                    .entries
                    .map(
                      (entry) => makeGroupData(
                        entry.key,
                        entry.value.toDouble(),
                        isTouched: entry.key == touchedIndex,
                      ),
                    )
                    .toList(),
                gridData: const FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: 3,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
