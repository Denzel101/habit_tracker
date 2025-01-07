import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/utils/utils.dart';

class Singletons {
  static List<BlocProvider> registerCubits() => [
        BlocProvider<LoginUserCubit>(
          create: (context) => LoginUserCubit(
            authRepository: locator<AuthRepository>(),
          ),
        ),
      ];
}
