import 'package:get_it/get_it.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/utils/utils.dart';

final GetIt locator = GetIt.instance;

void setUpLocator() {
  locator
    ..registerSingleton<AuthRepository>(
      AuthRepository(),
    )
    ..registerSingleton<HiveService>(
      HiveServiceImplementation(),
    );
}
