import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:habit_tracker/utils/utils.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveService extends Mock implements HiveService {}

class MockUser extends Mock implements User {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('CompleteHabitDetails Save Case', () {
    final mockHiveService = MockHiveService();

    final completedHabit = CompletedHabitModel(
      day: DateTime.now(),
      habits: [],
    );

    final completedHabits = [
      completedHabit,
      completedHabit,
      completedHabit,
    ];

    final testCompletedHabits = CompletedHabitsModel(
      completedHabits: completedHabits,
    );

    when(
      () => mockHiveService.persistCompletedHabits(
        completedHabit: completedHabit,
      ),
    ).thenAnswer((_) async {});

    when(mockHiveService.retrieveCompletedHabits)
        .thenReturn(testCompletedHabits);

    blocTest<CompleteHabitDetailsCubit, CompleteHabitDetailsState>(
      'emits [loading, loaded] when updating succeeds',
      build: () => CompleteHabitDetailsCubit(
        hiveService: mockHiveService,
      ),
      act: (cubit) => cubit.completeHabitDetails(
        completedHabit: completedHabit,
      ),
      expect: () => [
        const CompleteHabitDetailsState.loading(),
        CompleteHabitDetailsState.loaded(
          completedHabits: testCompletedHabits,
        ),
      ],
    );

    blocTest<CompleteHabitDetailsCubit, CompleteHabitDetailsState>(
      'emits [loaded] when retrieving succeeds',
      build: () => CompleteHabitDetailsCubit(
        hiveService: mockHiveService,
      ),
      act: (cubit) => cubit.retrieveHabitDetails(),
      expect: () => [
        CompleteHabitDetailsState.loaded(
          completedHabits: testCompletedHabits,
        ),
      ],
    );
  });
}
