import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/l10n/l10n.dart';
import 'package:habit_tracker/router/router.dart';
import 'package:habit_tracker/theme/theme.dart';
import 'package:habit_tracker/utils/utils.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: ValueListenableBuilder(
        valueListenable: Hive.box<dynamic>(
          HabitTrackerConfig.instance!.values.hiveBoxKey,
        ).listenable(),
        builder: (context, _, __) {
          final isDarkMode = locator<HiveService>().retrieveDarkMode();
          return MaterialApp(
            theme:
                isDarkMode ?? false ? AppTheme.darkTheme : AppTheme.lightTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute:
                isLoggedIn ? AppRouter.landingRoute : AppRouter.loginRoute,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
