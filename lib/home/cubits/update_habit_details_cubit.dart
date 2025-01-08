import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:habit_tracker/utils/utils.dart';

part 'update_habit_details_cubit.freezed.dart';
part 'update_habit_details_state.dart';

class UpdateHabitDetailsCubit extends Cubit<UpdateHabitDetailsState> {
  UpdateHabitDetailsCubit({required HiveService hiveService})
      : super(const UpdateHabitDetailsState.initial()) {
    _hiveService = hiveService;
  }

  late HiveService _hiveService;

  void updateHabitDetails({required List<CreateHabitModel> createdHabits}) {
    emit(const UpdateHabitDetailsState.loading());
    _hiveService.persistCreatedHabits(createdHabits: createdHabits);
    final storedHabitDetails = _hiveService.retrieveCreatedHabits()!;
    emit(UpdateHabitDetailsState.loaded(createdHabits: storedHabitDetails));
  }

  void retrieveHabitDetails() {
    final storedHabitDetails = _hiveService.retrieveCreatedHabits()!;
    emit(UpdateHabitDetailsState.loaded(createdHabits: storedHabitDetails));
  }
}
