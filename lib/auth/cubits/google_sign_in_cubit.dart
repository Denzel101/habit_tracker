import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/constants/extensions.dart';
import 'package:habit_tracker/utils/utils.dart';

part 'google_sign_in_cubit.freezed.dart';
part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit({
    required AuthRepository authRepository,
    required HiveService hiveService,
  }) : super(const GoogleSignInState.initial()) {
    _authRepository = authRepository;
    _hiveService = hiveService;
  }

  late AuthRepository _authRepository;
  late HiveService _hiveService;

  Future<void> signInWithGoogle() async {
    try {
      emit(const GoogleSignInState.loading());
      final user = await _authRepository.signInWithGoogle();

      if (user != null) {
        _hiveService.persistUserInfo(
          loginDetails: LoginResponseDto(
            username: user.displayName!,
            email: user.email!,
            uid: user.uid,
          ),
        );
      }

      emit(GoogleSignInState.loaded(user: user));
    } on FirebaseAuthException catch (e) {
      emit(GoogleSignInState.error(error: e.toString().stripBrackets()));
    } catch (e) {
      emit(GoogleSignInState.error(error: e.toString()));
    }
  }
}
