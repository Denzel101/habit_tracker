import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/constants/extensions.dart';
import 'package:habit_tracker/utils/utils.dart';

part 'login_user_cubit.freezed.dart';
part 'login_user_state.dart';

class LoginUserCubit extends Cubit<LoginUserState> {
  LoginUserCubit({
    required AuthRepository authRepository,
    required HiveService hiveService,
  }) : super(const LoginUserState.initial()) {
    _authRepository = authRepository;
    _hiveService = hiveService;
  }

  late AuthRepository _authRepository;
  late HiveService _hiveService;

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      emit(const LoginUserState.loading());
      final user = await _authRepository.loginUser(
        email: email,
        password: password,
      );

      if (user != null) {
        _hiveService.persistUserInfo(
          loginDetails: LoginResponseDto(
            username: user.displayName!,
            email: user.email!,
            uid: user.uid,
          ),
        );
      }

      emit(LoginUserState.loaded(user: user));
    } on FirebaseAuthException catch (e) {
      emit(LoginUserState.error(error: e.toString().stripBrackets()));
    } catch (e) {
      emit(LoginUserState.error(error: e.toString()));
    }
  }
}
