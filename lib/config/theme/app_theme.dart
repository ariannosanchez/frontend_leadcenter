import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const colorSeed = Color(0xff424CB8);
const scaffoldBackgroundColor = Color(0xFFF8F7F7);
const mainColor = Color(0xFF042449);
const secondColor = Color(0xFF0ECE20);

class AppTheme {

  ThemeData getTheme() => ThemeData(
    ///* General
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF2862F5),

    ///* Buttons
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(
          GoogleFonts.montserratAlternates()
            .copyWith(fontWeight: FontWeight.w700)
          )
      )
    ),

    // ///* AppBar
    // appBarTheme: AppBarTheme(
    //   centerTitle: true,
    //   titleTextStyle: GoogleFonts.nunito()
    //     .copyWith( fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black ),
    // )
  );

}