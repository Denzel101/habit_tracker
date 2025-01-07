import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_tracker/auth/auth.dart';

part 'logout_user_cubit.freezed.dart';
part 'logout_user_state.dart';

class LogoutUserCubit extends Cubit<LogoutUserState> {
  LogoutUserCubit({
    required AuthRepository authRepository,
  }) : super(const LogoutUserState.initial()) {
    _authRepository = authRepository;
  }

  late AuthRepository _authRepository;

  Future<void> logoutUser() async {
    try {
      emit(const LogoutUserState.loading());
      await _authRepository.logoutUser();
      emit(const LogoutUserState.loaded());
    } catch (e) {
      emit(LogoutUserState.error(error: e.toString()));
    }
  }
}
