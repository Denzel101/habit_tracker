import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/utils/utils.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockHiveService extends Mock implements HiveService {}

class MockUser extends Mock implements User {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RegisterUserCubit Success Cubit', () {
    final mockAuthRepository = MockAuthRepository();
    final mockUser = MockUser();

    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const username = 'John Doe';

    setUp(() {
      when(() => mockUser.uid).thenReturn('12345');
      when(() => mockUser.email).thenReturn(testEmail);
      when(() => mockUser.displayName).thenReturn('Test User');
    });

    when(
      () => mockAuthRepository.registerUser(
        email: testEmail,
        password: testPassword,
        username: username,
      ),
    ).thenAnswer((invocation) async => mockUser);

    blocTest<RegisterUserCubit, RegisterUserState>(
      'emits [loading, loaded] when registerUser succeeds',
      build: () => RegisterUserCubit(
        authRepository: mockAuthRepository,
      ),
      act: (cubit) => cubit.registerUser(
        email: testEmail,
        password: testPassword,
        username: username,
      ),
      expect: () => [
        const RegisterUserState.loading(),
        RegisterUserState.loaded(user: mockUser),
      ],
    );
  });

  group(
    'RegisterUserCubit Firebase Error Case',
    () {
      final mockAuthRepository = MockAuthRepository();
      final mockUser = MockUser();

      const testEmail = 'test@example.com';
      const testPassword = 'password123';
      const username = 'John Doe';

      setUp(() {
        when(() => mockUser.uid).thenReturn('12345');
        when(() => mockUser.email).thenReturn(testEmail);
        when(() => mockUser.displayName).thenReturn('Test User');
      });

      when(
        () => mockAuthRepository.registerUser(
          email: testEmail,
          password: testPassword,
          username: username,
        ),
      ).thenThrow(
        FirebaseAuthException(
          message: 'User not created.',
          code: 'user-not-created',
        ),
      );

      blocTest<RegisterUserCubit, RegisterUserState>(
        'emits [loading, error] when loginUser fails with'
        ' FirebaseAuthException',
        build: () => RegisterUserCubit(
          authRepository: mockAuthRepository,
        ),
        act: (cubit) => cubit.registerUser(
          email: testEmail,
          password: testPassword,
          username: username,
        ),
        expect: () => [
          const RegisterUserState.loading(),
          const RegisterUserState.error(
            error: 'User not created.',
          ),
        ],
      );
    },
  );
}
