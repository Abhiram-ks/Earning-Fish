import 'package:earningfish/core/constant/constant.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBarDashbord extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onNotificationTap;

  @override
  final Size preferredSize;

  const CustomAppBarDashbord({
    super.key,
    this.title = 'Dashboard',
    this.onBack,
    this.onNotificationTap,
  }) : preferredSize = const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFEAF4F4),
      elevation: 4,
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: AppPalette.blackColor,
        ),
      ),
      leading:
          onBack != null
              ? IconButton.filled(
                tooltip: 'Back',
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: const CircleBorder(),
                ),
              )
              : null,
      actions: [
        IconButton.filled(
          icon: const Icon(
            Icons.assignment_outlined,
            color: AppPalette.blackColor,
          ),
          onPressed: onNotificationTap,
          tooltip: 'Add user',
          style: IconButton.styleFrom(
            backgroundColor: AppPalette.whiteColor,
            disabledBackgroundColor: AppPalette.whiteColor,
            shadowColor: Colors.black26,
            shape: const CircleBorder(),
          ),
        ),
        ConstantWidgets.width20(context),

        ConstantWidgets.width40(context),
      ],
    );
  }
}
