
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
      'modelName',
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
      'modelName': data.modelName,
      'modelVariant': data.modelVariant,
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
    context.read<PDIBloc>().add(UpdateInitialDetailsEvent(
      modelName: _controllers['modelName']?.text,
      modelVariant: _controllers['modelVariant']?.text,
      chassisNo: _controllers['chassisNo']?.text,
      engineNo: _controllers['engineNo']?.text,
      keyNo: _controllers['keyNo']?.text,
      batteryMake: _controllers['batteryMake']?.text,
      batterySerialNo: _controllers['batterySerialNo']?.text,
      dateOfReceipt: _controllers['dateOfReceipt']?.text,
      pdiKms: _controllers['pdiKms']?.text,
      bodyShade: _controllers['bodyShade']?.text,
    ));
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
                buildTextField('Model Name', 'modelName',_controllers),
                buildTextField('Model Variant', 'modelVariant',_controllers),
                buildTextField('Chassis No.', 'chassisNo',_controllers),
                buildTextField('Engine No.', 'engineNo',_controllers),
                buildTextField('Key No.', 'keyNo',_controllers),
                buildTextField('Battery Make', 'batteryMake',_controllers),
                buildTextField('Battery Serial No.', 'batterySerialNo',_controllers),
                buildDateField('Date of Receipt in Yard', 'dateOfReceipt',_controllers,context),
                buildTextField('PDI KMS', 'pdiKms',_controllers),
                buildTextField('Body Shade', 'bodyShade',_controllers),
              ],
            ),
          ),
        );
      },
    );
  }
}