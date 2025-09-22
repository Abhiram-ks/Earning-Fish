
import 'package:earningfish/core/constant/app_images.dart';
import 'package:earningfish/core/constant/constant.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginDetailsWidget extends StatelessWidget {
  final double screenWidth;

  const LoginDetailsWidget({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppImages.appLogo, width: screenWidth * 0.30),
         Text(
           'INS-PETRO',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppPalette.blackColor,
          ),
        ),
        Text(
           'POWERD BY',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: AppPalette.blueColor,
          ),
        ),
        Text(
           'GROWBLIC',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 14, color: AppPalette.greyColor),
        ),
        Text(
         "Save when you don't need it, an it'll be there for you when you do...",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 14, color: AppPalette.greyColor),
        ),
        ConstantWidgets.hight30(context),
         Text(
           "Welcome Back!",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        ConstantWidgets.hight10(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lock_clock_outlined,
              size: 18,
              color: AppPalette.blueColor,
            ),
            ConstantWidgets.width20(context),
            GestureDetector(
              onTap: () {},
              child:  Text(
               "Sign up with Google",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppPalette.blueColor,
                ),
              ),
            ),
          ],
        ),
        ConstantWidgets.hight20(context),
      ],
    );
  }
}
