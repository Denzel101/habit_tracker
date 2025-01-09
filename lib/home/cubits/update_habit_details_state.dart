part of 'update_habit_details_cubit.dart';

@freezed
class UpdateHabitDetailsState with _$UpdateHabitDetailsState {
  const factory UpdateHabitDetailsState.initial() = _Initial;
  const factory UpdateHabitDetailsState.loading() = _Loading;
  const factory UpdateHabitDetailsState.loaded({
    required CreatedHabitsModel createdHabits,
  }) = _Loaded;
}
