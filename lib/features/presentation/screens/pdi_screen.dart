
import 'package:earningfish/core/constant/app_images.dart';
import 'package:earningfish/core/constant/constant.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/presentation/bloc/brand_cubit/brand_cubit.dart';
import 'package:earningfish/features/presentation/screens/logodetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PdiScreen extends StatelessWidget {
  const PdiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        List<PdiImageEnum> images = PdiImageEnum.values;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Vehicle Inspection',
              style: TextStyle(color: AppPalette.blackColor),
              textAlign: TextAlign.start,
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
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                final selected = images[index];
                return GestureDetector(
                  onTap: () {
                      final cubit = context.read<BrandModelCubit>();
                      cubit.selectVehicle(selected.name.toUpperCase());
                      final brands = VehicleBrands.brandMap[selected] ?? [];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LogodetailsScreen(brands: brands,selectedVehicleType: selected,),
                        ),
                      );
                    
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: AppPalette.blackColor.withValues(alpha: .7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                selected.path,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          selected.name.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,      
                          overflow: TextOverflow.ellipsis
                        ),
                       ConstantWidgets.hight10(context)
                      ],
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

enum PdiImageEnum {
  cycle(AppImages.cycle),
  truck(AppImages.truck),
  scooter(AppImages.scooter),
  bus(AppImages.bus),
  car(AppImages.car),
  heavyVehicles(AppImages.jcb),
  bike(AppImages.bike);

  final String path;
  const PdiImageEnum(this.path);
}
