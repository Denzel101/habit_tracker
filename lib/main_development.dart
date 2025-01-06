import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/app/app.dart';
import 'package:habit_tracker/bootstrap.dart';

Future<void> main() async {
  await GoogleFonts.pendingFonts([
    GoogleFonts.poppins(),
  ]);
  await bootstrap(() => const App());
}
