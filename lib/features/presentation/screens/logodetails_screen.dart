import 'package:earningfish/core/constant/app_images.dart';
import 'package:earningfish/core/constant/constant.dart';
import 'package:earningfish/core/routes/app_routes.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/presentation/bloc/brand_cubit/brand_cubit.dart';
import 'package:earningfish/features/presentation/screens/pdi_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogodetailsScreen extends StatelessWidget {
  final List<LogoImageEnum> brands;
  final PdiImageEnum selectedVehicleType;

  const LogodetailsScreen({
    super.key,
    required this.brands,
    required this.selectedVehicleType,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Select Manufacturer',
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
            child:
                brands.isEmpty
                    ? Center(
                      child: Text(
                        "No vehicles available",
                        style: TextStyle(
                          color: AppPalette.redColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    : GridView.builder(
                      itemCount: brands.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: 1.2,
                          ),
                      itemBuilder: (context, index) {
                        final brand = brands[index];
                        return GestureDetector(
                          onTap: () {
                            context.read<BrandModelCubit>().selectBrand(
                              brand.name,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => BrandModelsScreen(
                                      selectedBrand: brand,
                                      selectedVehicleType: selectedVehicleType,
                                    ),
                              ),
                            );
                          },
                          child: Card(
                            color: const Color(0xFFEAF4F4),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: AppPalette.blackColor.withValues(
                              alpha: .7,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        brand.path,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  brand.name.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                ConstantWidgets.hight10(context),
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

class VehicleBrands {
  static final Map<PdiImageEnum, List<LogoImageEnum>> brandMap = {
    PdiImageEnum.car: [
      LogoImageEnum.audi,
      LogoImageEnum.benz,
      LogoImageEnum.bmw,
      LogoImageEnum.honda,
      LogoImageEnum.hyundai,
      LogoImageEnum.jaguar,
      LogoImageEnum.kia,
      LogoImageEnum.ktm,
      LogoImageEnum.mahindra,
      LogoImageEnum.marutiSuzuki,
      LogoImageEnum.mg,
      LogoImageEnum.mini,
      LogoImageEnum.mitsubishi,
      LogoImageEnum.nissan,
      LogoImageEnum.renault,
      LogoImageEnum.skoda,
      LogoImageEnum.tata,
      LogoImageEnum.toyota,
      LogoImageEnum.volkswagen,
      LogoImageEnum.volvo,
    ],

    PdiImageEnum.scooter: [
      LogoImageEnum.benli,
      LogoImageEnum.honda,
      LogoImageEnum.hyundai,
      LogoImageEnum.ktm,
      LogoImageEnum.marutiSuzuki,
      LogoImageEnum.mg,
      LogoImageEnum.ola,
      LogoImageEnum.okinawa,
      LogoImageEnum.tvs,
      LogoImageEnum.yamaha,
    ],

    PdiImageEnum.bus: [
      LogoImageEnum.ashokLeyland,
      LogoImageEnum.force,
      LogoImageEnum.skoda,
      LogoImageEnum.tata,
      LogoImageEnum.volvo,
    ],
    PdiImageEnum.truck: [
      LogoImageEnum.ashokLeyland,
      LogoImageEnum.force,
      LogoImageEnum.isuzu,
      LogoImageEnum.mg,
      LogoImageEnum.renault,
      LogoImageEnum.tata,
      LogoImageEnum.volvo,
    ],

    PdiImageEnum.bike: [
      LogoImageEnum.bajaj,
      LogoImageEnum.bmw,
      LogoImageEnum.bugatti,
      LogoImageEnum.harlydeveson,
      LogoImageEnum.hero,
      LogoImageEnum.honda,
      LogoImageEnum.java,
      LogoImageEnum.ktm,
      LogoImageEnum.mini,
      LogoImageEnum.mitsubishi,
      LogoImageEnum.renault,
      LogoImageEnum.royalEnfield,
      LogoImageEnum.yamaha,
    ],

    PdiImageEnum.cycle: [
      LogoImageEnum.altas,
      LogoImageEnum.avon,
      LogoImageEnum.hero,
    ],
    PdiImageEnum.heavyVehicles: [
      LogoImageEnum.ashokLeyland,
      LogoImageEnum.bugatti,
      LogoImageEnum.force,
      LogoImageEnum.jaguar,
      LogoImageEnum.renault,
      LogoImageEnum.tata,
      LogoImageEnum.volvo,
    ],
  };
}

enum LogoImageEnum {
  ashokLeyland(AppImages.ashokleyland),
  audi(AppImages.audi),
  bajaj(AppImages.bajaj),
  benli(AppImages.benli),
  benz(AppImages.benz),
  bmw(AppImages.bmw),
  bugatti(AppImages.bugatti),
  citroen(AppImages.citroen),
  force(AppImages.force),
  hero(AppImages.hero),
  hyundai(AppImages.hyundai),
  isuzu(AppImages.isuzu),
  jaguar(AppImages.jaguar),
  kia(AppImages.kia),
  mahindra(AppImages.mahindra),
  marutiSuzuki(AppImages.marutiSuzuki),
  mg(AppImages.mg),
  mini(AppImages.mini),
  mitsubishi(AppImages.mitsubishi),
  nissan(AppImages.nissan),
  okinawa(AppImages.okinawa),
  ola(AppImages.ola),
  renault(AppImages.renault),
  rollsRoyce(AppImages.rollsroyce),
  skoda(AppImages.skoda),
  tata(AppImages.tata),
  toyota(AppImages.toyota),
  tvs(AppImages.tvs),
  volkswagen(AppImages.volkswagen),
  volvo(AppImages.volvo),
  royalEnfield(AppImages.royalenfield),
  altas(AppImages.atlas),
  avon(AppImages.avon),
  harlydeveson(AppImages.harlydeveson),
  honda(AppImages.honda),
  java(AppImages.java),
  ktm(AppImages.ktm),
  yamaha(AppImages.yamaha);

  final String path;
  const LogoImageEnum(this.path);
}

class BrandModelsScreen extends StatelessWidget {
  final PdiImageEnum selectedVehicleType;
  final LogoImageEnum selectedBrand;

  const BrandModelsScreen({
    super.key,
    required this.selectedVehicleType,
    required this.selectedBrand,
  });

  @override
  Widget build(BuildContext context) {
    final Map<PdiImageEnum, IconData> vehicleIcons = {
      PdiImageEnum.car: Icons.directions_car,
      PdiImageEnum.bike: Icons.motorcycle,
      PdiImageEnum.bus: Icons.directions_bus,
      PdiImageEnum.truck: Icons.local_shipping,
      PdiImageEnum.scooter: Icons.electric_scooter,
      PdiImageEnum.cycle: Icons.pedal_bike,
      PdiImageEnum.heavyVehicles: Icons.agriculture,
    };

    IconData selectedIcon =
        vehicleIcons[selectedVehicleType] ?? Icons.directions_car;
    final models =
        vehicleBrandModels[selectedVehicleType]?[selectedBrand] ??
        ['No models'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF4F4),
        elevation: 3,
        centerTitle: true,
        title: Text(
          '${selectedBrand.name.toUpperCase()} Models',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppPalette.blackColor,
          ),
        ),
      ),
      body:
          models.isEmpty
              ? const Center(
                child: Text(
                  "No models available",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: models.length,
                itemBuilder: (context, index) {
                  final model = models[index];

                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 400 + (index * 100)),
                    tween: Tween(begin: 0, end: 1),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, (1 - value) * 20),
                          child: child,
                        ),
                      );
                    },
                    child: Card(
                      elevation: 6,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadowColor: Colors.blue.shade100,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          final cubit = context.read<BrandModelCubit>();
                          cubit.selectModel(model);
                          Navigator.pushNamed(context, AppRoutes.pdiform);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade50,
                                Colors.blue.shade100.withValues(alpha: .4),
                                const Color(0xFFEAF4F4),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue.shade600.withValues(
                                    alpha: .1,
                                  ),
                                ),
                                child: Icon(
                                  selectedIcon,
                                  size: 28,
                                  color: Colors.blue.shade600,
                                ),
                              ),
                              ConstantWidgets.width20(context),
                              Expanded(
                                child: Text(
                                  model,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: AppPalette.blueColor,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                                color: AppPalette.blueColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}

final Map<PdiImageEnum, Map<LogoImageEnum, List<String>>> vehicleBrandModels = {
  PdiImageEnum.car: {
    LogoImageEnum.nissan: [
      'Magnite',
      'X-Trail',
      'Juke',
      'Sunny',
      'GT-R',
      'Ariya',
      'Leaf',
      'Kicks',
      'Versa',
      'Sentra',
      'Altima',
      'Murano',
      'Armada',
    ],
    LogoImageEnum.mg: [
      'Windsor EV',
      'Windsor EV Pro',
      'Hector',
      'Hector Plus',
      'Astor',
      'Astor Facelift',
      'ZS EV',
      'Gloster',
      'Comet EV',
      'M9 EV',
      'Cyberster',
      'Majestor',
      'MG 4 EV',
      'IM5',
      'IM6',
    ],
    LogoImageEnum.skoda: [
      'Kylaq',
      'Kushaq',
      'Slavia',
      'Kodiaq',
      'Octavia Facelift',
    ],
    LogoImageEnum.ktm: [
      'X-Bow',
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
      'Syros',
      'Carens',
      'Carens Clavis',
      'Carens Clavis EV',
      'Carnival',
      'EV9',
      'EV6',
    ],
    LogoImageEnum.honda: [
      'Amaze',
      'Amaze 2nd Gen',
      'Elevate',
      'City',
      'City e:HEV',
      'City Hybrid',
      'City Sports',
      'HR-V',
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
    LogoImageEnum.volkswagen: [
      'Virtus',
      'Virtus Sport',
      'Virtus Chrome',
      'Taigun',
      'Taigun Sport',
      'Taigun Chrome',
      'Golf GTI',
      'Tiguan R-Line',
      'ID.4',
    ],

    LogoImageEnum.renault: ['Kwid', 'Triber', 'Kiger', 'Duster', 'Kardian'],

    LogoImageEnum.jaguar: ['F-Pace', 'E-Pace', 'XE', 'XF', 'I-Pace', 'F-Type'],
    LogoImageEnum.volvo: [
      'EX40',
      'XC40',
      'EC40',
      'EX30',
      'XC60',
      'XC90',
      'S60',
      'S90',
      'V90 Cross Country',
      'C40 Recharge',
    ],
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
  },

  PdiImageEnum.truck: {
    LogoImageEnum.tata: [
      'Ace',
      'Yodha',
      'Intra',
      'Tata 407/709/1109',
      'LPT',
      'Ultra',
      'Signa',
      'Prima',
      'Other Tata models',
    ],
    LogoImageEnum.renault: [
      'Renault Trucks T',
      'Renault Trucks T High',
      'Renault Trucks C'
      'Renault Trucks K',
      'Renault Trucks D',
    ],
    LogoImageEnum.isuzu: [
      'N-Seriess',
      'F-Series - FTR',
      'F-Series - FVR',
    ],
    LogoImageEnum.volvo: [
      'Volvo FH',
      'Volvo FH16',
      'Volvo FH Aero',
      'Volvo FM',
      'Volvo FMX',
      'Volvo FE',
      'Volvo FL',
      'Volvo FM Electric',
      'Volvo FH Electric',
      'Volvo FMX Electric'
      'Volvo VNL/VNR',
      'Volvo VM',
    ],
    LogoImageEnum.ashokLeyland: [
      'Boss',
      'Ecomet',
      'Partner',
      'Dost',
      'Saathi',
      'AVTR',
      'Comet',
      'Titan',
    ],
    LogoImageEnum.force: [
      'Traveller ',
      'Trax Cruiser',
      'Urbania',
      'Monobus',
      'Delivery Vans',
      'Gurkha',
    ],
    LogoImageEnum.mg: [
      "MG M9 EV (electric MPV)",
      'MG Comet EV',
      'MG Windsor EV'
      'ZS EV',
      'Hector',
      'MG Commercial Model X',
      'B7R',
    ],
  },

  PdiImageEnum.bike: {
    LogoImageEnum.bajaj: [
      'Pulsar',
      'Dominar',
      'Avenger Street',
      'Avenger Cruise',
      'CT',
      'Platina',
      'Chetak EV',
    ],
    LogoImageEnum.hero: [
      'Splendor',
      'HF Deluxe',
      'Passion',
      'Glamour',
      'Xtreme',
      'Maestro Edge',
      'Pleasure',
      'Destini',
      'Xoom',
      'Vida V1',
    ],
    LogoImageEnum.royalEnfield: [
      'Bullet',
      'Classic',
      'Hunter',
      'Meteor',
      'Scram',
      'Himalayan',
      'Continental GT',
      'Interceptor',
      'Shotgun',
      'Super Meteor',
    ],
    LogoImageEnum.honda: [
      'Activa',
      'Dio',
      'Unicorn',
      'SP',
      'Shine',
      'Hornet',
      'H’ness',
      'CBR',
    ],
    LogoImageEnum.harlydeveson: [
      'X440',
      'Nightster',
      'Sportster S',
      'Fat Boy 114',
      'Heritage Classic',
      'Road Glide Special',
      'Street Glide Special',
      'Pan America 1250',
      'Pan America 1250 Special',
    ],
    LogoImageEnum.bugatti: ['PG'],
    LogoImageEnum.yamaha: ['R15', 'MT', 'FZ', 'Aerox', 'RayZR', 'Fascino '],
    LogoImageEnum.java: [
      'Jawa 42',
      'Jawa 42 Bobber',
      'Jawa Classic',
      'Jawa Perak',
      'Jawa 350',
    ],
    LogoImageEnum.ktm: ['Duke', 'RC', 'Adventure'],
    LogoImageEnum.bmw: [
      'G310R',
      'G310GS',
      'G310RR',
      'R1250GS',
      'S1000RR',
      'S1000XR',
      'M1000RR',
    ],
    LogoImageEnum.mitsubishi: ['Bike Model X'],
    LogoImageEnum.renault: ['Bike Model Y'],
    LogoImageEnum.mini: ['Mini Bike X'],
  },

  PdiImageEnum.scooter: {
    LogoImageEnum.tvs: [
      'Jupiter',
      'NTORQ',
      'Scooty'
       'iQube Electric',
      'Raider',
      'Apache RTR 160',
      'Apache RTR 160 4V',
      'Apache RTR 180',
      'Apache RTR 200 4V',
      'Apache RR 310',
      'Star City+',
      'Sport',
    ],
    LogoImageEnum.mg: ['ePluto 7G', 'ETrance Neo'],
    LogoImageEnum.ola: ['S1', 'S1 Pro', 'S1 Air', 'S1 X'],
    LogoImageEnum.okinawa: [
      'Praise',
      'PraisePro',
      'iPraise+',
      'Ridge',
      'R30',
      'Dual 100',
      'Lite',
      'Okhi-90',
    ],
    LogoImageEnum.hyundai: ['Eon Scooter'],
    LogoImageEnum.marutiSuzuki: [
      'e-Scooter Model X',
      'Access 125',
      'Burgman Street 125',
      'Avenis 125',
    ],
    LogoImageEnum.ktm: ['Scooter KTM X'],
    LogoImageEnum.yamaha: ['Fascino 125 Fi Hybrid', 'RayZR 125 Fi Hybrid'],
    LogoImageEnum.benli: [
      'TRK 502',
      '502 C',
      'Leoncino 500',
      'Imperiale 400',
      'TNT 300',
      '302R',
      'Leoncino 800',
      '752S',
      'Tornado 402R',
      '320 S',
      '600 RR',
      'TRK 702',
    ],
    LogoImageEnum.honda: ['Activa 6G', 'Activa 125', 'Dio', 'Grazia'],
  },

  PdiImageEnum.bus: {
    LogoImageEnum.volvo:
     ['B7R', 'B9R', 'Volvo 9400', 'Volvo 9600', 'Volvo 9700'],
    LogoImageEnum.tata: [
      'Starbus',       
      'Ultra / Ultra Prime',
      'Cityride',
      'Magic Express',
      'Magic Mantra',
    ],
    LogoImageEnum.skoda: [
      'E’CITY',
      'H’CITY',
      '30Tr SOR',
      '32Tr SOR',
      '706 RTO',
      '706 RTO-K',
    ],
    LogoImageEnum.ashokLeyland: [
      'Viking',
      'Cheetah',
      'Sunshine School',
      '12m FE Intercity',
      'Mitr',
      'Viking Stage Carrier',
    ],
    LogoImageEnum.force: [
      'Traveller',
      'Traveller School Bus',
      'Traveller Ambulance',
      'Traveller Delivery Van',
      'Monobus',
      'Trax Cruiser',
      'Trax Toofan',
      'Citiline',
      'Trax Ambulance',
      'Trax Crew Van',
      'e-Traveller Smart Citibus',
    ],
  },

  PdiImageEnum.cycle: {
    LogoImageEnum.altas: [
      'Altas Speedster',
      'Altas Ranger',
      'Atlas Ultimate City',
      'Atlas Smash',
      'Atlas Snippy',
    ],
    LogoImageEnum.avon: [
      'Avon Rider',
      'Avon Comet',
      'Avon Cycles Sherry',
      'Avon E-Bike',
    ],
    LogoImageEnum.hero: [
      'Hero Sprint',
      'Hero Racer',
      'Hero Miss India',
      'Hero Lectro (E-Cycle)',
    ],
  },

  PdiImageEnum.heavyVehicles: {
    LogoImageEnum.ashokLeyland: [
      'AVTR 2820',
      'AVTR 3520',
      'AVTR 2825',
      'AVTR 4220',
      'AVTR 4825',
      '1920',
      '2820',
      '3520',
      '4020',
      '4220 10x2',
      '4825 10x2',
    ],
    LogoImageEnum.bugatti: ['Bugatti Truck Model'],
    LogoImageEnum.force: ['Force Heavy','Trax','Force Urbania'],
    LogoImageEnum.jaguar: ['Jaguar Heavy'],
    LogoImageEnum.renault: ['Renault Heavy'],
    LogoImageEnum.tata: [
      'Ace',
      'Intra',
      'Yodha',
      '407',
      '709',
      'Ultra',
      'LPT',
      'LPK',
      'Signa',
      'Prima',
    ],
    LogoImageEnum.volvo: ['FH', 'FH16', 'FM', 'FMX', 'FL', 'FE'],
  },
};
