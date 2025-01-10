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
  group('LoginUserCubit Success Cubit', () {
    final mockAuthRepository = MockAuthRepository();
    final mockHiveService = MockHiveService();
    final mockUser = MockUser();

    const testEmail = 'test@example.com';
    const testPassword = 'password123';

    setUp(() {
      when(() => mockUser.uid).thenReturn('12345');
      when(() => mockUser.email).thenReturn(testEmail);
      when(() => mockUser.displayName).thenReturn('Test User');
    });

    when(
      () => mockAuthRepository.loginUser(
        email: testEmail,
        password: testPassword,
      ),
    ).thenAnswer((invocation) async => mockUser);

    blocTest<LoginUserCubit, LoginUserState>(
      'emits [loading, loaded] when loginUser succeeds',
      build: () => LoginUserCubit(
        authRepository: mockAuthRepository,
        hiveService: mockHiveService,
      ),
      act: (cubit) => cubit.loginUser(email: testEmail, password: testPassword),
      expect: () => [
        const LoginUserState.loading(),
        LoginUserState.loaded(user: mockUser),
      ],
    );
  });

  group(
    'LoginUserCubit Firebase Error Case',
    () {
      final mockAuthRepository = MockAuthRepository();
      final mockHiveService = MockHiveService();
      final mockUser = MockUser();

      const testEmail = 'test@example.com';
      const testPassword = 'password123';

      setUp(() {
        when(() => mockUser.uid).thenReturn('12345');
        when(() => mockUser.email).thenReturn(testEmail);
        when(() => mockUser.displayName).thenReturn('Test User');
      });

      when(
        () => mockAuthRepository.loginUser(
          email: testEmail,
          password: testPassword,
        ),
      ).thenThrow(
        FirebaseAuthException(
          message: 'User not found.',
          code: 'user-not-found',
        ),
      );

      blocTest<LoginUserCubit, LoginUserState>(
        'emits [loading, error] when loginUser fails with'
        ' FirebaseAuthException',
        build: () => LoginUserCubit(
          authRepository: mockAuthRepository,
          hiveService: mockHiveService,
        ),
        act: (cubit) => cubit.loginUser(
          email: testEmail,
          password: testPassword,
        ),
        expect: () => [
          const LoginUserState.loading(),
          const LoginUserState.error(
            error: 'User not found.',
          ),
        ],
      );
    },
  );
}
