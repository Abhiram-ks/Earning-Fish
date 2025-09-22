
import 'package:earningfish/core/constant/app_images.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/presentation/widgets/login_widget/login_subbody_widget.dart';
import 'package:earningfish/features/presentation/widgets/login_widget/login_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: LoginScreenBody(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ),
      );
  }
}
