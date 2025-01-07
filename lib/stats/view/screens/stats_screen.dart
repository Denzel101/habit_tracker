import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:habit_tracker/stats/stats.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppStyles.kAppPadding),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.07,
            ),
            const TopInfoWidget(
              title: 'Stats',
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            const HabitChartWidget(),
          ],
        ),
      ),
    );
  }
}
