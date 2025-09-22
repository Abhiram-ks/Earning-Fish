import 'package:earningfish/core/constant/app_images.dart';
import 'package:earningfish/core/routes/app_routes.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/presentation/bloc/brand_cubit/brand_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            title: Text(
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
                final brand = images[index];
                return GestureDetector(
                  onTap: () {
                    final cubit = context.read<BrandModelCubit>();
                    cubit.selectBrand(brand.name);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                BrandModelsScreen(selectedBrand: brand),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color(0xFFEAF4F4),
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
  nissan(AppImages.nissan),
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

class BrandModelsScreen extends StatelessWidget {
  final LogoImageEnum selectedBrand;
  const BrandModelsScreen({super.key, required this.selectedBrand});

  @override
  Widget build(BuildContext context) {
    final models = brandModels[selectedBrand] ?? ['No models'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF4F4),
        title: Text('${selectedBrand.name.toUpperCase()} Models'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: models.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 4),
            shadowColor: AppPalette.blackColor.withValues(alpha: 0.8),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                final String model = models[index];
                final cubit = context.read<BrandModelCubit>();
                cubit.selectModel(model);
                Navigator.pushNamed(context, AppRoutes.pdiform);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade50, const Color(0xFFEAF4F4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Icon(Icons.directions_car, color: Colors.blue.shade700),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        models[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppPalette.blueColor,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppPalette.blueColor,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

final Map<LogoImageEnum, List<String>> brandModels = {
  LogoImageEnum.mg: [
    'Windsor EV',
    'Windsor EV Pro',
    'Hector',
    'Hector Plus',
    'Astor',
    'ZS EV',
    'Gloster',
    'Comet EV',
    'M9 EV',
    'Cyberster',
    'Majestor',
    'Astor Facelift',
  ],
  LogoImageEnum.marutiSuzuki: [
    'Victoris',
    'Swift',
    'Brezza',
    'Fronx',
    'Baleno',
    'Dzire',
    'Grand Vitara',
    'XL6',
    'Invicto',
    'Jimny',
    'Ciaz',
    'Ertiga',
    'Wagon R',
    'Alto K10',
    'Eeco',
    'Celerio',
    'S-Presso',
    'Ignis',
  ],
  LogoImageEnum.citroen: [
    'C3',
    'eC3',
    'Basalt',
    'Aircross',
    'C5 Aircross',
    'C3x',
  ],
  LogoImageEnum.nissan: ['Magnite', 'X-Trail', 'Leaf', 'Juke', 'Sunny'],

  LogoImageEnum.hyundai: [
    'Creta',
    'Venue',
    'Exter',
    'Alcazar',
    'Tucson',
    'Verna',
    'Aura',
    'i20',
    'Grand i10 Nios',
    'Venue N Line',
    'i20 N Line',
    'Creta Electric',
    'Ioniq 5',
  ],
  LogoImageEnum.kia: [
    'Sonet',
    'Seltos',
    'Carens',
    'Syros',
    'Carnival',
    'EV9',
    'Carens Clavis',
    'Carens Clavis EV',
  ],
  LogoImageEnum.skoda: [
    'Kylaq',
    'Kushaq',
    'Slavia',
    'Kodiaq',
    'Octavia (Facelift)',
    'Superb (New)',
    'Enyaq',
    'Elroq',
  ],

  LogoImageEnum.bmw: [
    'X1',
    'X3',
    'X5',
    'X7',
    '2 Series Gran Coupe',
    'M5',
    'i7',
    'XM',
  ],

  LogoImageEnum.toyota: [
    'Glanza',
    'Urban Cruiser Taisor',
    'Rumion',
    'Urban Cruiser Hyryder',
    'Innova Crysta',
    'Innova Hycross',
    'Hilux',
    'Fortuner',
    'Legender',
    'Camry',
    'Vellfire',
    'Land Cruiser 300',
    'Urban Cruiser EV',
  ],

  LogoImageEnum.volkswagen: ['Virtus', 'Taigun', 'Golf GTI', 'Tiguan R-Line'],

  LogoImageEnum.renault: ['Virtus', 'Taigun', 'Golf GTI', 'Tiguan R-Line'],
  LogoImageEnum.jaguar: ['F-Pace', 'E-Pace'],
  LogoImageEnum.volvo: ['EX40', 'XC90', 'XC60', 'EX30', 'EC40'],
  LogoImageEnum.audi: [
    'A3',
    'A4',
    'A6',
    'A8',
    'Q3',
    'Q5',
    'Q7',
    'Q8',
    'e-tron',
    'RS3',
    'RS5',
    'RS7',
    'TT',
    'R8',
  ],
  LogoImageEnum.benli: [
    'TRK 502',
    'TRK 251',
    'Imperiale 400',
    'Leoncino 500',
    '302S',
    '502C',
  ],

  LogoImageEnum.benz: [
    'A-Class',
    'C-Class',
    'E-Class',
    'S-Class',
    'GLA',
    'GLC',
    'GLE',
    'GLS',
    'G-Class',
    'EQC',
    'EQB',
    'EQS',
    'AMG GT',
  ],
  LogoImageEnum.mahindra: [
    'Thar',
    'Scorpio',
    'XUV700',
    'XUV300',
    'Bolero',
    'Marazzo',
    'Alturas G4',
    'KUV100',
    'eKUV100',
    'XUV400',
  ],
  LogoImageEnum.mini: [
    'Cooper',
    'Cooper S',
    'Cooper SE',
    'Clubman',
    'Countryman',
    'John Cooper Works',
    'Paceman',
  ],
  LogoImageEnum.mitsubishi: [
    'Pajero Sport',
    'Eclipse Cross',
    'Outlander',
    'ASX',
    'Xpander',
    'Montero',
    'L200',
  ],
  LogoImageEnum.rollsroyce: [
    'Phantom',
    'Ghost',
    'Cullinan',
    'Wraith',
    'Dawn',
    'Spectre',
  ],
  LogoImageEnum.tata: [
    'Nexon',
    'Harrier',
    'Safari',
    'Punch',
    'Altroz',
    'Tiago',
    'Tigor',
    'H2X',
    'Hexa',
    'Bolt',
    'Indica',
    'Indigo',
  ],
};
