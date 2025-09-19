
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
        Image.asset(AppImages.appLogo, width: 60,  height: 60,),
        Text(
           'EARNING FISH',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppPalette.blackColor,
          ),
        ),
        Text(
          "Save when you don't need it, and it'll be there for you when you do...",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontSize: 12, color: AppPalette.greyColor),
        ),
        ConstantWidgets.hight10(context),
         Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        ConstantWidgets.hight10(context),
      ],
    );
  }
}

