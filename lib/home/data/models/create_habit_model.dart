import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_habit_model.freezed.dart';
part 'create_habit_model.g.dart';

@freezed
class CreatedHabitsModel with _$CreatedHabitsModel {
  factory CreatedHabitsModel({
    @Default([]) List<CreateHabitModel> result,
  }) = _CreatedHabitsModel;

  factory CreatedHabitsModel.fromJson(Map<String, dynamic> json) =>
      _$CreatedHabitsModelFromJson(json);
}

@freezed
class CreateHabitModel with _$CreateHabitModel {
  factory CreateHabitModel({
    required String habitName,
    required String habitLabel,
    required String habitIcon,
    required String description,
    required String frequency,
    required DateTime startDate,
    @Default(false) bool isSynced,
  }) = _CreateHabitModel;

  factory CreateHabitModel.fromJson(Map<String, dynamic> json) =>
      _$CreateHabitModelFromJson(json);
}
