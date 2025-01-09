import 'package:freezed_annotation/freezed_annotation.dart';

import 'create_habit_model.dart'; // Import the CreateHabitModel

part 'completed_habits_model.freezed.dart';
part 'completed_habits_model.g.dart';

@freezed
class CompletedHabitsModel with _$CompletedHabitsModel {
  factory CompletedHabitsModel({
    @Default([]) List<CompletedHabitModel> completedHabits,
  }) = _CompletedHabitsModel;

  factory CompletedHabitsModel.fromJson(Map<String, dynamic> json) =>
      _$CompletedHabitsModelFromJson(json);
}

@freezed
class CompletedHabitModel with _$CompletedHabitModel {
  factory CompletedHabitModel({
    required DateTime day,
    @Default([]) List<CreateHabitModel> habits,
  }) = _CompletedHabitModel;

  factory CompletedHabitModel.fromJson(Map<String, dynamic> json) =>
      _$CompletedHabitModelFromJson(json);
}
