part of 'login_user_cubit.dart';

@freezed
class LoginUserState with _$LoginUserState {
  const factory LoginUserState.initial() = _Initial;
  const factory LoginUserState.loading() = _Loading;
  const factory LoginUserState.loaded({User? user}) = _Loaded;
  const factory LoginUserState.error({required String error}) = _Error;
}
