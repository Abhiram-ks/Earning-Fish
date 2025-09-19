import 'package:earningfish/core/constant/app_images.dart';
import 'package:earningfish/core/constant/constant.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final double screenWidth;
  final double screenHight;

  const AppDrawer({
    super.key,
    required this.screenWidth,
    required this.screenHight,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFEAF4F4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      clipBehavior: Clip.antiAlias,
      width: screenWidth * 0.7,
      child: SafeArea(
        child: Column(
          children: [
            ConstantWidgets.hight20(context),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Image.asset(
                  AppImages.appLogo,
                  height: screenHight * 0.06,
                  fit: BoxFit.contain,
                ),
              ),
            ),ConstantWidgets.hight20(context),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ExpansionTile(
                    leading: const Icon(Icons.receipt_long,color: AppPalette.blackColor,),
                    title: const Text('PDI History'),
                    childrenPadding: const EdgeInsets.only(left: 16, bottom: 8),
                    shape: const Border(),
                    collapsedShape: const Border(),
                    expandedAlignment: Alignment.centerLeft,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      horizontalTitleGap: 12,
                      minLeadingWidth: 20,
                      minTileHeight: 40,
                      minVerticalPadding: 0,
    
                        leading: const Icon(Icons.list_alt_rounded, color: Colors.black87),
                        title: const Text('All PDI'),
                        onTap: () {},
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      horizontalTitleGap: 12,
                      minLeadingWidth: 20,
                      minTileHeight: 40,
                      minVerticalPadding: 0,
                        leading: const Icon(
                          Icons.fact_check_rounded,
                        ),
                        title: const Text('Completed PDI'),
                        onTap: () {},
                      ),
                      ListTile(
                           contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      horizontalTitleGap: 12,
                      minLeadingWidth: 20,
                      minTileHeight: 40,
                      minVerticalPadding: 0,
                        leading: const Icon(
                          Icons.pending_actions,
                        ),
                        title: const Text('Pending PDI'),
                        onTap: () {},
                      ),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.assignment_outlined),
                    title: Text('Add PDI Entry'),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: Text('Logout', style: TextStyle(color: Colors.red)),
                    onTap: () {},
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Version 1.0.0",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
