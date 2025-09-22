import 'package:earningfish/core/constant/constant.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/presentation/bloc/brand_cubit/brand_cubit.dart';
import 'package:earningfish/features/presentation/bloc/pdi_bloc/pdi_bloc.dart';
import 'package:earningfish/features/presentation/widgets/pdi_widget/pdi_builddatafiled_widget.dart';
import 'package:earningfish/features/presentation/widgets/pdi_widget/pdi_buildtextfiled_widget.dart';
import 'package:earningfish/features/presentation/widgets/pdi_widget/pdi_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialDetailsTab extends StatefulWidget {
  const InitialDetailsTab({super.key});

  @override
  State<InitialDetailsTab> createState() => _InitialDetailsTabState();
}

class _InitialDetailsTabState extends State<InitialDetailsTab> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  bool _controllersInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final fields = [
      'modelVariant',
      'chassisNo',
      'engineNo',
      'keyNo',
      'batteryMake',
      'batterySerialNo',
      'dateOfReceipt',
      'pdiKms',
      'bodyShade',
    ];

    for (String field in fields) {
      _controllers[field] = TextEditingController();
      _controllers[field]?.addListener(() => _updateData());
    }
    _controllersInitialized = true;
  }

  void _updateControllerValues(PDIData data) {
    if (!_controllersInitialized) return;

    final Map<String, String> fieldValues = {
      'chassisNo': data.chassisNo,
      'engineNo': data.engineNo,
      'keyNo': data.keyNo,
      'batteryMake': data.batteryMake,
      'batterySerialNo': data.batterySerialNo,
      'dateOfReceipt': data.dateOfReceipt,
      'pdiKms': data.pdiKms,
      'bodyShade': data.bodyShade,
    };

    fieldValues.forEach((key, value) {
      if (_controllers[key]?.text != value) {
        _controllers[key]?.text = value;
      }
    });
  }

  void _updateData() {
    context.read<PDIBloc>().add(
      UpdateInitialDetailsEvent(
        chassisNo: _controllers['chassisNo']?.text,
        engineNo: _controllers['engineNo']?.text,
        keyNo: _controllers['keyNo']?.text,
        batteryMake: _controllers['batteryMake']?.text,
        batterySerialNo: _controllers['batterySerialNo']?.text,
        dateOfReceipt: _controllers['dateOfReceipt']?.text,
        pdiKms: _controllers['pdiKms']?.text,
        bodyShade: _controllers['bodyShade']?.text,
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selected = context.watch<BrandModelCubit>().state;
    final variants = modelVariants[selected.modelName] ?? [selected.modelName];

    final currentValue =
        variants.contains(selected.variantName) ? selected.variantName : null;

    return BlocBuilder<PDIBloc, PDIState>(
      builder: (context, state) {
        final cubit = context.read<PDIBloc>();
        _updateControllerValues(cubit.currentData);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Model Name:  ',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        Expanded(
                          child: Text(
                            selected.modelName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            softWrap: true,
                            maxLines: null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ConstantWidgets.hight10(context),
                DropdownButtonFormField<String>(
                  focusColor: AppPalette.whiteColor,
                  hint: const Text("Select Model Variant"),
                  dropdownColor: const Color(0xFFEAF4F4),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppPalette.whiteColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppPalette.hintColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppPalette.blueColor,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppPalette.hintColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  value: currentValue,
                  isExpanded: true, // ✅ ensures it takes full width
                  items:
                      variants
                          .map(
                            (variant) => DropdownMenuItem(
                              value: variant,
                              child: Text(
                                variant,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          )
                          .toList(),
                  selectedItemBuilder: (context) {
                    return variants
                        .map(
                          (variant) => Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              variant,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        )
                        .toList();
                  },
                  onChanged: (value) {
                    if (value != null) {
                      context.read<BrandModelCubit>().selectVariant(value);
                    }
                  },
                ),
                ConstantWidgets.hight20(context),
                buildTextField('Chassis No.', 'chassisNo', _controllers),
                buildTextField('Engine No.', 'engineNo', _controllers),
                buildTextField('Key No.', 'keyNo', _controllers),
                buildTextField('Battery Make', 'batteryMake', _controllers),
                buildTextField(
                  'Battery Serial No.',
                  'batterySerialNo',
                  _controllers,
                ),
                buildDateField(
                  'Date of Receipt in Yard',
                  'dateOfReceipt',
                  _controllers,
                  context,
                ),
                buildTextField('PDI KMS', 'pdiKms', _controllers),
                buildTextField('Body Shade', 'bodyShade', _controllers),
              ],
            ),
          ),
        );
      },
    );
  }
}

