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
    const habitLabel = 'Test';
    const habitIcon = 'path/path.png';
    const frequency = 'daily';
    final startDate = DateTime.now();

    final createdHabit = CreateHabitModel(
      habitLabel: habitLabel,
      habitIcon: habitIcon,
      frequency: frequency,
      description: habitLabel,
      habitName: habitLabel,
      startDate: startDate,
    );

    final createdHabits = [
      createdHabit,
      createdHabit,
      createdHabit,
    ];

    final testCreatedHabits = CreatedHabitsModel(
      result: createdHabits,
    );

    when(
      () => mockHiveService.persistCreatedHabit(
        createdHabit: createdHabit,
      ),
    ).thenAnswer((_) async {});

    when(mockHiveService.retrieveCreatedHabits).thenReturn(testCreatedHabits);

    blocTest<UpdateHabitDetailsCubit, UpdateHabitDetailsState>(
      'emits [loading, loaded] when updating succeeds',
      build: () => UpdateHabitDetailsCubit(
        hiveService: mockHiveService,
      ),
      act: (cubit) => cubit.updateHabitDetails(
        createdHabit: createdHabit,
      ),
      expect: () => [
        const UpdateHabitDetailsState.loading(),
        UpdateHabitDetailsState.loaded(
          createdHabits: testCreatedHabits,
        ),
      ],
    );

    blocTest<UpdateHabitDetailsCubit, UpdateHabitDetailsState>(
      'emits [loaded] when retrieving succeeds',
      build: () => UpdateHabitDetailsCubit(
        hiveService: mockHiveService,
      ),
      act: (cubit) => cubit.retrieveHabitDetails(),
      expect: () => [
        UpdateHabitDetailsState.loaded(
          createdHabits: testCreatedHabits,
        ),
      ],
    );
  });
}
