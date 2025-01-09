part of 'complete_habit_details_cubit.dart';

@freezed
class CompleteHabitDetailsState with _$CompleteHabitDetailsState {
  const factory CompleteHabitDetailsState.initial() = _Initial;
  const factory CompleteHabitDetailsState.loading() = _Loading;
  const factory CompleteHabitDetailsState.loaded({
    required CompletedHabitsModel completedHabits,
  }) = _Loaded;
}
