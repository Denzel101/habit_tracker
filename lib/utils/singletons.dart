import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:habit_tracker/utils/utils.dart';

class Singletons {
  static List<BlocProvider> registerCubits() => [
        BlocProvider<LoginUserCubit>(
          create: (context) => LoginUserCubit(
            authRepository: locator<AuthRepository>(),
            hiveService: locator<HiveService>(),
          ),
        ),
        BlocProvider<LogoutUserCubit>(
          create: (context) => LogoutUserCubit(
            authRepository: locator<AuthRepository>(),
          ),
        ),
        BlocProvider<RegisterUserCubit>(
          create: (context) => RegisterUserCubit(
            authRepository: locator<AuthRepository>(),
          ),
        ),
        BlocProvider<UpdateHabitDetailsCubit>(
          create: (context) => UpdateHabitDetailsCubit(
            hiveService: locator<HiveService>(),
          ),
        ),
        BlocProvider<CompleteHabitDetailsCubit>(
          create: (context) => CompleteHabitDetailsCubit(
            hiveService: locator<HiveService>(),
          ),
        ),
      ];
}
