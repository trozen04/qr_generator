import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AppColors.dart';

class CustomTextStyles {

  static TextStyle heading(BuildContext context) => GoogleFonts.outfit(
    fontSize: MediaQuery.of(context).size.width * 0.05, // 24px on 400px width
    fontWeight: FontWeight.w500,
    color: AppColors.brandNew,
  );

  static TextStyle subheading(BuildContext context) => GoogleFonts.outfit(
    fontSize: MediaQuery.of(context).size.width * 0.045, // 18px
    fontWeight: FontWeight.w500,
    color: AppColors.greyText,
  );


  static TextStyle title(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontFamily: 'Outfit',
      fontSize: width < 500 ? width * 0.06 : width * 0.05,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    );
  }

  // Subtitle style for the tagline
  static TextStyle subtitle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontFamily: 'Outfit',
      fontSize: width < 500 ? width * 0.04 : width * 0.03,
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w400,
    );
  }

  // Text field input style
  static TextStyle textFieldInput(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontFamily: 'Outfit',
      fontSize: width < 500 ? width * 0.04 : width * 0.03,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w500,
    );
  }

  // Text field hint style
  static TextStyle textFieldHint(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontFamily: 'Outfit',
      fontSize: width < 500 ? width * 0.04 : width * 0.03,
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w400,
    );
  }

  // Button text style
  static TextStyle button(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontFamily: 'Outfit',
      fontSize: width < 500 ? width * 0.04 : width * 0.03,
      fontWeight: FontWeight.w400,
      color: AppColors.textFieldFill,
    );
  }

  // Short URL text style
  static TextStyle shortUrl(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontFamily: 'Outfit',
      fontSize: width < 500 ? width * 0.035 : width * 0.025,
      color: AppColors.textFieldFill,
      fontWeight: FontWeight.w500,
    );
  }

  // Snackbar text style
  static TextStyle snackbar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontFamily: 'Outfit',
      fontSize: width * 0.035,
      color: AppColors.textPrimary,
    );
  }

  // Splash screen title style
  static TextStyle splashTitle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontFamily: 'Outfit',
      fontSize: width < 500 ? width * 0.07 : width * 0.06,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    );
  }

  // Splash screen subtitle style
  static TextStyle splashSubtitle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return TextStyle(
      fontFamily: 'Outfit',
      fontSize: width < 500 ? width * 0.04 : width * 0.03,
      color: AppColors.textSecondary,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle body(BuildContext context) => GoogleFonts.outfit(
    fontSize: MediaQuery.of(context).size.width * 0.035, // 14px
    fontWeight: FontWeight.normal,
    color: AppColors.mobilenumber,
  );
}