import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/app.dart';
import 'package:habit_tracker/bootstrap.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:habit_tracker/firebase_options.dart';
import 'package:habit_tracker/utils/utils.dart';
import 'package:habit_tracker/versioning/build_version.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HabitTrackerConfig(
    values: HabitTrackerValues(
      hiveBoxKey: 'ht_development_$packageVersion',
      hiveBoxEncryptionKey: 'JxjJXBiUe9JLNk8FIIT0qSO2WQhzlqxj',
      buildFlavour: BuildFlavour.development,
    ),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setUpLocator();

  await GoogleFonts.pendingFonts([
    GoogleFonts.poppins(),
  ]);

  await bootstrap(
    () => MultiBlocProvider(
      providers: Singletons.registerCubits(),
      child: const App(),
    ),
  );
}
