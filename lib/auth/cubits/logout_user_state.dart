part of 'logout_user_cubit.dart';

@freezed
class LogoutUserState with _$LogoutUserState {
  const factory LogoutUserState.initial() = _Initial;
  const factory LogoutUserState.loading() = _Loading;
  const factory LogoutUserState.loaded() = _Loaded;
  const factory LogoutUserState.error({required String error}) = _Error;
}