final Map<String, List<String>> modelVariants = {
  //! NISSAN CAR
  // Magnite nissan car variants
  'Magnite': [
    'XE',
    'XL',
    'XV',
    'XV Premium',
    'Turbo XL',
    'Turbo XV',
    'Turbo XV Premium',
    'XV Premium (O)',
    'Kuro Edition',
    'Geza Edition',
  ],
  // x-trail variants
  'X-Trail': [
    'STD',
    'S',
    'SV',
    'SL',
    'VL',
    'ST',
    'ST-L',
    'Ti',
    'Ti-L',
    'N-Trek',
    'X',
    'G',
    'e-Power S',
    'e-Power SV',
    'e-Power SL',
    'e-Power Ti',
  ],
  // X-trail varient
  'Juke': [
    'Visia',
    'Acenta',
    'Tekna',
    'Tekna+',
    'Nismo',
    'Nismo RS',
    'N-Connecta',
  ],

  'Sunny': [
    'XE P (Petrol) Manual',
    'XL P (Petrol) Manual',
    'XE D (Diesel) Manual',
    'Special Edition (Diesel) Manual',
    'XL D (Diesel) Manual',
    'XL CVT AT (Petrol Automatic)',
    'XV CVT (Petrol Automatic)',
    'XV D (Diesel Manual)',
    'XV Premium Pack (Leather) Diesel',
    'XV Premium Pack (Safety) Diesel',
  ],
  'GT-R': [
    'Premium',
    'Premium AWD',
    'T-Spec',
    'Skyline Edition',
    'NISMO',
    'Black Edition',
    'Track Edition',
    'Special Editions',
  ],

  'Ariya': [
    'Single Motor',
    'Single Motor Range +',
    'e-4orce Dual Motor',
    'e-4orce Performance',
  ],
  'Leaf': ['S', 'SV PLUS', 'S+', 'SV+', 'Platinum+'],
  'Kicks': ['XL', 'XE', 'XV', 'XV Premium', 'XV Premium (Option / O)'],
  'Versa': ['S', 'SV', 'SR'],

  'Sentra': ['S', 'SV', 'SR', 'Midnight Edition'],

  'Altima': ['S', 'SV', 'SR', 'SL'],

  'Murano': ['SV', 'SL', 'Platinum'],

  'Armada': ['SV', 'SL', 'Platinum', 'PRO-4X', 'Platinum Reserve'],

  //! mg model
  'Windsor EV': [
    'Excite',
    'Exclusive',
    'Essence',
    'Exclusive Pro',
    'Essence Pro',
  ],
  'Windsor EV Pro': ['Exclusive Pro', 'Essence Pro'],
  'Hector': [
    'Style',
    'Select Pro',
    'Smart Pro',
    'Sharp Pro',
    'Savvy Pro',
    'BlackStorm',
    'SnowStorm',
    '100 Year Limited Edition',
  ],

  'Hector Plus': [
    'Style',
    'Select Pro',
    'Smart Pro',
    'Sharp Pro',
    'Savvy Pro',
    'BlackStorm',
    'SnowStorm',
    '100 Year Limited Edition',
  ],

  'Astor': [
    'Sprint',
    'Shine',
    'Select',
    'Sharp Pro',
    'Select BlackStorm',
    'Sharp Pro CVT',
    'Savvy Pro',
    'Savvy Pro Sangria',
    '100 Year Limited Edition',
  ],

  'ZS EV': [
    'Executive',
    'Excite Pro',
    'Exclusive Plus',
    'Exclusive Plus DT',
    'Essence',
    'Essence DT',
    '100 Year Limited Edition',
  ],

  'Gloster': ['Sharp', 'Savvy', 'Black Storm', 'Desert Storm', 'Snow Storm'],

  'Astor Facelift': [
    'Sprint',
    'Shine',
    'Select',
    'Sharp Pro',
    'Savvy Pro',
    'Select Blackstorm',
    '100 Year Limited Edition',
    'Savvy Pro Sangria',
  ],

  'Comet EV': [
    'Executive',
    'Excite',
    'Excite FC',
    'Exclusive',
    'Exclusive FC',
    'Blackstorm Edition',
  ],
  'M9 EV': ['Presidential Limo'],
  'Cyberster': ['GT 77 kWh'],

  'Majestor': [
    'Sharp 7-STR 2.0 Turbo 2WD',
    'Savvy 7-STR 2.0 Turbo 2WD',
    'Savvy 6-STR 2.0 Turbo 2WD',
    'Savvy 6-STR 2.0 Twin-Turbo 4WD',
    'Savvy 7-STR 2.0 Twin-Turbo 4WD',
  ],
  'MG 4 EV': ['51 kWh / Standard Range', '64 kWh / Long Range'],
  'IM5': [
    'Standard Range (75 kWh RWD)',
    'Long Range (83 kWh RWD)',
    'Performance (100 kWh RWD)',
    'Performance (100 kWh AWD)',
  ],
  'IM6': [
    'Premium (75 kWh RWD)',
    'Platinum (100 kWh RWD)',
    'Performance (100 kWh AWD)',
    'Launch Edition (AWD)',
  ],
  'Kushaq': [
    '1.0L Classic',
    '1.0L Onyx',
    '1.0L Onyx AT',
    '1.0L Signature',
    '1.0L Signature AT',
    '1.0L Sportline',
    '1.0L Sportline AT',
    '1.0L Monte Carlo',
    '1.0L Monte Carlo AT',
    '1.0L Prestige',
    '1.0L Prestige AT',
    '1.5L Sportline DSG',
    '1.5L Signature DSG',
    '1.5L Monte Carlo DSG',
    '1.5L Prestige DSG',
  ],

  'Slavia': [
    '1.0L Classic',
    '1.0L Signature',
    '1.0L Signature AT',
    '1.0L Sportline',
    '1.0L Sportline AT',
    '1.0L Monte Carlo',
    '1.0L Monte Carlo AT',
    '1.5L Prestige DSG',
    '1.5L Monte Carlo DSG',
  ],
  'Kodiaq': ['Lounge (5-Seater)', 'Sportline', 'L&K'],
  'Octavia Facelift': ['Style', 'L&K', 'RS'],
  'Kylaq': ['Signature+', 'Prestige'],
  'X-Bow': ['R', 'RR', 'GT', 'GT4', 'GT-XR', 'GTX', 'GT2'],
  'Victoris': ['LXi', 'VXi', 'ZXi', 'ZXi(O)', 'ZXi+', 'ZXi+(O)'],
  'Swift': [
    'LXi',
    'VXi',
    'VXi(O)',
    'ZXi',
    'ZXi+',
    'VXi AMT',
    'VXi CNG',
    'ZXi AMT',
    'ZXi CNG',
    'VXi Opt',
  ],
  'Brezza': ['LXi', 'VXi', 'ZXi', 'ZXi Plus', 'ZXi Plus AT'],
  'Fronx': ['Sigma', 'Delta', 'Zeta', 'Alpha Turbo', 'Alpha Turbo AT'],
  'Baleno': ['Sigma', 'Delta', 'Zeta', 'Alpha'],
  'Dzire': [
    'LXi',
    'VXi',
    'VXi AMT',
    'VXi CNG',
    'ZXi',
    'ZXi AMT',
    'ZXi Plus',
    'ZXi Plus AMT',
    'ZXi CNG',
  ],
  'Grand Vitara': [
    'Sigma',
    'Delta',
    'Delta CNG',
    'Delta AT',
    'Zeta',
    'Zeta(O)',
    'Alpha',
    'Alpha(O)',
    'Zeta Plus Hybrid',
    'Alpha Plus Hybrid',
    'Alpha AWD',
    'Alpha AWD Dual Tone',
  ],
  'XL6': ['Zeta', 'Alpha', 'Alpha Plus'],
  'Invicto': ['Zeta Plus 7 STR', 'Alpha Plus 7 STR', 'Zeta Plus 8 STR'],
  'Jimny': ['Zeta MT'],

  'Ciaz': [
    'Sigma',
    'Delta',
    'Zeta',
    'Alpha',
    'Delta AT',
    'Zeta AT',
    'Alpha AT',
    'Ciaz S',
  ],
  'Ertiga': ['LXi', 'VXi', 'ZXi', 'ZXi+', 'ZXi+ Tech Edition'],
  'Wagon R': ['LXi 1.0', 'LXi 1.2', 'VXi 1.0', 'VXi 1.2', 'ZXI Plus 1.2'],
  'Alto K10': ['STD (O)', 'LXi', 'VXi', 'VXi Plus', 'VXi AT'],
  'Eeco': [
    '5-seater STD',
    '5-seater STD (O)',
    '7-seater STD',
    '7-seater STD (O)',
    'Cargo van',
  ],
  'Celerio': [
    'LXi',
    'VXi',
    'VXi CNG',
    'ZXi',
    'VXi AMT',
    'ZXi Plus',
    'ZXi AMT',
    'ZXi Plus AMT',
  ],
  'S-Presso': [
    'STD',
    'LXi',
    'VXi',
    'VXi Plus',
    'LXi CNG',
    'VXi CNG',
    'VXi Opt AT',
    'VXi Plus Opt AT',
  ],
  'Ignis': [
    'Sigma',
    'Delta',
    'Zeta',
    'Alpha',
    'Sigma AMT',
    'Delta AMT',
    'Zeta AMT',
  ],

  //! Hyundai
  'Creta': [
    'E',
    'EX',
    'EX (O)',
    'S',
    'S (O)',
    'SX',
    'SX Tech',
    'SX Premium',
    'SX (O)',
    'SX Premium DT',
    'Knight',
  ],
  'Venue': [
    'E',
    'E Plus',
    'S',
    'S Plus',
    'S Opt',
    'SX',
    'SX (O)',
    'SX Knight',
    'SX Opt Turbo',
    'SX Opt DCT DT',
    'SX DT',
    'SX Adventure',
    'SX Adventure DT',
    'SX Turbo DCT AT',
    'Signature Diesel AT',
    'Signature Diesel 4WD AT DT',
  ],
  'Exter': [
    'S Smart',
    'SX Smart',
    'S Smart AMT',
    'S Smart Dual CNG',
    'SX Smart AMT',
    'SX Smart Dual CNG',
    'EX Dual CNG',
    'S Plus',
    'S Executive CNG',
    'SX Tech',
    'SX Knight',
    'SX Opt Connect Knight',
    'SX Opt Connect Knight DT',
    'SX DT',
    'EX Opt',
    'SX Opt Connect',
    'SX Opt DT AMT',
  ],

  'Tucson': [
    'Platinum AT',
    'Platinum Diesel AT',
    'Signature AT',
    'Signature AT DT',
    'Signature Diesel AT',
    'Signature Diesel AT DT',
    'Signature Diesel 4WD AT',
    'Signature Diesel 4WD AT DT',
  ],

  'Alcazar': [
    'Executive',
    'Prestige',
    'Platinum',
    'Signature',
    'Knight Edition',
  ],
  'Verna': [
    'EX',
    'S',
    'SX',
    'SX(O)',
    'SX Plus',
    'SX Plus iVT',
    'S iVT',
    'SX Turbo',
    'SX Turbo DCT',
    'SX Opt',
    'SX Opt Turbo DCT DT',
    'SX Opt Turbo DT',
    'SX Turbo DT',
  ],
  'Aura': [
    'E',
    'S',
    'SX',
    'SX Plus AMT',
    'SX (O)',
    'S AMT',
    'S Corporate',
    'SX CNG',
    'S CNG',
    'E CNG',
    'SX Option',
  ],
  'i20': [
    'Magna Executive',
    'Magna',
    'Magna IVT',
    'Sportz',
    'Sportz Opt',
    'Sportz Opt Knight',
    'Sportz IVT',
    'Asta',
    'Asta Opt',
    'Asta Opt IVT',
    'Asta Opt DT',
    'Sportz (O) Knight',
    'Asta (O)',
    'Asta (O) IVT DT',
    'Sportz Opt IVT',
  ],
  'Grand i10 Nios': [
    'Era',
    'Magna',
    'Sportz',
    'Corporate',
    'Sportz Opt',
    'Magna AMT',
    'Sportz AMT',
    'Sportz CNG',
    'Magna CNG',
    'Asta',
    'Sportz DT',
    'Sportz Opt AMT',
    'Corporate AMT',
    'Sportz Duo CNG',
    'Sportz Opt CNG',
  ],
  'Venue N Line': [
    'N6 Turbo',
    'N6 Turbo DT',
    'N8 Turbo',
    'N8 Turbo DT',
    'N6 Turbo DCT',
    'N6 Turbo DCT DT',
    'N8 Turbo DCT',
    'N8 Turbo DCT DT',
  ],
  'Creta Electric': [
    'Executive (42 kWh)',
    'Smart (42 kWh)',
    'Smart (O) (42 kWh)',
    'Premium (42 kWh)',
    'Smart (O) (51.4 kWh)',
    'Excellence (51.4 kWh)',
  ],
  'Ioniq 5': ['Long Range RWD 72.6 kWh'],
  //! kia
  'Sonet': [
    'HTE',
    'HTE (O)',
    'HTK',
    'HTK (O)',
    'HTK+ (O)',
    'HTX',
    'GTX+',
    'X Line',
  ],
  'Seltos': [
    'HTK',
    'HTK (O)',
    'HTK Plus (O)',
    'HTX',
    'HTX (O)',
    'GTX Plus',
    'X-Line',
  ],

  'Syros': ['HTK', 'HTK (O)', 'HTK Plus', 'HTX', 'HTX Plus', 'HTX Plus (O)'],

  'Carens': ['Premium Opt', 'Premium Opt Diesel'],
  'Carens Clavis': ['HTE', 'HTE (O)', 'HTK', 'HTK+', 'HTK+ (O)', 'HTX', 'HTX+'],

  'Carens Clavis EV': ['HTK+', 'HTX', 'HTX ER', 'HTX+ ER'],

  'Carnival': ['Limousine', 'Limousine Plus'],

  'EV9': ['GT Line AWD'],
  'EV6': ['GT Line', 'GT Line AWD'],

  'Amaze': ['V', 'V CVT', 'VX', 'VX CVT', 'ZX', 'ZX CVT'],

  'Elevate': [
    'SV',
    'V',
    'V CVT',
    'VX',
    'VX CVT',
    'ZX',
    'ZX CVT',
    'ZX Black Edition',
    'ZX Black Edition CVT',
    'V Reinforced',
    'V CVT Reinforced',
    'VX Reinforced',
  ],
  'Amaze 2nd Gen': ['S (Manual)', 'S CVT'],
  'City': ['SV', 'V', 'V CVT', 'VX', 'VX CVT', 'ZX', 'ZX CVT', 'Sport'],
  'City e:HEV': ['ZX'],
  'City Hybrid': ['ZX CVT Reinforced'],
  'City Sports': ['City Sport'],
  'HR-V': ['Expected Base Variant'],
  'Glanza': ['E', 'S', 'S AMT', 'S CNG', 'G', 'G AMT', 'G CNG', 'V', 'V AMT'],
  'Urban Cruiser Taisor': [
    'E',
    'E CNG',
    'G Turbo',
    'G Turbo AT',
    'S',
    'S AMT',
    'S Plus',
    'S Plus AMT',
    'V Turbo',
    'V Turbo AT',
    'V Turbo AT Dual Tone',
    'V Turbo Dual Tone',
  ],

  'Rumion': [
    'S MT Neo Drive',
    'S CNG',
    'G MT Neo Drive',
    'S AT Neo Drive',
    'V MT Neo Drive',
    'G AT Neo Drive',
    'V AT Neo Drive',
  ],
  'Urban Cruiser Hyryder': [
    'E',
    'S',
    'G Opt',
    'V',
    'V Hybrid',
    'S CNG',
    'G Opt HYBRID',
    'S Hybrid',
    'V AWD AT',
    'V HYBRID Dual Tone',
  ],
  'Innova Crysta': [
    '2.4 GX 7Str',
    '2.4 GX 8Str',
    '2.4 GX Plus 7Str',
    '2.4 GX Plus 8Str',
    '2.4 VX 7Str',
    '2.4 VX 8Str',
    '2.4 Zx 7Str',
  ],

  'Innova Hycross': [
    'G-SLF',
    'GX',
    'GX(O)',
    'VX',
    'VX(O)',
    'ZX',
    'ZX(O)',
    'G Fleet 7STR',
    'G Fleet 8STR',
    'VX Hybrid 7STR',
    'VX Hybrid 8STR',
  ],

  'Hilux': ['STD', 'High', 'High AT', 'Black Edition'],

  'Fortuner': [
    'Neo Drive 48V',
    '4x2 AT',
    '4x2 Diesel MT',
    '4x2 Diesel AT',
    '4x4 Diesel MT',
    '4x4 Diesel AT',
    'Leader Edition 4x2 Diesel',
    'Leader Edition 4x2 Diesel AT',
    'GR-S 4x4 Diesel AT',
  ],

  'Legender': ['4x2 AT', '4x4 MT', '4x4 AT', 'Neo Drive 48V'],

  'Camry': ['Sprint Edition', 'Elegant', 'Elegant Platinum White Pearl'],

  'Vellfire': ['Hi', 'VIP Executive Lounge'],

  'Land Cruiser 300': ['ZX', 'GR-S'],

  'Urban Cruiser EV': ['49 kWh FWD', '61 kWh FWD', '61 kWh AWD'],

  'Virtus': [
    'Comfortline',
    'Highline',
    'Highline Plus',
    'Highline AT',
    'Highline Plus AT',
    'GT Line',
    'GT Line AT',
    'Topline ES',
    'Topline AT ES',
    'GT Plus Sport',
    'GT Plus Sport DSG',
    'GT Plus ES',
    'GT Plus DSG ES',
  ],
  'Taigun': [
    'Taigun Trendline',
    'Taigun Comfortline',
    'Taigun Highline',
    'Taigun Topline',
    'Taigun GT',
  ],
  'Golf GTI': [
    'Golf GTI Performance',
    'Golf GTI Clubsport',
    'Golf GTI Edition',
  ],
  'Tiguan R-Line': ['Tiguan R-Line Comfortline', 'Tiguan R-Line Highline'],

  'Kwid': [
    '1.0 RXE',
    '1.0 RXE CNG',
    '1.0 RXL Opt',
    '1.0 RXL Opt CNG',
    '1.0 RXT',
    '1.0 RXT CNG',
    '1.0 RXT AMT',
    '1.0 Climber',
    '1.0 Climber Dual Tone',
    '1.0 Climber DT',
    '1.0 Climber DT AMT',
  ],

  'Triber': ['Authentic', 'Evolution', 'Techno', 'Emotion'],

  'Kiger': [
    'Authentic',
    'Evolution',
    'Techno',
    'Emotion',
    'Emotion Turbo',
    'Emotion CVT',
    'Techno AMT',
    'Authentic MT CNG',
    'Emotion MT Dual Tone',
    'Techno Turbo CVT Dual Tone',
  ],

  'Duster': ['RXE', 'RXS', 'RXZ', 'RXZ+'],

  'Kardian': ['Base', 'Mid', 'High', 'Premium'],
  //! Jaguar
  'F-Pace': [
    'R-Dynamic S Petrol',
    'R-Dynamic S Diesel'
        '2.0 R-Dynamic S Petrol',
    '2.0 R-Dynamic S Diesel',
    'P250 R-Dynamic SE',
    'P340 R-Dynamic SE',
    'P400 R Performance',
  ],

  'E-Pace': ['P200 S', 'P250 SE', 'P250 HSE', 'P300 HSE'],

  'XE': ['P200 S', 'P200 SE', 'P250 SE', 'P300 SE Dynamic Edition'],

  'XF': [
    'P250 R-Dynamic S',
    'P300 R-Dynamic SE',
    'P400 R-Dynamic Black',
    'P300 Sportbrake',
  ],

  'I-Pace': ['EV400 SE', 'EV400 HSE', 'EV400 S', 'EV360 Sport'],

  'F-Type': ['P450 R', 'P450 R-DYNAMIC', 'P550-GA R'],

  'EX40': ['E60 Plus', 'E80 Ultimate'],

  'XC40': ['B4 Ultimate'],

  'S90': ['B5 Inscription', 'B5 Ultimate'],

  'XC60': ['Ultra'], 'S60': ['T4 Inscription'],

  'V90 Cross Country': ['D5 Inscription'],
  //! audi
  'A3': [
    'Technology 35 TFSI',
    'Standard 35 TFSI',
    'Premium 35 TFSI',
    'Premium Plus 35 TFSI',
  ],
  'A4': [
    'Premium 40 TFSI',
    'Premium Plus 40 TFSI',
    'Technology 40 TFSI',
    'Signature Edition',
  ],

  'A8': ['Celebration Edition', 'Technology'],
  'Q3': ['Bold Edition', 'Premium', 'Premium Plus', 'Technology'],

  'e-tron': [
    '50 Quattro',
    '55 Quattro',
    '55 Sportback',
    '55 Technology',
    '55 Sportback Technology',
  ],
  'Q5': ['Premium Plus', 'Bold Edition', 'Technology'],

  'Q7': ['Premium Plus', 'Bold Edition', 'Technology', 'Signature Edition'],

  'Q8': ['Quattro'], 'TT': ['45 TFSI'],

  'R8': ['5.2 V10', '5.2 V10 Plus'],
  'RS3': ['Single variant listed (Sportback / Sedan)'],

  'RS5': ['Single variant listed (Sportback) with 2.9L TFSI engine'],

  'RS7': ['Single variant listed (4.0L TFSI, Sportback)'],

  //! bmw
  'X1': ['sDrive18i M Sport', 'sDrive18d M Sport', 'X Line'],

  'X5': ['xDrive40i', 'xDrive30d M Sport Pro'],

  'X7': ['xDrive40i M Sport'],
  '2 Series Gran Coupé': ['218i M Sport', '218i M Sport Pro'],

  'XM': ['xDrive'],
  'M5': ['xDrive'],

  'i7': ['eDrive50 M Sport', 'xDrive60 M Sport', 'M70 xDrive'],

  //! benz
  'A-Class': ['A 200', 'A 200d'],

  'C-Class': ['C 200', 'C 220d', 'C 300 AMG Line'],
  'E-Class': ['E 200', 'E 220d', 'E 450'],

  'S-Class': ['S 350d', 'S 450 4Matic'],
  'GLA': ['200', '220d 4MATIC', '220d 4MATIC AMG Line'],

  'GLC': ['300 4MATIC'],

  'GLE': ['300d 4MATIC AMG Line', '450 4MATIC', '450d 4MATIC'],

  'GLS': [
    '450 4MATIC',
    '450d 4MATIC',
    '450 4MATIC AMG Line',
    '450d 4MATIC AMG Line',
  ],
  'G-Class': [
    '400d Adventure Edition',
    '400d AMG Line',
    'AMG G 63',
    'AMG G 63 Collector\'s Edition',
    'AMG G 63 Grand Edition',
  ],

  'AMG GT': [
    '63 4MATIC Plus',
    '63 Pro 4MATIC Plus',
    'Roadster',
    'AMG GT R',
    'AMG GT S',
  ],
  'EQC': ['400 4MATIC'],

  'EQB': ['250+', '350 4MATIC'],

  'EQS': ['580 4MATIC Celebration Edition', '580 4MATIC'],

  //! mahindra
  "Thar": [
    "AX (O) Hard Top Diesel MT RWD",
    "LX Hard Top Diesel MT RWD",
    "LX Hard Top Petrol AT RWD",
    "LX Hard Top Petrol MT 4WD",
    "LX Hard Top Diesel MT 4WD",
    "LX Hard Top Petrol AT 4WD",
    "LX Hard Top Diesel AT 4WD",
    "Earth Edition Diesel",
    "LX Convert Top Diesel AT",
    "etc.",
  ],
  "Scorpio": ["S", "S 9 Seater", "S11", "S11 7CC"],
  "XUV700": ["MX", "AX3", "AX5", "AX7", "AX7 L", "AX5 S"],
  "XUV300": ["W2", "W4", "W6", "W8", "W8 (O)"],
  'Marazzo': [
    'M2 8Str',
    'M2 7Str',
    'M4 Plus 7Str',
    'M4 Plus 8Str',
    'M6 Plus 7Str',
    'M6 Plus 8Str',
  ],
  'Bolero': [
    'B4',
    'B4 Bold Edition',
    'B6',
    'B6 Bold Edition',
    'B6 (O)',
    'B6 (O) Bold Edition',
  ],
  'Alturas G4': [
    '4X2 AT Base',
    '4X2 AT',
    '4X2 AT High',
    '4X4 AT',
    '4X4 AT Top Model',
  ],

  'KUV100': [
    'K2 6 STR',
    'Trip 6S CNG',
    'K2 Plus 6 STR',
    'K4 Plus 5 STR',
    'K4 Plus 6 STR',
    'K8 5 STR',
    'K8 6 STR',
    'K8 6 STR Dual Tone',
  ],

  'XUV400': [
    'EC Pro 34.5 kWh',
    'EL Pro 34.5 kWh',
    'EL Pro DT 34.5 kWh',
    'EL Pro 39.4 kWh',
    'EL Pro DT 39.4 kWh',
  ],
  "Cooper": [
    "Cooper Hatch (Base) / 3-Door / 5-Door",
    "Cooper S",
    "Cooper SE (electric)",
    "Cooper Convertible",
    "Cooper Hardtop",
  ],
  "Cooper S": [
    "Cooper S Standard",
    "Cooper S John Cooper Works Pack",
    "Cooper S Convertible",
    "Cooper S 5-Door",
  ],
  "Cooper SE": [
    "SE Electric Hatch",
    "SE Countryman",
    "SE ALL4",
    "SE John Cooper Works Pack (electric)",
  ],
  "Clubman": [
    "Clubman Classic",
    "Clubman Signature",
    "Clubman Signature Plus",
    "Clubman ALL4",
    "Clubman John Cooper Works",
  ],
  "Countryman": [
    "Countryman Cooper",
    "Countryman Cooper S",
    "Countryman SE ALL4",
    "Countryman JCW ALL4",
    "Countryman Signature",
    "Countryman Iconic",
  ],
  "John Cooper Works": [
    "JCW Hatchback",
    "JCW Convertible",
    "JCW Countryman ALL4",
    "JCW Electric / JCW SE",
    "JCW John Cooper Works Pack variants",
  ],
  "Paceman": [
    "Paceman Cooper",
    "Paceman Cooper S",
    "Paceman ALL4",
    "Paceman John Cooper Works",
  ],

  "Pajero Sport": [
    "2.5 MT Diesel",
    "2.5 AT Diesel",
    "Limited Edition",
    "Select Plus AT",
    "Select Plus MT",
  ],
  "Eclipse Cross": ["ES", "SE", "SEL", "GT", "PHEV"],
  "Outlander": ["ES", "SE", "SEL", "Trail Edition", "SEL Premium Package"],
  "ASX": ["Base", "Mid", "High", "Sport"],
  "Xpander": ["GLX", "GLS", "Cross", "Sporty / Top Trim"],
  "Montero": ["Base", "GLS", "Limited", "Sport"],
  "L200": ["GLX", "GLS", "Exceed", "Athlete", "4x4"],
  "Nexon": [
    "Smart",
    "Smart+",
    "Smart+ (S)",
    "Pure",
    "Pure (S)",
    "Creative",
    "Creative+",
    "Creative+ (S)",
    "Fearless",
    "Fearless (S)",
    "Fearless+",
    "Fearless+ (S)",
    "Persona editions.",
  ],
  "Harrier": [
    "Smart",
    "Pure X",
    "Adventure X",
    "Adventure X Plus",
    "Fearless X",
    "Fearless X Plus",
    "Dark editions / Dual Tone / Stealth etc.",
  ],
  "Safari": [
    "Smart",
    "Pure X",
    "Adventure X",
    "Adventure X Plus",
    "Fearless X",
    "Fearless X Plus",
    "Dark / Stealth special editions",
  ],
  "Punch": [
    "Pure",
    "Adventure",
    "Accomplished",
    "Creative",
    "Style Pack / Special Editions",
  ],
  "Altroz": [
    "XE",
    "XM",
    "XT",
    "XT Premium",
    "XZ",
    "XZ Lux",
    "iTurbo",
    "Dual Tone / Special Editions",
  ],
  "Tiago": [
    "XE",
    "XM",
    "XT",
    "XT Plus",
    "XZ",
    "XZ Plus",
    "XZA (AMT)",
    "iCNG variants",
  ],
  "Tigor": [
    "XM",
    "XT",
    "XZ",
    "XZ Plus",
    "XZ+ Lux",
    "XZA (AMT)",
    "iCNG / CNG variants",
  ],
  "H2X": ["Base", "Mid", "Top / Premium / Special Edition"],
  "Hexa": [
    "XE",
    "XM",
    "XM Plus",
    "XT",
    "XMA",
    "XTA",
    "XT 4x4",
    "Dual Tone & seating-capacity ",
  ],
  "Bolt": ["LS", "LS (O)", "LS Sport", "LS Leather / Special editions"],
  "Indica": [
    "Base",
    "DLX",
    "TDI DLX",
    "LS",
    "GLS",
    "Special Series / VX / ZX etc.",
  ],
  "Indigo": [
    "GLX",
    "LX",
    "TDI / CR4 variants",
    "XL",
    "CS / Taxi variants",
    "Special editions",
  ],

  "Yodha": ["Yodha Base", "Yodha Higher GVW"],
  "Intra": [
    'Intra V30',
    'Intra V50',
    'Intra V70',
    "Intra V10 Base",
    "Intra V10 HVW",
    "Intra V30 Base",
    "Intra V30 HVW",
    "Intra V50 Base",
    "Intra V50 High Payload",
    "Intra V70 Base",
    "Intra V70 High Payload",
  ],
  "Tata 407/709/1109": [
    "407 Gold SFC",
    "407 Base",
    "709 Standard",
    "709 Higher Payload",
    "1109 Base",
    "1109 Higher Payload",
  ],
  "LPT": ["LPT 1216", "LPT 1416", "LPK 2821K FE+", "LPK 1612"],
  "Ultra": [
    "Ultra T.6",
    "Ultra T.8",
    "Ultra T.12",
    'Ultra Sleek',
    "Ultra Sleek T.6",
    "Ultra Sleek higher GVW",
  ],
  "Signa": [
    "Signa 2821.T",
    "Signa 3125.T",
    "Signa 3525.T",
    "Signa 4830.T",
    "Signa 3523.TK",
    "Signa 5532.S",
    "Signa 2818.T",
    "Signa 2823.K / TK",
  ],
  "Prima": [
    "Prima 3530.K HRT",
    "Prima 5530.S",
    "Prima 2830.K",
    'Signa 3125.T',
    'Signa 3525.T',
    'Signa 4830.T',
    'Signa 3523.TK'
        'Prima 5530.S',
    'Prima LNG variants',
    "Prima 2825.K / TK",
    "Prima E.55S",
    "Prima G.35K",
    "Prima 4625.S",
    "Prima 3525.K / TK",
  ],
  "Other Tata models": ["Tata 1512 LPT", "Tata 1518", "Tata 2515", "Tata 3118"],
  //! renault
  "Renault Trucks T": [
    "DTI 11 380 hp",
    "DTI 11 430 hp",
    "DTI 11 460 hp",
    "DTI 13 440 hp",
    "DTI 13 480 hp",
    "DTI 13 520 hp",
    'Renault Trucks T Range',
    'Renault Trucks T High',
    "DTI 13 Turbo Compound",
  ],
  "Renault Trucks T High": [
    "DTI 13 440 hp",
    "DTI 13 480 hp",
    "DTI 13 520 hp",
    "Turbo Compound",
    "Smart Racer Package",
  ],
  "Renault Trucks C": [
    "Renault Trucks C Range"
        "C Range Payload Version",
    "C Range Versatility Version",
    "C with Fuel Economy Options",
  ],
  "Renault Trucks K": [
    "Renault Trucks K Range"
        "K Range Rugged",
    "K Range High Payload",
    "K Range Off-road Tough",
  ],
  "Renault Trucks D": [
    "D (rigid 7.5-18 t, 2.1m cab width)",
    "D Wide (rigid 16-26 t, 2.3m cab width)",
    "D Access (low entry cab, 18-26 t)",
    "D Cab 2 m (3.5-7.5 t, very compact 2m-wide cab)",
    "E-Tech D (electric variant)",
    "DTi 5 engine versions (210 hp, 240 hp)",
    "DTi 8 engine versions (250 hp, 280 hp)",
    "DTi 8 320 hp (Wide / higher payload versions)",
    "CNG / natural gas variants",
    "Fuel-eco / efficiency packs (Optifuel, Fuel Eco Pack etc.)",
  ],

  //! volvo truck
  "Volvo FH": [
    "Diesel (420-540 hp) power variants",
    "Gas-powered (LNG / biofuel) variants",
    "Electric variant (Volvo FH Electric)",
    "Cab types: day cab, sleeper, Globetrotter etc.",
    "Aero version (Volvo FH Aero) for better aerodynamics / efficiency",
  ],
  "Volvo FH16": [
    "Heavy-duty high power variants (e.g. 550 hp, 600 hp, up to ~780 hp)",
    "Different engine sizes / torque options",
    "Globetrotter / XL cabs",
    "Aero version for FH16 (Volvo FH16 Aero)",
  ],
  "Volvo FH Aero": [
    "FH Aero Diesel",
    "FH Aero Electric",
    "FH Aero Gas / Bio-fuel powered",
    "FH16 Aero (high-power aero variant)",
  ],
  "Volvo FMX": [
    "Trim levels: Robust, Dynamic, Progressive",
    "Interior upholstery / material differences (vinyl vs textile) between trims",
    "Different engine options (e.g. D11, D13 etc.)",
    "Configurations for axles / driven wheels (6×4, 8×4 etc.)",
    "Electric trim where available",
  ],
  "Volvo FM": [
    "Different exterior trim levels: EXTL-BAS, EXTL-BA2 etc.",
    "Different cab sizes / configurations",
    "Various engine / power options",
    "Electric version (Volvo FM Electric)",
  ],
  "Volvo FE": [
    "Urban / distribution duty variants",
    "Low-entry cab variants",
    "Different GVW (gross vehicle weight) options",
    "Electric / alternative fuel options where offered",
  ],
  "Volvo FL": [
    "Smaller distribution truck variants",
    "Different body length / wheelbase options",
    "Different engine / emission norms",
    "Electric versions in selected markets",
  ],
  "Volvo FM Electric": [
    "Different battery pack / range variants",
    "Drive-configuration variants",
    "Interior trim / comfort / safety packages",
  ],
  "Volvo FH Electric": [
    "Range variants (battery-size differences)",
    "Power output options",
    "Cabin types etc.",
  ],
  "Volvo FMX Electric": [
    "Electric version for construction / tough terrain",
    "Interior trim / specification differences (e.g. upholstery, rugged fittings)",
    "Drive layout / suspension variants",
  ],
  "Volvo VNL/VNR": [
    "Trim levels like Fleet, Express, Platinum (for VNR)",
    "Different cab configurations (roof height, sleeper, day cab etc.)",
    "Different engine / power options",
    "Exterior / interior trim packages (chroming, accessories, lighting etc.)",
  ],
  "Volvo VM": [
    "Medium duty truck variants",
    "Engine / emission norm versions",
    "Different axle / payload configurations",
    "Different cab size / feature levels",
  ],

  //! ashoklayland
  "Dost": [
    "Dost family"
        "Dost LE",
    "Dost LS",
    "Dost LX",
    "Dost CNG (LE & LS)",
    "Dost+ LE",
    "Dost+ LS",
    "Dost+ LX",
    "Dost Strong",

    'Bada Dost',
    "Bada Dost i3+",
    "Bada Dost i4",
    "Bada Dost i5",
  ],
  "Boss": [
    "Boss 1920"
        "Boss 1920 CBC/4700",
    "Boss 1920 CBC/5100",
    "Boss 1920 CBC/5750",
    "Boss 1920 CBC/6700",
    "Boss 1920 Pol Tanker 4700",
    "Boss 1920 Pol Tanker 5100",
    "Boss 1920 Pol Tanker 5750",
    "Boss 1920 Pol Tanker 6700",
    "Boss 1920 Pol Tanker 5350",
    "Boss 1920 4700/HSD",
    "Boss 1920 5100/HSD",
    "Boss 1920 5750/HSD",
    "Boss 1920 6700/HSD",
  ],
  "Ecomet": [
    "1015 HE (Cargo)",
    "1015 HE Tipper",
    "1115 HE",
    "1215 HE",
    "1415 HE",
    "1415 TE (Tipper)",
    "1615 HE",
    "1815 Plus",
    "1915 HE / Ecomet Star 1915 HE",
    "1815 HE / Star variants",
  ],
  "Partner": [
    "Partner 4 Tyre",
    "Partner 6 Tyre",
    "Partner Super 914",
    "Partner Super 1014 HL",
    "Partner Super 1114 HL",
  ],
  "Saathi": ["Saathi FSD – GVW 2288 kg", "Saathi Base ", "Saathi single"],
  "AVTR": [
    "AVTR 1920 4×2",
    "AVTR 3525-8×4",
    "AVTR 2820-6×4",
    "AVTR 2820-6×2",
    "AVTR SPAN",
    "GVW",
  ],
  "Comet": ["Comet tipper variant", "Comet haulage"],
  "Titan": ["Titan Double ", "city transits", 'deluxe'],

  //! force
  "Traveller": [
    "Traveller 3050 9-seater",
    "Traveller 3050 12-seater",
    "Traveller 3050 13-seater",
    "Traveller 3350 9-seater",
    "Traveller 3350 10-seater",
    "Traveller 3350 12-seater",
    "Traveller 3350 13-seater",
    "Traveller 3350 Wider Body 12-seater",
    "Traveller 3350 Wider Body 13-seater",
    "Traveller 3700 Super 16-seater",
    "Traveller 3700 Super 17-seater",
    "Traveller 4020 Super 19/20-seater",
    "Traveller School Bus variants (13 seater, 20 seater etc.)",
  ],
  "Urbania": [
    "Urbania 3350WB / 9-Seater",
    "Urbania 3350WB / 10-Seater",
    "Urbania 3615WB / 12-Seater",
    "Urbania 3615WB / 13-Seater",
    "Urbania 4400WB / 12-Seater",
    "Urbania 4400WB / 13-Seater",
    "Urbania 4400WB / 16-Seater",
    "Urbania 4400WB / 17-Seater",
  ],
  "Trax Cruiser": [
    "9 STR (Manual Diesel 2596 cc)",
    "9 STR AC (Manual Diesel 2596 cc)",
    "12 STR (Manual Diesel 2596 cc)",
    "12 STR AC (Manual Diesel 2596 cc)",
  ],
  "Monobus": [
    "4020WB Passenger Non-AC Diesel",
    "4020WB Passenger AC Diesel",
    "4020WB Passenger Non-AC CNG",
    "4020WB Passenger AC with Stuck Glass Diesel",
    "5200WB Passenger Non-AC Diesel",
    "5200WB Passenger Non-AC CNG",
    "Monobus School Bus 4020WB",
    "Monobus School Bus 5200WB",
    "Monobus 33-seater 4020WB",
    "Monobus 41-seater 5200WB",
  ],
  "Delivery Vans": [
    "Traveller DV AC 3050WB",
    "Traveller DV AC 3350WB",
    "Traveller DV AC 3700WB",
    "Traveller DV AC 4020WB",
    "Traveller Wider Body DV AC 4020WB",
    "Trax Delivery Van 3050/2-Seater DV",
    "Trax Delivery Van 3050/5-Seater DCPU",
  ],
  "Gurkha": ["Gurkha 3-Door (4-Seater)", "Gurkha 5-Door (7-Seater)"],

  //! MG truck
  "MG M9 EV (electric MPV)": ["Presidential Limousine"],
  "MG Comet EV": [
    "Executive",
    "Excite",
    "Excite FC",
    "Exclusive",
    "Exclusive FC",
    "Blackstorm Edition",
  ],
  "MG Windsor EV": [
    "Excite",
    "Exclusive",
    "Essence",
    "Exclusive Pro",
    "Essence Pro"
        'windsor EV Pro',
  ],

  'B7R': [
    'B7R Multi-Axle',
    'B7R Sleeper Coach',
    'B7R Seater Coach',
    'B7R School Bus',
    'B7R Staff Bus',
  ],

  //! isuzu
  "F-Series - FTR": [
    "25,950 lbs GVWR Class 6",
    "Cummins B6.7L Diesel Engine",
    "Automatic Allison transmission 2550 RDS / 2500 RDS",
    "Multiple wheelbase options (152-248 inches)",
    "Fuel tank options: 50- or 100-gallon",
  ],
  "F-Series - FVR": [
    "Class 7 version (~33,000 lbs GVWR)",
    "FVR Derate (Class 6 GVWR version)",
    "Same engine (Cummins B6.7L, ~260 HP)",
    "Automatic or manual gearbox depending on spec",
    "Various wheelbase / body-length options",
  ],
  "N-Seriess": [
    "Higher-GVW heavy duty rigid / prime mover versions",
    "6×4 or 6×2 axle configuration",
    "Longer rear body or trailer-capable frames",
    "N-series base / workhorse variants (various GVWs)",
    "N-series CNG / Diesel options",
    "N-series tipper / cargo body types",
    "N-Series wide-cab / longer wheelbase options",
  ],

  //! bike
  //! bajaj
  "Pulsar": [
    "Pulsar 125",
    "Pulsar 150",
    "Pulsar 220F",
    "Pulsar N125",
    "Pulsar N160",
    "Pulsar N250",
    "Pulsar NS125",
    "Pulsar NS160",
    "Pulsar NS200",
    "Pulsar NS400Z",
    "Pulsar RS200",
  ],
  "Dominar": ["Dominar 250", "Dominar 400 STD"],
  "Avenger Street": ["Avenger 160 Street"],
  "Avenger Cruise": ["Avenger 220 Cruise"],
  "CT": ["CT 110X"],
  "Platina": ["Platina 100", "Platina 110", "Platina 110 H-Gear"],
  "Chetak EV": ["Chetak 3001", "Chetak 3501", "Chetak 3502", "Chetak 3503"],

  //! hero
  "Splendor": ["Splendor Plus", "Splendor Plus XTEC", "Super Splendor XTEC"],
  "HF Deluxe": [
    "HF Deluxe All Black OBD2B",
    "HF Deluxe Kick Cast OBD2B",
    "HF Deluxe Self Cast OBD2B",
    "HF Deluxe I3S Cast OBD2B",
  ],
  "Xoom": [
    "Xoom 110"
        "Xoom 110 LX",
    "Xoom 110 VX",
    "Xoom 110 ZX",
    "Xoom 110 Combat Edition",
    "Xoom 124",
    "Xoom 125 VX",
    "Xoom 125 ZX",
    "Xoom 160",
    "Xoom 160 ZX",
  ],

  "Vida V1": ["V1 Plus", "V1 Pro"],
  "Passion": [
    "Passion Plus Standard",
    "Passion STD",
    "Passion Pro Spoke Kick",
    "Passion Pro Alloy Kick",
    "Passion Pro Spoke Self-Start",
    "Passion Pro Alloy Self-Start",
    "Passion Pro Disc Self-Start",
    "Passion Pro i3S",
  ],
  "Glamour": [
    "Glamour Drum",
    "Glamour Disc"
        "Glamour Drum",
    "Glamour Disc",
    "Glamour XTEC Drum",
    "Glamour XTEC Disc",
    "Glamour X125 Drum",
    "Glamour X125 Disc",
  ],
  "Xtreme": [
    "Xtreme QD",
    "Xtreme Sports",
    "Xtreme 160R"
        "Xtreme 125R",
    "Xtreme 160R",
    "Xtreme 200S",
    "Xtreme 160R 4V",
  ],
  "Maestro Edge": [
    "Maestro Edge 125 Drum BS6",
    "Maestro Edge 125 Disc BS6",
    "Maestro Edge 125 Stealth Edition BS6"
        "Maestro Edge 110 Drum / i-3S",
    "Maestro Edge 110 Disc",
    "Maestro Edge 125 Alloy Drum",
    "Maestro Edge 125 Alloy Disc",
    "Maestro Edge 125 Alloy Disc Prismatic Connected",
  ],
  "Pleasure": [
    "Pleasure Self Start Drum Brake",
    "Pleasure Self Start Drum Brake Alloy Wheel",
    "Pleasure +",
    "Pleasure + Xtec",
    "Pleasure + Drum",
    "Pleasure + XTec Drum Jubilant Yellow",
  ],
  "Destini": [
    "Destini 125"
        "Destini 125 VX",
    "Destini 125 ZX",
    "Destini 125 ZX+",
    "Destini Prime",
    "Destini 125 LX",
    "Destini 125 VX",
    "Destini 125 VX Spl Edit PWH 100M"
        "Destini 125 ZX Plus",
    "Destini 125 ZX OBD2B",
    "Destini 125 Xtec",
    "Destini 125 VX Xtec",
    "Destini VX Platinum MBK",
    "Destini VX Spl Edit PWH 100M",
  ],

  //! royal enfiled
  'Bullet': ['Bullet 350', 'Bullet 350 ES', 'Bullet 500', 'Bullet Trials'],
  'Classic': [
    'Classic 350',
    'Classic 350 Dark Horse',
    'Classic 500',
    'Classic Chrome',
  ],
  'Hunter': ['Hunter 350', 'Hunter 350 Retro'],
  'Meteor': [
    'Meteor 350 Fireball',
    'Meteor 350 Stellar',
    'Meteor 350 Supernova',
  ],
  'Scram': ['Scram 411', 'Scram 411 Trail'],
  'Himalayan': [
    'Himalayan Standard',
    'Himalayan Adventure',
    'Himalayan Tourer',
  ],
  'Continental GT': ['Continental GT 650', 'Continental GT 650 RS'],
  'Interceptor': ['Interceptor 650', 'Interceptor 650 Custom'],
  'Shotgun': ['Shotgun 650', 'Shotgun 650 Limited Edition'],
  'Super Meteor': ['Super Meteor 650', 'Super Meteor 650 Chrome'],

  //! honda
  "Activa": [
    "Activa 4G",
    "Activa 5G",
    "Activa 6G STD",
    "Activa 6G DLX",
    "Activa 6G 25-Year Anniversary Edition",
    "Activa 6G H-Smart"
        "Activa 125 DLX",
    "Activa 125 H-Smart",
    "Activa 125 Disc",
    "Activa 125 Premium / Special Edition"
        "Activa STD",
    "Activa DLX",
    "Activa H-Smart",
  ],

  "Shine 125": ["Shine 125 Drum", "Shine 125 Disc"],

  "CBR": [
    'CB350RS',
    'CB200X',
    'CB300R',
    'CB300F',
    "CBR150R",
    "CBR250R",
    "CBR300R",
    "CBR500R",
    "CBR650R",
    "CBR1000RR-R SP",
  ],

  //! harlydeveson
  'X440': ['X440 Standard', 'X440 Custom'],
  'Nightster': ['Nightster 975', 'Nightster Special'],
  'Sportster S': ['Sportster S Standard', 'Sportster S Custom'],
  'Fat Boy 114': ['Fat Boy 114 Standard', 'Fat Boy 114 Limited Edition'],
  'Heritage Classic': ['Heritage Classic 114', 'Heritage Classic Custom'],
  'Road Glide Special': [
    'Road Glide Special Standard',
    'Road Glide Special Custom',
  ],
  'Street Glide Special': [
    'Street Glide Special Standard',
    'Street Glide Special Custom',
  ],
  'Pan America 1250': [
    'Pan America 1250 Standard',
    'Pan America 1250 Adventure',
  ],
  'Pan America 1250 Special': [
    'Pan America 1250 Special Limited',
    'Pan America 1250 Special Custom',
  ],

  //! bugatti
  "PG": [
    "Standard PG × Bugatti Bike (Limited 667 units, under-5 kg carbon fibre)",
    "Custom paint / color-coated carbon finish",
    "Leather upholstery options",
    "Bugatti-Pearl finish",
    "Matching Bugatti Chiron themed finish",
  ],

  //!yamaha
  'R15': ['R15 V4 Standard', 'R15 V4 M Sport', 'R15 V3', 'R15 S'],
  'MT': ['MT-15 Standard', 'MT-15 M Sport', 'MT-03', 'MT-09'],
  'FZ': ['FZ Fi V3', 'FZ Fi V2', 'FZS Fi V3', 'FZS Fi V2'],
  'Aerox': ['Aerox 155 Standard', 'Aerox 155 S', 'Aerox 155 R-Version'],
  'RayZR': ['RayZR 125 Standard', 'RayZR 125 Fi', 'RayZR 125 Street'],
  'Fascino': [
    'Fascino 125 Standard',
    'Fascino 125 Fi',
    'Fascino 125 Limited Edition',
  ],

  //!ktm
  "Duke": [
    "KTM 160 Duke",
    "KTM 200 Duke",
    "KTM 250 Duke",
    "KTM 390 Duke",
    "KTM 890 Duke R",
    "KTM 1390 Super Duke R",
  ],
  "RC": ["KTM RC 200", "KTM RC 390"],
  "Adventure": [
    "KTM 250 Adventure",
    "KTM 390 Adventure (STD)",
    "KTM 390 Adventure X",
    "KTM 890 Adventure R",
    "KTM 1290 Super Adventure S",
  ],

  //! bmw
  "G310RR": ["Standard", "Style Sport", "Limited Edition"],
  "G310R": ["Standard"],
  "G310GS": ["Standard"],
  "S1000RR": ["Standard", "Pro", "Pro M Sport"],
  "M1000RR": ["Standard", "Competition"],

  //! scooter
  //! tvs
  "Jupiter": [
    "Jupiter Drum",
    "Jupiter Drum Alloy",
    "Jupiter SmartXonnect Drum",
    "Jupiter SmartXonnect Disc",
    "Jupiter Special Edition",
  ],
  "NTORQ": [
    "Ntorq 125 Disc",
    "Ntorq 125 Race Edition",
    "Ntorq 125 Super Squad Edition",
    "Ntorq 125 Race XP",
    "Ntorq 125 XT",
    "Ntorq 125 Drum",
  ],
  "iQube Electric": [
    "iQube 2.2 kWh",
    "iQube 3.1 kWh",
    "iQube 3.5 kWh",
    "iQube S 3.5 kWh",
    "iQube ST 3.5 kWh",
    "iQube ST 5.3 kWh",
    "iQube Celebration Edition",
  ],
  "Raider": [
    "Raider Drum",
    "Raider Single Seat",
    "Raider Split Seat",
    "Raider iGO",
    "Raider Super Squad Edition (SSE)",
    "Raider SmartXonnect",
  ],
  "Apache RTR 160": [
    "RTR 160 RM Drum Black Edition",
    "RTR 160 RM Drum",
    "RTR 160 RM Disc",
    "RTR 160 RM Disc BT",
    "RTR 160 Racing Edition",
    "RTR 160 Dual Channel ABS",
    "RTR 160 Limited Edition",
  ],
  "Apache RTR 160 4V": [
    "RTR 160 4V (base)",
    "RTR 160 4V 20th Anniversary / Top Variant with TFT, Projector headlamps, etc.",
  ],
  "Apache RTR 180": ["RTR 180 (standard)"],
  "Apache RTR 200 4V": [
    "RTR 200 4V (base)",
    "RTR 200 4V 20th Anniversary / Top Variant with upgraded lighting, colours, graphics",
  ],
  "Apache RR 310": ["RR 310 (standard)"],

  //! java
  "Jawa 42": [
    "Vega White Single Channel Spoke",
    "Voyager Red Single Channel Spoke",
    "Asteroid Grey Single Channel Spoke",
    "Odyssey Black Single Channel Spoke",
    "Vega White Dual Channel Spoke",
    "Voyager Red Dual Channel Spoke",
    "Asteroid Grey Dual Channel Spoke",
    "Odyssey Black Dual Channel Spoke",
    "Vega White Dual Channel Alloy",
    "Nebula Blue Dual Channel Alloy",
    "Odion Red Matte Dual Channel Alloy",
    "All Star Black Matte Dual Channel Alloy",
    "Sirius White Matte Dual Channel Alloy",
    "Orion Red Matte Dual Channel Alloy",
    "Infinity Black Dual Tone Dual Channel Alloy",
    "Starship Blue Dual Tone Dual Channel Alloy",
    "Celestial Copper Matte Dual Channel Alloy",
    "Cosmic Rock Dual Tone Dual Channel Alloy",
  ],

  "Jawa 42 Bobber": [
    "Moonstone White",
    "Mystic Copper Spoke Wheel",
    "Jasper Red Dual Tone Spoke Wheel",
    "Jasper Red Dual Tone Alloy Wheel",
    "Mystic Copper Alloy Wheel",
    "Red Sheen",
    "Black Mirror",
  ],
  "Jawa 350": [
    "STD - Spoke Wheel",
    "STD - Alloy Wheel",
    "Chrome - Spoke Wheel",
    "Chrome - Alloy Wheel",
    "Legacy Edition",
  ],

  //! mg
  "ePluto 7G": [
    "ePluto 7G CX",
    "ePluto 7G Standard",
    "ePluto 7G Pro",
    "ePluto 7G Max",
  ],
  "eTrance Neo": ["eTrance Neo SX", "eTrance Neo STD", "eTrance Neo Plus"],

  //! ola
  "S1 Pro": [
    "S1 Pro 3 kWh",
    "S1 Pro 4 kWh",
    "S1 Pro Sport",
    "S1 Pro Plus 4 kWh",
    "S1 Pro Plus 5.2 kWh",
  ],
  "S1 X": ["S1 X 2 kWh", "S1 X 3 kWh", "S1 X 4 kWh", "S1 X Plus"],
  "S1 Air": ["S1 Air 2 kWh", "S1 Air 3 kWh", "S1 Air 4 kWh"],

  //! okinawa
  "Praise": ["Praise STD", "Praise Big Disk"],
  "PraisePro": ["PraisePro (single variant)"],
  "iPraise+": ["iPraise Plus (single variant)"],
  "Dual 100": ["Dual 100 STD"],
  "Lite": ["Lite (single variant)"],
  "R30": ["R30 (single variant)"],
  "Okhi-90": ["Okhi-90 (single variant)"],
  "Ridge": ["Ridge (single variant)", 'Ridge+'],

  //! maruthi suzuki
  "e-Scooter Model X": ["Standard (STD)"],
  "Access 125": [
    "Standard Edition",
    "Special Edition",
    "Ride Connect Edition",
    "Ride Connect TFT Edition",
  ],
  "Burgman Street 125": ["Standard", "Ride Connect Edition", "EX"],
  "Avenis 125": ["Standard Edition", "Special Edition", "Race Edition"],

  //! yamaha
  "Fascino 125 Fi Hybrid": [
    "Drum Metallic Black",
    "Drum Cyan Blue",
    "Drum Matte Copper",
    "Drum Metallic White",
    "Drum Silver",
    "Drum Vivid Red",
    "Drum Cool Blue Metallic",
    "Drum Dark Matte Blue",
    "Disc Cyan Blue",
    "Disc Matte Copper",
    "Disc Metallic White",
    "Disc Silver",
    "Disc Vivid Red",
    "Disc Cool Blue Metallic",
    "Disc Dark Matte Blue",
    "S Dark Matte Blue",
    "S Matte Black",
    "S Vivid Red",
    "S Coloured TFT/TBT",
  ],
  "RayZR 125 Fi Hybrid": [
    "Drum",
    "Disc Cyan Blue",
    "Disc Matte Red",
    "Disc Metallic Black",
    "Disc Silver White Cocktail",
    "Disc Racing Blue",
    "Disc Dark Matte Blue",
    "Street Rally",
  ],

  //! benli
  "TRK 502": ["TRK 502 Standard", "TRK 502 X", "TRK 502 X Limited Edition"],
  "752S": ["752S STD"],

  //! honda
  "Activa 6G": [
    "Activa 6G STD",
    "Activa 6G DLX",
    "Activa 6G 25 Year Anniversary Edition",
    "Activa 6G H-Smart",
  ],
  "Activa 125": [
    "Activa 125 DLX",
    "Activa 125 25 Year Anniversary Edition",
    "Activa 125 H-Smart",
  ],
  "Dio": ["Dio STD", "Dio DLX"],
  "Grazia": ["Grazia Drum", "Grazia Disc", "Grazia Sports Edition"],

  //! bus
  //! volvo
  "Volvo 9400": ["9400 Seater"],
  "Volvo 9600": [
    "12.2m bi-axle seater variant",
    "13.5m bi-axle seater / sleeper variant",
    "15m tri-axle seater / sleeper variant",
  ],
  "Volvo 9700": [
    "9700S — 3.42 m height variant",
    "9700H — 3.61 m height",
    "9700HD — 3.73 m height",
  ],
  "B9R": ["Base B9R Seater (standard configuration)"],

  //! tata
  "Starbus": [
    "Starbus Prime 20+A+D LP 410/29",
    "Starbus Prime 25+A+D LP 410/33",
    "Starbus Prime 30+A+D LP 412/36",
    "Starbus Prime 34+A+D LP 412/36",
    "Starbus Prime 34+A+D AC 412/36",
    "Starbus Prime 38+A+D LP 412/36",
    "Starbus Prime 38+A+D AC 412/36",
    "Starbus Prime 46+A+D LP 712/45",
    "Starbus Prime 46+A+D AC 712/45",
    "Starbus Prime 51+A+D LP 812/52",
    "Starbus Ultra 44+D AC LPO 10.2/54",
    "Starbus Ultra 50+D LPO 10.2/54",
  ],
  "Ultra / Ultra Prime": [
    "Ultra 9/7",
    "Ultra 9/9 EV",
    "Ultra Prime 42+D AC LPO11.6/54",
    "Ultra Prime 50+D AC LPO11.6/54",
    "Ultra Prime 55+D LPO11.6/54",
    "Ultra Prime 44+D LPO11.6/54",
    "Ultra Prime 34+D LPO8.6/44",
  ],
  "CityRide": [
    "CityRide SKL 53+A+D LP712/45",
    "CityRide SKL 45+A+D LP712/45",
    "CityRide SKL 41+A+D LP412/36",
    "CityRide SKL 35+A+D LP412/36",
    "CityRide SKL 29+A+D LP412/36",
  ],
  "Magic Express": [
    "Magic Express 10 Seater / 2100 mm Wheel Base / 30 HP (Petrol)",
    "Magic Express Bi-Fuel (CNG/Petrol) 10 Seater / 1935 GVW",
  ],
  "Magic Mantra": ["Magic Mantra 6 Seater / 798 cc Diesel / 40 HP"],

  //! skoda
  'E’CITY': [
    'Rieju E-City 50',
    'Rieju E-City 125',
    'MAN Lion\'s City E',
    'Mercedes-Benz eCitaro',
    'Yutong E-Bus',
    'Peugeot eC01',
    'Peugeot eC02',
    'Peugeot eC03',
    'Peugeot eLEGEND',
    'Piaggio Ape E-City FX',
    'Piaggio Ape E-City FX Max',
  ],
  "H’CITY": ["H’CITY Base", "H’CITY Mid", "H’CITY Top"],
  "30Tr SOR": ["30Tr SOR Base", "30Tr SOR Premium"],
  "32Tr SOR": ["32Tr SOR Base", "32Tr SOR Premium"],
  "706 RTO": ["706 RTO Standard", "706 RTO Deluxe"],
  "706 RTO-K": ["706 RTO-K Standard", "706 RTO-K Deluxe"],

  //! ashoklayland
  "Viking": ["Viking Base", "Viking Premium"],
  "Cheetah": ["Cheetah Base", "Cheetah Premium"],
  "Sunshine School": ["Sunshine School Standard", "Sunshine School Deluxe"],
  "12m FE Intercity": [
    "12m FE Intercity Standard",
    "12m FE Intercity Comfort",
    "12m FE Intercity Luxury",
  ],
  "Mitr": ["Mitr Base", "Mitr Premium"],
  "Viking Stage Carrier": [
    "Viking Stage Carrier Standard",
    "Viking Stage Carrier Deluxe",
  ],

  //! force
  "Traveller School Bus": [
    "Traveller School Bus 3050",
    "Traveller School Bus 3350",
    "Traveller School Bus 4020",
  ],
  "Traveller Ambulance": [
    "Traveller Ambulance Type B",
    "Traveller Ambulance Type C",
  ],
  "Traveller Delivery Van": [
    "Traveller Delivery Van Standard",
    "Traveller Delivery Van High Roof",
  ],
  "Trax Toofan": ["Trax Toofan Deluxe", "Trax Toofan Premium"],
  "Citiline": ["Citiline Standard", "Citiline Deluxe"],
  "Trax Ambulance": ["Trax Ambulance Type B", "Trax Ambulance Type C"],
  "Trax Crew Van": ["Trax Crew Van Standard", "Trax Crew Van Deluxe"],
  "e-Traveller Smart Citibus": [
    "e-Traveller Smart Citibus Standard",
    "e-Traveller Smart Citibus Premium",
  ],

  //! altas
  "Altas Speedster": [
    "Speedster Standard",
    "Speedster Deluxe",
    "Speedster Premium",
  ],
  "Altas Ranger": ["Ranger Base", "Ranger Mid", "Ranger Off-Road"],
  "Atlas Ultimate City": [
    "Ultimate City Low Floor",
    "Ultimate City Standard",
    "Ultimate City Premium",
  ],
  "Atlas Smash": ["Smash Base", "Smash Sport", "Smash Adventure"],
  "Atlas Snippy": ["Snippy City", "Snippy School", "Snippy Shuttle"],

  //! avon
  "Avon Rider": ["Avon Rider Base", "Avon Rider Deluxe", "Avon Rider Sport"],
  "Avon Comet": ["Avon Comet Standard", "Avon Comet Plus", "Avon Comet Pro"],
  "Avon Cycles Sherry": ["Sherry Basic", "Sherry Comfort", "Sherry Adventure"],
  "Avon E-Bike": ["E-Bike City", "E-Bike Mountain", "E-Bike Cargo"],

  //! hero
  "Hero Sprint": [
    "Sprint Muve 26T",
    "Sprint X-Factor 26T",
    "Sprint Hustle",
    "Sprint Ignitor",
    "Sprint Riot 26T",
  ],

  "Hero Racer": ["Racer Base", "Racer Sport", "Racer 26T"],

  "Hero Miss India": ["Miss India Classic", "Miss India Deluxe"],

  "Hero Lectro (E-Cycle)": [
    "Y3",
    "Y5",
    "H3+",
    "H4+",
    "H5",
    "V24",
    "C1",
    "C5x",
    "F1",
  ],

  //! heavyvehicles
  //! ashok layland
  "AVTR 2820": [
    "CAB/3900",
    "CAB/4600",
    "3900/14m3 Box & Rock",
    "3900/16m3 Box",
    "3900/18m3 Box",
    "3900/20m3 Box",
    "4600/20m3 Box",
    "Cabin & Chassis",
    "Cowl with Chassis",
  ],

  "AVTR 3520": [
    "3520 Standard Body",
    "3520 High Side Deck",
    "3520 Flat Deck",
    "3520 Cabin & Chassis",
  ],

  "AVTR 2825": ["2825 Box Body", "2825 Rock Body", "2825 Cabin & Chassis"],

  "AVTR 4220": ["4220 10x4", "4220 General Carrier", "4220 High Capacity Body"],

  "AVTR 4825": ["4825 Box Body", "4825 Tip Body", "4825 Cabin & Chassis"],

  "1920": ["1920 Standard", "1920 Cabin & Chassis"],

  "2820": ["2820 General", "2820 High Payload"],

  "3520": ["3520 Standard", "3520 Heavy Duty"],

  "4020": ["4020 Standard", "4020 Multi-Axle"],

  "4220 10x2": ["4220 10x2 Box", "4220 10x2 Flat Deck"],

  "4825 10x2": ["4825 10x2 Box", "4825 10x2 Cabin & Chassis"],

  //!bugatti
  "Bugatti Truck Model": [
    "Bugatti Truck Model Standard",
    "Bugatti Truck Model Deluxe",
    "Bugatti Truck Model Heavy Duty",
  ],
  //! force
  "Force Urbania": [
    "3350WB 10-Seater",
    "3350WB 11-Seater",
    "3615WB 10-Seater",
    "3615WB 13-Seater",
    "3615WB 14-Seater",
    "4400WB 13-Seater",
    "4400WB 14-Seater",
    "4400WB 17-Seater",
  ],

  "Trax": [
    "Trax Cruiser",
    "Trax Toofan",
    "Citiline",
    "Trax Cruiser School Van",
    "Trax Ambulance",
    "Trax Delivery Van",
    "Trax Crew Van",
  ],

  "Force Heavy": [
    "Force Heavy Standard",
    "Force Heavy High Payload",
    "Force Heavy 8x2",
    "Force Heavy Long Wheelbase",
  ],

  //! jaguar heavy
  "Jaguar Heavy": [
    "Jaguar Heavy Standard",
    "Jaguar Heavy Long Wheelbase",
    "Jaguar Heavy High Payload",
    "Jaguar Heavy Tip Body",
    "Jaguar Heavy Truck Chassis",
  ],

  //! renaylt heavy
  "Renault Heavy": [
    "Renault Trucks T (Long Haul) 18-26 t GVW",
    "Renault Trucks T High 440 / 480 / 520 hp",
    "Renault Trucks C (Construction Range)",
    "Renault Trucks K (Construction Heavy-Duty)",
    "Renault Trucks T Smart Racer",
    "Renault Heavy Standard",
    "Renault Heavy High Capacity",
    "Renault Heavy Long Wheelbase",
    "Renault Heavy 6×4",
    "Renault Heavy 8×4",
  ],

  //!tata
  "Ace": [
    "Ace Gold Diesel",
    "Ace Gold Diesel Plus",
    "Ace Gold Petrol",
    "Ace Gold Petrol CX",
    "Ace EV",
    "Ace Pro EV",
    "Ace CNG",
    "Ace Bi-Fuel",
    "Ace Gold",
    "Ace Gold Diesel",
    "Ace Gold Diesel Plus",
    "Ace Gold Petrol",
    "Ace Gold Petrol CX",
    "Ace HT Plus",
    "Ace Gold CNG",
    "Ace Gold CNG Plus",
    "Ace EV",
    "Ace EV 1000",
    "Ace Pro EV",
    "Ace Pro Petrol",
    "Ace Pro Bi-Fuel",
  ],



  "407": ["407 Standard", "407 Heavy Duty", "407 LPT Version"],

  "709": ["709 Base", "709 Deluxe", "709 Rigid"],

  "LPK": ["LPK Standard", "LPK Long Chassis", "LPK Special Body"],

  //! volvo
    "FH": [
    "FH 520 Puller 6×4",
    "FH 420 4×2",
    "FH Aero",
    "FH Electric",
    "FH Gas"
  ],

  "FH16": [
    "FH16 Aero",
    "FH16 Heavy Haulage",
    "FH16 Sleeper Cab",
    "FH16 High Roof"
  ],

  "FM": [
    "FM 420 4×2 Tractor",
    "FM 500 Puller 6×4",
    "FM LPG / LNG Variant (if available)",
    "FM Day Cab",
    "FM Sleeper Cab"
  ],

  "FMX": [
    "FMX 440 8×4 Tipper",
    "FMX 500 Off-Road",
    "FMX Heavy Duty Rigid",
    "FMX Construction Variant"
  ],

  "FL": [
    "FL 250 / similar mid-duty",
    "FL 280 Standard",
    "FL City Distribution",
    "FL Electric / Alternative Power (if available)"
  ],

  "FE": [
    "FE 220 4×2",
    "FE City / Garbage / Sweep Variant",
    "FE ERG / Environmental spec",
    "FE Electric / CNG combo"
  ],

};
