import 'package:earningfish/core/constant/app_images.dart';
import 'package:earningfish/core/routes/app_routes.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class LogodetailsScreen extends StatelessWidget {
    final String vehicle;
  const LogodetailsScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        List<LogoImageEnum> images = LogoImageEnum.values;

        return Scaffold(
          appBar: AppBar(
            title:  Text(
              'Pick Your $vehicle Brand',
              style: TextStyle(color: AppPalette.blackColor),
            ),
            backgroundColor: const Color(0xFFEAF4F4),
            elevation: 2,
            centerTitle: true,
            automaticallyImplyLeading: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.03,
            ),
            child: GridView.builder(
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.pdiform);
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: AppPalette.blackColor.withValues(alpha: .7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          images[index].path,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}


enum LogoImageEnum {
  audi(AppImages.audi),
  benli(AppImages.benli),
  benz(AppImages.benz),
  bmw(AppImages.bmw),
  citroen(AppImages.citroen),
  nissan(AppImages.honda),
  hyundai(AppImages.hyundai),
  jaguar(AppImages.jaguar),
  kia(AppImages.kia),
  mahindra(AppImages.mahindra),
  marutiSuzuki(AppImages.marutiSuzuki),
  mg(AppImages.mg),
  mini(AppImages.mini),
  mitsubishi(AppImages.mitsubishi),
  renault(AppImages.renault),
  rollsroyce(AppImages.rollsroyce),
  skoda(AppImages.skoda),
  tata(AppImages.tata),
  toyota(AppImages.toyota),
  volkswagen(AppImages.volkswagen),
  volvo(AppImages.volvo);

  final String path;
  const LogoImageEnum(this.path);
}
