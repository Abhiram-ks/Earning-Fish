import 'dart:ui';
import 'package:earningfish/core/constant/app_images.dart';
import 'package:earningfish/features/presentation/widgets/splash_widget/splash_center_widget.dart';
import 'package:flutter/material.dart';
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
          SplashCenterWidget(screenWidth: screenWidth),
        ],
      ),
    );
  }
}
