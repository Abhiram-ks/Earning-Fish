import 'package:earningfish/features/presentation/bloc/pdi_bloc/pdi_bloc.dart';
import 'package:earningfish/features/presentation/widgets/pdi_widget/pdi_rediobutton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyInspectionTab extends StatelessWidget {
  const BodyInspectionTab({super.key});

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
                'BODY (OUTSIDE INSPECTION)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              buildRadioTile(
                'Check overall Body and Paint condition',
                data.bodyPaintCondition,
                (value) => bloc.add(UpdateBodyInspectionEvent(
                  bodyPaintCondition: value,
                  dentsDefects: data.dentsDefects,
                  doorsAlignment: data.doorsAlignment,
                  doorsNoise: data.doorsNoise,
                  tailGateNoise: data.tailGateNoise,
                  remoteOperation: data.remoteOperation,
                )),
              ),
              buildRadioTile(
                'Check for Dents and other defects in body parts',
                data.dentsDefects,
                (value) => bloc.add(UpdateBodyInspectionEvent(
                  bodyPaintCondition: data.bodyPaintCondition,
                  dentsDefects: value,
                  doorsAlignment: data.doorsAlignment,
                  doorsNoise: data.doorsNoise,
                  tailGateNoise: data.tailGateNoise,
                  remoteOperation: data.remoteOperation,
                )),
              ),
              buildRadioTile(
                'Check Doors and Bonnet alignment',
                data.doorsAlignment,
                (value) => bloc.add(UpdateBodyInspectionEvent(
                  bodyPaintCondition: data.bodyPaintCondition,
                  dentsDefects: data.dentsDefects,
                  doorsAlignment: value,
                  doorsNoise: data.doorsNoise,
                  tailGateNoise: data.tailGateNoise,
                  remoteOperation: data.remoteOperation,
                )),
              ),
              buildRadioTile(
                'Check opening and closing of all doors for Noise/Rattling noise',
                data.doorsNoise,
                (value) => bloc.add(UpdateBodyInspectionEvent(
                  bodyPaintCondition: data.bodyPaintCondition,
                  dentsDefects: data.dentsDefects,
                  doorsAlignment: data.doorsAlignment,
                  doorsNoise: value,
                  tailGateNoise: data.tailGateNoise,
                  remoteOperation: data.remoteOperation,
                )),
              ),
              buildRadioTile(
                'Check opening and closing of Tail Gate for Noise/Rattling noise',
                data.tailGateNoise,
                (value) => bloc.add(UpdateBodyInspectionEvent(
                  bodyPaintCondition: data.bodyPaintCondition,
                  dentsDefects: data.dentsDefects,
                  doorsAlignment: data.doorsAlignment,
                  doorsNoise: data.doorsNoise,
                  tailGateNoise: value,
                  remoteOperation: data.remoteOperation,
                )),
              ),
              buildRadioTile(
                'Check operation of remote and vehicle security system (Lock/Unlock)',
                data.remoteOperation,
                (value) => bloc.add(UpdateBodyInspectionEvent(
                  bodyPaintCondition: data.bodyPaintCondition,
                  dentsDefects: data.dentsDefects,
                  doorsAlignment: data.doorsAlignment,
                  doorsNoise: data.doorsNoise,
                  tailGateNoise: data.tailGateNoise,
                  remoteOperation: value,
                )),
              ),
            ],
          ),
        );
      },
    );
  }
}