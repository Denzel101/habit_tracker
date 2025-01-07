import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/app.dart';
import 'package:habit_tracker/bootstrap.dart';
import 'package:habit_tracker/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GoogleFonts.pendingFonts([
    GoogleFonts.poppins(),
  ]);
  await bootstrap(() => const App());
}
