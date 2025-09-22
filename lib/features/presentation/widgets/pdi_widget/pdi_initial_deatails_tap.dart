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
                  hint: Text("Select Model Variant"),
                  dropdownColor: Color(0xFFEAF4F4),
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
                  items:
                      variants
                          .map(
                            (variant) => DropdownMenuItem(
                              value: variant,
                              child: Text(variant),
                            ),
                          )
                          .toList(),
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
  'Leoncino 500': ['Leoncino 500 Standard', 'Leoncino 500 Special'],
  'TRK 502': ['TRK 502 X', 'TRK 502 S'],
  'COMET EV': [
    'Executive',
    'Excite',
    'Excite FC',
    'Exclusive',
    'Exclusive FC',
    'Blackstorm Edition',
  ],
  'Windsor EV': [
    'Excite',
    'Exclusive',
    'Essence',
    'Exclusive Pro',
    'Essence Pro',
  ],
};
