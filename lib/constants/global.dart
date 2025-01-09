import 'package:habit_tracker/constants/constants.dart';

class HabitTrackerValues {
  HabitTrackerValues({
    required this.hiveBoxKey,
    required this.hiveBoxEncryptionKey,
    required this.buildFlavour,
  });

  final String hiveBoxKey;
  final String hiveBoxEncryptionKey;
  final BuildFlavour buildFlavour;
}

class HabitTrackerConfig {
  factory HabitTrackerConfig({required HabitTrackerValues values}) {
    return _instance ??= HabitTrackerConfig._internal(values);
  }

  HabitTrackerConfig._internal(this.values);

  final HabitTrackerValues values;
  static HabitTrackerConfig? _instance;

  static HabitTrackerConfig? get instance => _instance;
}
