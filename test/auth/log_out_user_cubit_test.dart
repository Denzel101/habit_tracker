import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUser extends Mock implements User {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('LogUserCubit Success Case', () {
    final mockAuthRepository = MockAuthRepository();

    when(
      mockAuthRepository.logoutUser,
    ).thenAnswer((_) async {});

    blocTest<LogoutUserCubit, LogoutUserState>(
      'emits [loading, loaded] when logoutUser succeeds',
      build: () => LogoutUserCubit(
        authRepository: mockAuthRepository,
      ),
      act: (cubit) => cubit.logoutUser(),
      expect: () => [
        const LogoutUserState.loading(),
        const LogoutUserState.loaded(),
      ],
    );
  });

  group(
    'LogoutUserCubit Firebase Error Case',
    () {
      final mockAuthRepository = MockAuthRepository();

      when(
        mockAuthRepository.logoutUser,
      ).thenThrow(
        FirebaseAuthException(
          message: 'Log out error',
          code: 'log-out-error',
        ),
      );

      blocTest<LogoutUserCubit, LogoutUserState>(
        'emits [loading, error] when logoutUser fails with'
        ' FirebaseAuthException',
        build: () => LogoutUserCubit(
          authRepository: mockAuthRepository,
        ),
        act: (cubit) => cubit.logoutUser(),
        expect: () => [
          const LogoutUserState.loading(),
          const LogoutUserState.error(
            error: '[firebase_auth/log-out-error] Log out error',
          ),
        ],
      );
    },
  );
}
