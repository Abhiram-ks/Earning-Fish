import 'package:earningfish/features/presentation/bloc/pdi_bloc/pdi_bloc.dart';
import 'package:earningfish/features/presentation/widgets/pdi_widget/pdi_rediobutton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WheelsInspectionTab extends StatefulWidget {
  const WheelsInspectionTab({super.key});

  @override
  State<WheelsInspectionTab> createState() => _WheelsInspectionTabState();
}

class _WheelsInspectionTabState extends State<WheelsInspectionTab> {
  final _tyrePressureRemarkController = TextEditingController();
  final _tyreFitmentRemarkController = TextEditingController();
  final _spareWheelUnlockingRemarkController = TextEditingController();
  final _toolsAvailabilityRemarkController = TextEditingController();
  final _tailGateOperationRemarkController = TextEditingController();
  final _hsrpAvailabilityRemarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<PDIBloc>();
    final data = bloc.currentData;

    _tyrePressureRemarkController.text = data.tyrePressureRemark ?? '';
    _tyreFitmentRemarkController.text = data.tyreFitmentRemark ?? '';
    _spareWheelUnlockingRemarkController.text = data.spareWheelUnlockingRemark ?? '';
    _toolsAvailabilityRemarkController.text = data.toolsAvailabilityRemark ?? '';
    _tailGateOperationRemarkController.text = data.tailGateOperationRemark ?? '';
    _hsrpAvailabilityRemarkController.text = data.hsrpAvailabilityRemark ?? '';

    _tyrePressureRemarkController.addListener(_updateWheelsData);
    _tyreFitmentRemarkController.addListener(_updateWheelsData);
    _spareWheelUnlockingRemarkController.addListener(_updateWheelsData);
    _toolsAvailabilityRemarkController.addListener(_updateWheelsData);
    _tailGateOperationRemarkController.addListener(_updateWheelsData);
    _hsrpAvailabilityRemarkController.addListener(_updateWheelsData);
  }

  void _updateWheelsData() {
    final bloc = context.read<PDIBloc>();
    final data = bloc.currentData;

    bloc.add(UpdateWheelsInspectionEvent(
      tyrePressure: data.tyrePressure,
      tyrePressureRemark: _tyrePressureRemarkController.text,
      tyreFitment: data.tyreFitment,
      tyreFitmentRemark: _tyreFitmentRemarkController.text,
      spareWheelUnlocking: data.spareWheelUnlocking,
      spareWheelUnlockingRemark: _spareWheelUnlockingRemarkController.text,
      toolsAvailability: data.toolsAvailability,
      toolsAvailabilityRemark: _toolsAvailabilityRemarkController.text,
      tailGateOperation: data.tailGateOperation,
      tailGateOperationRemark: _tailGateOperationRemarkController.text,
      hsrpAvailability: data.hsrpAvailability,
      hsrpAvailabilityRemark: _hsrpAvailabilityRemarkController.text,
    ));
  }

  void _updateWheelsField({
    bool? tyrePressure,
    bool? tyreFitment,
    bool? spareWheelUnlocking,
    bool? toolsAvailability,
    bool? tailGateOperation,
    bool? hsrpAvailability,
  }) {
    final bloc = context.read<PDIBloc>();
    final data = bloc.currentData;

    bloc.add(UpdateWheelsInspectionEvent(
      tyrePressure: tyrePressure ?? data.tyrePressure,
      tyrePressureRemark: _tyrePressureRemarkController.text,
      tyreFitment: tyreFitment ?? data.tyreFitment,
      tyreFitmentRemark: _tyreFitmentRemarkController.text,
      spareWheelUnlocking: spareWheelUnlocking ?? data.spareWheelUnlocking,
      spareWheelUnlockingRemark: _spareWheelUnlockingRemarkController.text,
      toolsAvailability: toolsAvailability ?? data.toolsAvailability,
      toolsAvailabilityRemark: _toolsAvailabilityRemarkController.text,
      tailGateOperation: tailGateOperation ?? data.tailGateOperation,
      tailGateOperationRemark: _tailGateOperationRemarkController.text,
      hsrpAvailability: hsrpAvailability ?? data.hsrpAvailability,
      hsrpAvailabilityRemark: _hsrpAvailabilityRemarkController.text,
    ));
  }

  @override
  void dispose() {
    _tyrePressureRemarkController.dispose();
    _tyreFitmentRemarkController.dispose();
    _spareWheelUnlockingRemarkController.dispose();
    _toolsAvailabilityRemarkController.dispose();
    _tailGateOperationRemarkController.dispose();
    _hsrpAvailabilityRemarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PDIBloc, PDIState>(
      builder: (context, state) {
        final bloc = context.read<PDIBloc>();
        final data = bloc.currentData;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                'WHEELS, TYRES & BOOT',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              buildRadioTile(
                title: 'Check pressure in all tyres (including spare wheel) as recommended on the label',
                value: data.tyrePressure,
                remarkController: _tyrePressureRemarkController,
                onChanged: (value) => _updateWheelsField(tyrePressure: value),
              ),
              buildRadioTile(
                title: 'Check size/fitment of tyres as per vehicle specifications',
                value: data.tyreFitment,
                remarkController: _tyreFitmentRemarkController,
                onChanged: (value) => _updateWheelsField(tyreFitment: value),
              ),
              buildRadioTile(
                title: 'Check spare wheel unlocking',
                value: data.spareWheelUnlocking,
                remarkController: _spareWheelUnlockingRemarkController,
                onChanged: (value) => _updateWheelsField(spareWheelUnlocking: value),
              ),
              buildRadioTile(
                title: 'Check Jack, Handle, Spanner, Reflector availability',
                value: data.toolsAvailability,
                remarkController: _toolsAvailabilityRemarkController,
                onChanged: (value) => _updateWheelsField(toolsAvailability: value),
              ),
              buildRadioTile(
                title: 'Check electric tail gate closing operation',
                value: data.tailGateOperation,
                remarkController: _tailGateOperationRemarkController,
                onChanged: (value) => _updateWheelsField(tailGateOperation: value),
              ),
              buildRadioTile(
                title: 'Availability of HSRP (High Security Registration Plate)',
                value: data.hsrpAvailability,
                remarkController: _hsrpAvailabilityRemarkController,
                onChanged: (value) => _updateWheelsField(hsrpAvailability: value),
              ),
            ],
          ),
        );
      },
    );
  }
}
