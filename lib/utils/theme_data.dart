import 'package:autoverse/exports.dart';

ThemeData themeData(BuildContext context) => ThemeData(
      scaffoldBackgroundColor: whiteColor,
      bottomAppBarTheme: const BottomAppBarTheme(color: whiteColor),
      appBarTheme: const AppBarTheme(
          backgroundColor: whiteColor, surfaceTintColor: Colors.transparent),
      textTheme: GoogleFonts.interTextTheme(
        Theme.of(context).textTheme,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: primaryColor),
        prefixIconColor: primaryColor,
        iconColor: primaryColor,
        hintStyle: TextStyle(color: paleColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor,
          ),
        ),
      ),
    );
