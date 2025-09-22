import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/presentation/bloc/pdi_bloc/pdi_bloc.dart';
import 'package:earningfish/features/presentation/widgets/pdi_widget/pdi_rediobutton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleDetailsTab extends StatefulWidget {
  const VehicleDetailsTab({super.key});

  @override
  State<VehicleDetailsTab> createState() => _VehicleDetailsTabState();
}

class _VehicleDetailsTabState extends State<VehicleDetailsTab> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _tyreFrtRhRemark = TextEditingController();
  final TextEditingController _tyreFrtLhRemark = TextEditingController();
  final TextEditingController _tyreRrRhRemark = TextEditingController();
  final TextEditingController _tyreRrLhRemark = TextEditingController();
  final TextEditingController _spareWheelRemark = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<PDIBloc>();
    final data = bloc.currentData;

    _dateController.text = data.dateOfInspection;
    _tyreFrtRhRemark.text = data.tyreFrtRhRemark ?? '';
    _tyreFrtLhRemark.text = data.tyreFrtLhRemark ?? '';
    _tyreRrRhRemark.text = data.tyreRrRhRemark ?? '';
    _tyreRrLhRemark.text = data.tyreRrLhRemark ?? '';
    _spareWheelRemark.text = data.spareWheelRemark ?? '';

    _dateController.addListener(_updateData);
    _tyreFrtRhRemark.addListener(_updateData);
    _tyreFrtLhRemark.addListener(_updateData);
    _tyreRrRhRemark.addListener(_updateData);
    _tyreRrLhRemark.addListener(_updateData);
    _spareWheelRemark.addListener(_updateData);
  }

  void _updateData() {
    final bloc = context.read<PDIBloc>();
    bloc.add(
      UpdateVehicleDetailsEvent(
        dateOfInspection: _dateController.text,
        tyreFrtRh: bloc.currentData.tyreFrtRh,
        tyreFrtRhRemark: _tyreFrtRhRemark.text,
        tyreFrtLh: bloc.currentData.tyreFrtLh,
        tyreFrtLhRemark: _tyreFrtLhRemark.text,
        tyreRrRh: bloc.currentData.tyreRrRh,
        tyreRrRhRemark: _tyreRrRhRemark.text,
        tyreRrLh: bloc.currentData.tyreRrLh,
        tyreRrLhRemark: _tyreRrLhRemark.text,
        spareWheel: bloc.currentData.spareWheel,
        spareWheelRemark: _spareWheelRemark.text,
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _tyreFrtRhRemark.dispose();
    _tyreFrtLhRemark.dispose();
    _tyreRrRhRemark.dispose();
    _tyreRrLhRemark.dispose();
    _spareWheelRemark.dispose();
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
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Date of Inspection',
                  labelStyle: TextStyle(color: AppPalette.greyColor),
                  filled: true,
                  fillColor: AppPalette.trasprentColor,
                  suffixIcon: const Icon(
                    Icons.calendar_month_sharp,
                    color: AppPalette.blackColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppPalette.hintColor,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppPalette.blueColor,
                      width: 1,
                    ),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    final formattedDate =
                        "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                    _dateController.text = formattedDate;
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Tyres Inspection',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              buildRadioTile(
                title: 'Tyres - FRT RH',
                value: data.tyreFrtRh,
                remarkController: _tyreFrtRhRemark,
                onChanged: (value) {
                  bloc.add(
                    UpdateVehicleDetailsEvent(
                      dateOfInspection: data.dateOfInspection,
                      tyreFrtRh: value,
                      tyreFrtRhRemark: _tyreFrtRhRemark.text,
                      tyreFrtLh: data.tyreFrtLh,
                      tyreFrtLhRemark: _tyreFrtLhRemark.text,
                      tyreRrRh: data.tyreRrRh,
                      tyreRrRhRemark: _tyreRrRhRemark.text,
                      tyreRrLh: data.tyreRrLh,
                      tyreRrLhRemark: _tyreRrLhRemark.text,
                      spareWheel: data.spareWheel,
                      spareWheelRemark: _spareWheelRemark.text,
                    ),
                  );
                },
              ),

              // Tyres - FRT LH
              buildRadioTile(
                title: 'Tyres - FRT LH',
                value: data.tyreFrtLh,
                remarkController: _tyreFrtLhRemark,
                onChanged: (value) {
                  bloc.add(
                    UpdateVehicleDetailsEvent(
                      dateOfInspection: data.dateOfInspection,
                      tyreFrtRh: data.tyreFrtRh,
                      tyreFrtRhRemark: _tyreFrtRhRemark.text,
                      tyreFrtLh: value,
                      tyreFrtLhRemark: _tyreFrtLhRemark.text,
                      tyreRrRh: data.tyreRrRh,
                      tyreRrRhRemark: _tyreRrRhRemark.text,
                      tyreRrLh: data.tyreRrLh,
                      tyreRrLhRemark: _tyreRrLhRemark.text,
                      spareWheel: data.spareWheel,
                      spareWheelRemark: _spareWheelRemark.text,
                    ),
                  );
                },
              ),

              // Tyres - RR RH
              buildRadioTile(
                title: 'Tyres - RR RH',
                value: data.tyreRrRh,
                remarkController: _tyreRrRhRemark,
                onChanged: (value) {
                  bloc.add(
                    UpdateVehicleDetailsEvent(
                      dateOfInspection: data.dateOfInspection,
                      tyreFrtRh: data.tyreFrtRh,
                      tyreFrtRhRemark: _tyreFrtRhRemark.text,
                      tyreFrtLh: data.tyreFrtLh,
                      tyreFrtLhRemark: _tyreFrtLhRemark.text,
                      tyreRrRh: value,
                      tyreRrRhRemark: _tyreRrRhRemark.text,
                      tyreRrLh: data.tyreRrLh,
                      tyreRrLhRemark: _tyreRrLhRemark.text,
                      spareWheel: data.spareWheel,
                      spareWheelRemark: _spareWheelRemark.text,
                    ),
                  );
                },
              ),

              // Tyres - RR LH
              buildRadioTile(
                title: 'Tyres - RR LH',
                value: data.tyreRrLh,
                remarkController: _tyreRrLhRemark,
                onChanged: (value) {
                  bloc.add(
                    UpdateVehicleDetailsEvent(
                      dateOfInspection: data.dateOfInspection,
                      tyreFrtRh: data.tyreFrtRh,
                      tyreFrtRhRemark: _tyreFrtRhRemark.text,
                      tyreFrtLh: data.tyreFrtLh,
                      tyreFrtLhRemark: _tyreFrtLhRemark.text,
                      tyreRrRh: data.tyreRrRh,
                      tyreRrRhRemark: _tyreRrRhRemark.text,
                      tyreRrLh: value,
                      tyreRrLhRemark: _tyreRrLhRemark.text,
                      spareWheel: data.spareWheel,
                      spareWheelRemark: _spareWheelRemark.text,
                    ),
                  );
                },
              ),

              // Spare Wheel
              buildRadioTile(
                title: 'Spare Wheel',
                value: data.spareWheel,
                remarkController: _spareWheelRemark,
                onChanged: (value) {
                  bloc.add(
                    UpdateVehicleDetailsEvent(
                      dateOfInspection: data.dateOfInspection,
                      tyreFrtRh: data.tyreFrtRh,
                      tyreFrtRhRemark: _tyreFrtRhRemark.text,
                      tyreFrtLh: data.tyreFrtLh,
                      tyreFrtLhRemark: _tyreFrtLhRemark.text,
                      tyreRrRh: data.tyreRrRh,
                      tyreRrRhRemark: _tyreRrRhRemark.text,
                      tyreRrLh: data.tyreRrLh,
                      tyreRrLhRemark: _tyreRrLhRemark.text,
                      spareWheel: value,
                      spareWheelRemark: _spareWheelRemark.text,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
