
import 'package:earningfish/features/presentation/widgets/dashbord_widget/dashbord_custom_appbar.dart';
import 'package:earningfish/features/presentation/widgets/dashbord_widget/dashbord_custom_drawer.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final screenHight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;
          return Scaffold(
            drawer: AppDrawer(screenWidth: screenWidth, screenHight: screenHight),
            appBar: CustomAppBarDashbord(),
            body: Center(
              child: Text("Dashbord"),
              
            )
          );
        },
      );
  }
}

