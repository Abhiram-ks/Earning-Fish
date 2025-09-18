
import 'dart:ui';

import 'package:earningfish/core/constant/app_images.dart';
import 'package:earningfish/core/constant/constant.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Lottie.asset(
                  AppImages.animation,
                  width: screenWidth,
                  fit: BoxFit.cover,
                  repeat: true,
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(color: Colors.black.withValues(alpha: 0)),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstantWidgets.hight50(context),
                  Image.asset(
                    AppImages.appLogo,
                    width: 65,
                    height: 65,
                    fit: BoxFit.contain,
                  ),
                  ConstantWidgets.hight10(context),
                  Text(
                    'EARNING FISH',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                  Text(
                  "Save when you don't need it, and it'll be there for you when you do...",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize:12,
                      color: AppPalette.greyColor,
                    ),
                  ),
                  Spacer(),

                  Text.rich(
                    TextSpan(
                      text: "Data transmission is end-to-end encrypted.\n ",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      children: [
                        TextSpan(
                          text: "Terms and Conditions ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                        const TextSpan(text: "and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ConstantWidgets.hight10(context),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 13,
                        height: 13,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppPalette.hintColor,
                          ),
                          backgroundColor: AppPalette.blueColor,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                       Text("Loading...",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                 
                  ConstantWidgets.hight50(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
