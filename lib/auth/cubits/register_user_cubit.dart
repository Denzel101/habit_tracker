import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/constants/constants.dart';

part 'register_user_cubit.freezed.dart';
part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  RegisterUserCubit({
    required AuthRepository authRepository,
  }) : super(const RegisterUserState.initial()) {
    _authRepository = authRepository;
  }

  late AuthRepository _authRepository;

  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      emit(const RegisterUserState.loading());
      final user = await _authRepository.registerUser(
        username: username,
        email: email,
        password: password,
      );
      emit(RegisterUserState.loaded(user: user));
    } on FirebaseAuthException catch (e) {
      emit(RegisterUserState.error(error: e.toString().stripBrackets()));
    } catch (e) {
      emit(RegisterUserState.error(error: e.toString()));
    }
  }
}
