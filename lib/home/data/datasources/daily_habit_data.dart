import 'dart:ui';

import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/home/home.dart';

final _bicycle = DailyHabitModel(
  image: AssetPath.bicycleHabit,
  habit: 'Bicycle',
  goal: '07.00 for 10km',
  color: const Color(0xFFEAF5ED),
);

final _running = DailyHabitModel(
  image: AssetPath.runHabit,
  habit: 'Running',
  goal: '12.00 for 5km',
  color: const Color(0xFFFAEDE6),
);

final _workout = DailyHabitModel(
  image: AssetPath.workoutHabit,
  habit: 'Work Out',
  goal: '30.00 for 1200kcal',
  color: const Color(0xFFFAFAE5),
);

final _reading = DailyHabitModel(
  image: AssetPath.readingHabit,
  habit: 'Read Book',
  goal: '60.00 for 20pgs',
  color: const Color(0xFFF4EAF2),
);

final List<DailyHabitModel> dailyHabits = [
  _bicycle,
  _running,
  _workout,
  _reading,
];
