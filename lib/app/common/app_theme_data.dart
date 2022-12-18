import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'color_values.dart';

class AppThemeData {
  static ThemeData getTheme(BuildContext context) {
    const Color primaryColor = ColorValues.primaryBlue;
    final Map<int, Color> primaryColorMap = {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };
    final MaterialColor primaryMaterialColor =
    MaterialColor(primaryColor.value, primaryColorMap);

    return ThemeData(
        primaryColor: primaryColor,
        primarySwatch: primaryMaterialColor,
        canvasColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(size: 6.w),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            elevation: 0.0,
            minimumSize: const Size(double.infinity, 40.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textStyle: GoogleFonts.nunito(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(fontSize: 9.sp),
          unselectedLabelStyle: TextStyle(fontSize: 9.sp),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: ColorValues.navy),
          titleTextStyle: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 14.sp, color: ColorValues.navy),
          toolbarTextStyle: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 14.sp, color: ColorValues.navy),
        ),
        chipTheme: ChipThemeData(
          selectedColor: primaryColor,
          backgroundColor: Colors.grey[300],
          padding: const EdgeInsets.all(5.0),
          brightness: Brightness.light,
          disabledColor: Colors.grey[300],
          secondarySelectedColor: ColorValues.lightBlue,
          secondaryLabelStyle: GoogleFonts.nunito(
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
          labelStyle: GoogleFonts.nunito(
            color: primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        textTheme: GoogleFonts.nunitoTextTheme()
    );
  }
}
