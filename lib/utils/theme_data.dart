import 'package:mashinki/exports.dart';

ThemeData themeData(BuildContext context) => ThemeData(
      textTheme: GoogleFonts.interTextTheme(
        Theme.of(context).textTheme,
      ),
    );
