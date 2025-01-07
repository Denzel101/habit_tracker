part of 'register_user_cubit.dart';

@freezed
class RegisterUserState with _$RegisterUserState {
  const factory RegisterUserState.initial() = _Initial;
  const factory RegisterUserState.loading() = _Loading;
  const factory RegisterUserState.loaded({required User user}) = _Loaded;
  const factory RegisterUserState.error({required String error}) = _Error;
}
