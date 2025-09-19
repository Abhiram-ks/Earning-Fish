import 'package:earningfish/features/presentation/bloc/pdi_bloc/pdi_bloc.dart';
import 'package:earningfish/features/presentation/widgets/pdi_widget/pdi_rediobutton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WheelsInspectionTab extends StatelessWidget {
  const WheelsInspectionTab({super.key});

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
                'WHEELS TYRES & BOOT',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              buildRadioTile(
                'Check pressure in all tyres (including spare wheel) as recommended on the label',
                data.tyrePressure,
                (value) => bloc.add(UpdateWheelsInspectionEvent(
                  tyrePressure: value,
                  tyreFitment: data.tyreFitment,
                  spareWheelUnlocking: data.spareWheelUnlocking,
                  toolsAvailability: data.toolsAvailability,
                  tailGateOperation: data.tailGateOperation,
                  hsrpAvailability: data.hsrpAvailability,
                )),
              ),
              buildRadioTile(
                'Check size/fitment of tyres as per vehicle specifications',
                data.tyreFitment,
                (value) => bloc.add(UpdateWheelsInspectionEvent(
                  tyrePressure: data.tyrePressure,
                  tyreFitment: value,
                  spareWheelUnlocking: data.spareWheelUnlocking,
                  toolsAvailability: data.toolsAvailability,
                  tailGateOperation: data.tailGateOperation,
                  hsrpAvailability: data.hsrpAvailability,
                )),
              ),
              buildRadioTile(
                'Check spare wheel unlocking',
                data.spareWheelUnlocking,
                (value) => bloc.add(UpdateWheelsInspectionEvent(
                  tyrePressure: data.tyrePressure,
                  tyreFitment: data.tyreFitment,
                  spareWheelUnlocking: value,
                  toolsAvailability: data.toolsAvailability,
                  tailGateOperation: data.tailGateOperation,
                  hsrpAvailability: data.hsrpAvailability,
                )),
              ),
              buildRadioTile(
                'Check Jack, Handle, Spanner, Reflector availability',
                data.toolsAvailability,
                (value) => bloc.add(UpdateWheelsInspectionEvent(
                  tyrePressure: data.tyrePressure,
                  tyreFitment: data.tyreFitment,
                  spareWheelUnlocking: data.spareWheelUnlocking,
                  toolsAvailability: value,
                  tailGateOperation: data.tailGateOperation,
                  hsrpAvailability: data.hsrpAvailability,
                )),
              ),
              buildRadioTile(
                'Check electric tail gate closing operation',
                data.tailGateOperation,
                (value) => bloc.add(UpdateWheelsInspectionEvent(
                  tyrePressure: data.tyrePressure,
                  tyreFitment: data.tyreFitment,
                  spareWheelUnlocking: data.spareWheelUnlocking,
                  toolsAvailability: data.toolsAvailability,
                  tailGateOperation: value,
                  hsrpAvailability: data.hsrpAvailability,
                )),
              ),
              buildRadioTile(
                'Availability of HSRP (High Security Registration Plate)',
                data.hsrpAvailability,
                (value) => bloc.add(UpdateWheelsInspectionEvent(
                  tyrePressure: data.tyrePressure,
                  tyreFitment: data.tyreFitment,
                  spareWheelUnlocking: data.spareWheelUnlocking,
                  toolsAvailability: data.toolsAvailability,
                  tailGateOperation: data.tailGateOperation,
                  hsrpAvailability: value,
                )),
              ),
            ],
          ),
        );
      },
    );
  }
}