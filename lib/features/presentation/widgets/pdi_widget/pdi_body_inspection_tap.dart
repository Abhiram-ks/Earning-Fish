import 'package:earningfish/features/presentation/bloc/pdi_bloc/pdi_bloc.dart';
import 'package:earningfish/features/presentation/widgets/pdi_widget/pdi_rediobutton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyInspectionTab extends StatefulWidget {
  const BodyInspectionTab({super.key});

  @override
  State<BodyInspectionTab> createState() => _BodyInspectionTabState();
}

class _BodyInspectionTabState extends State<BodyInspectionTab> {
  final _bodyPaintRemarkController = TextEditingController();
  final _dentsDefectsRemarkController = TextEditingController();
  final _doorsAlignmentRemarkController = TextEditingController();
  final _doorsNoiseRemarkController = TextEditingController();
  final _tailGateNoiseRemarkController = TextEditingController();
  final _remoteOperationRemarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<PDIBloc>();
    final data = bloc.currentData;

    _bodyPaintRemarkController.text = data.bodyPaintRemark ?? '';
    _dentsDefectsRemarkController.text = data.dentsDefectsRemark ?? '';
    _doorsAlignmentRemarkController.text = data.doorsAlignmentRemark ?? '';
    _doorsNoiseRemarkController.text = data.doorsNoiseRemark ?? '';
   _tailGateNoiseRemarkController.text = data.tailGateNoiseRemark ?? '';
    _remoteOperationRemarkController.text = data.remoteOperationRemark ?? '';

    _bodyPaintRemarkController.addListener(_updateBodyData);
    _dentsDefectsRemarkController.addListener(_updateBodyData);
    _doorsAlignmentRemarkController.addListener(_updateBodyData);
    _doorsNoiseRemarkController.addListener(_updateBodyData);
    _tailGateNoiseRemarkController.addListener(_updateBodyData);
    _remoteOperationRemarkController.addListener(_updateBodyData);
  }

  void _updateBodyData() {
    final bloc = context.read<PDIBloc>();

    bloc.add(UpdateBodyInspectionEvent(
      bodyPaintCondition: bloc.currentData.bodyPaintCondition,
      bodyPaintRemark: _bodyPaintRemarkController.text,
      dentsDefects: bloc.currentData.dentsDefects,
      dentsDefectsRemark: _dentsDefectsRemarkController.text,
      doorsAlignment: bloc.currentData.doorsAlignment,
      doorsAlignmentRemark: _doorsAlignmentRemarkController.text,
      doorsNoise: bloc.currentData.doorsNoise,
      doorsNoiseRemark: _doorsNoiseRemarkController.text,
      tailGateNoise:bloc.currentData.tailGateNoise,
      tailGateNoiseRemark: _tailGateNoiseRemarkController.text,
      remoteOperation: bloc.currentData.remoteOperation,
      remoteOperationRemark: _remoteOperationRemarkController.text,
    ));
  }

  @override
  void dispose() {
    _bodyPaintRemarkController.dispose();
    _dentsDefectsRemarkController.dispose();
    _doorsAlignmentRemarkController.dispose();
    _doorsNoiseRemarkController.dispose();
    _tailGateNoiseRemarkController.dispose();
    _remoteOperationRemarkController.dispose();
    super.dispose();
  }

  void _updateBodyField({bool? bodyPaint, bool? dents, bool? doorsAlign, bool? doorsNoise, bool? tailGate, bool? remoteOp}) {
    final bloc = context.read<PDIBloc>();
    final data = bloc.currentData;

    bloc.add(UpdateBodyInspectionEvent(
      bodyPaintCondition: bodyPaint ?? data.bodyPaintCondition,
      bodyPaintRemark: _bodyPaintRemarkController.text,
      dentsDefects: dents ?? data.dentsDefects,
      dentsDefectsRemark: _dentsDefectsRemarkController.text,
      doorsAlignment: doorsAlign ?? data.doorsAlignment,
      doorsAlignmentRemark: _doorsAlignmentRemarkController.text,
      doorsNoise: doorsNoise ?? data.doorsNoise,
      doorsNoiseRemark: _doorsNoiseRemarkController.text,
      tailGateNoise: tailGate ?? data.tailGateNoise,
      tailGateNoiseRemark: _tailGateNoiseRemarkController.text,
      remoteOperation: remoteOp ?? data.remoteOperation,
      remoteOperationRemark: _remoteOperationRemarkController.text,
    ));
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
                'BODY (OUTSIDE INSPECTION)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              buildRadioTile(
                title: 'Check overall Body and Paint condition *',
                value: data.bodyPaintCondition,
                remarkController: _bodyPaintRemarkController,
                onChanged: (value) => _updateBodyField(bodyPaint: value),
              ),

              buildRadioTile(
                title: 'Check for Dents and other defects in body parts *',
                value: data.dentsDefects,
                remarkController: _dentsDefectsRemarkController,
                onChanged: (value) => _updateBodyField(dents: value),
              ),

              buildRadioTile(
                title: 'Check Doors and Bonnet alignment *',
                value: data.doorsAlignment,
                remarkController: _doorsAlignmentRemarkController,
                onChanged: (value) => _updateBodyField(doorsAlign: value),
              ),

              buildRadioTile(
                title: 'Check opening and closing of all doors for Noise/Rattling noise *',
                value: data.doorsNoise,
                remarkController: _doorsNoiseRemarkController,
                onChanged: (value) => _updateBodyField(doorsNoise: value),
              ),

              buildRadioTile(
                title: 'Check opening and closing of Tail Gate for Noise/Rattling noise *',
                value: data.tailGateNoise,
                remarkController: _tailGateNoiseRemarkController,
                onChanged: (value) => _updateBodyField(tailGate: value),
              ),

              buildRadioTile(
                title: 'Check operation of remote and vehicle security system (Lock/Unlock) *',
                value: data.remoteOperation,
                remarkController: _remoteOperationRemarkController,
                onChanged: (value) => _updateBodyField(remoteOp: value),
              ),
            ],
          ),
        );
      },
    );
  }
}
