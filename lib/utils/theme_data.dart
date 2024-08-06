import 'package:autoverse/exports.dart';

ThemeData themeData(BuildContext context) => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, surfaceTintColor: Colors.transparent),
      textTheme: GoogleFonts.interTextTheme(
        Theme.of(context).textTheme,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Color(0xFF4038FF)),
        prefixIconColor: Color(0xFF4038FF),
        iconColor: Color(0xFF4038FF),
        hintStyle: TextStyle(color: Color(0xff7974FF)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF4038FF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF4038FF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF4038FF),
          ),
        ),
      ),
    );
