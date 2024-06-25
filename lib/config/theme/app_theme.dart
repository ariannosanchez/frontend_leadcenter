import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const colorSeed = Color(0xff424CB8);
const scaffoldBackgroundColor = Color(0xFFF8F7F7);
const mainColor = Color(0xFF091257);
const secondColor = Color(0xFF0ECE20);

class AppTheme {

  ThemeData getTheme() => ThemeData(
    ///* General
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,

    ///* Texts
    textTheme: TextTheme(
      titleLarge: GoogleFonts.nunito()
        .copyWith( fontSize: 40, fontWeight: FontWeight.bold ),
      titleMedium: GoogleFonts.nunito()
        .copyWith( fontSize: 30, fontWeight: FontWeight.bold ),
      titleSmall: GoogleFonts.nunito()
        .copyWith( fontSize: 20 )
    ),

    ///* Scaffold Background Color
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    

    ///* Buttons
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          GoogleFonts.montserratAlternates()
            .copyWith(fontWeight: FontWeight.w700)
          )
      )
    ),

    ///* AppBar
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: scaffoldBackgroundColor,
      titleTextStyle: GoogleFonts.nunito()
        .copyWith( fontSize: 25, fontWeight: FontWeight.w400, color: Colors.black ),
    )
  );

}