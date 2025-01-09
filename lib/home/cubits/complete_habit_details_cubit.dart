import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:habit_tracker/utils/utils.dart';

part 'complete_habit_details_cubit.freezed.dart';
part 'complete_habit_details_state.dart';

class CompleteHabitDetailsCubit extends Cubit<CompleteHabitDetailsState> {
  CompleteHabitDetailsCubit({
    required HiveService hiveService,
  }) : super(const CompleteHabitDetailsState.initial()) {
    _hiveService = hiveService;
  }

  late HiveService _hiveService;

  void completeHabitDetails({required CompletedHabitModel completedHabit}) {
    emit(const CompleteHabitDetailsState.loading());
    _hiveService.persistCompletedHabits(completedHabit: completedHabit);
    final storedHabitDetails = _hiveService.retrieveCompletedHabits();
    emit(CompleteHabitDetailsState.loaded(completedHabits: storedHabitDetails));
  }

  void retrieveHabitDetails() {
    final storedHabitDetails = _hiveService.retrieveCompletedHabits();
    emit(
      CompleteHabitDetailsState.loaded(completedHabits: storedHabitDetails),
    );
  }
}
