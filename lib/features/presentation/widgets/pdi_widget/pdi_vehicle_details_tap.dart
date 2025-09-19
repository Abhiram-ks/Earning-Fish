
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
  bool _controllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _dateController.addListener(_updateData);
    _controllerInitialized = true;
  }

  void _updateDateController(String date) {
    if (!_controllerInitialized) return;
    if (_dateController.text != date) {
      _dateController.text = date;
    }
  }

  void _updateData() {
    final bloc = context.read<PDIBloc>();
    bloc.add(UpdateVehicleDetailsEvent(
      dateOfInspection: _dateController.text,
      tyreFrtRh: bloc.currentData.tyreFrtRh,
      tyreFrtLh: bloc.currentData.tyreFrtLh,
      tyreRrRh: bloc.currentData.tyreRrRh,
      tyreRrLh: bloc.currentData.tyreRrLh,
      spareWheel: bloc.currentData.spareWheel,
    ));
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PDIBloc, PDIState>(
      builder: (context, state) {
        final bloc = context.read<PDIBloc>();
        final data = bloc.currentData;
        _updateDateController(data.dateOfInspection);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date of Inspection',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.blue.shade700,
                            onPrimary: Colors.white,
                            surface: Colors.white,
                            onSurface: Colors.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
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
              buildRadioTile('Tyres - FRT RH', data.tyreFrtRh, (value) {
                bloc.add(UpdateVehicleDetailsEvent(
                  dateOfInspection: data.dateOfInspection,
                  tyreFrtRh: value,
                  tyreFrtLh: data.tyreFrtLh,
                  tyreRrRh: data.tyreRrRh,
                  tyreRrLh: data.tyreRrLh,
                  spareWheel: data.spareWheel,
                ));
              }),
              buildRadioTile('Tyres - FRT LH', data.tyreFrtLh, (value) {
                bloc.add(UpdateVehicleDetailsEvent(
                  dateOfInspection: data.dateOfInspection,
                  tyreFrtRh: data.tyreFrtRh,
                  tyreFrtLh: value,
                  tyreRrRh: data.tyreRrRh,
                  tyreRrLh: data.tyreRrLh,
                  spareWheel: data.spareWheel,
                ));
              }),
              buildRadioTile('Tyres - RR RH', data.tyreRrRh, (value) {
                bloc.add(UpdateVehicleDetailsEvent(
                  dateOfInspection: data.dateOfInspection,
                  tyreFrtRh: data.tyreFrtRh,
                  tyreFrtLh: data.tyreFrtLh,
                  tyreRrRh: value,
                  tyreRrLh: data.tyreRrLh,
                  spareWheel: data.spareWheel,
                ));
              }),
              buildRadioTile('Tyres - RR LH', data.tyreRrLh, (value) {
                bloc.add(UpdateVehicleDetailsEvent(
                  dateOfInspection: data.dateOfInspection,
                  tyreFrtRh: data.tyreFrtRh,
                  tyreFrtLh: data.tyreFrtLh,
                  tyreRrRh: data.tyreRrRh,
                  tyreRrLh: value,
                  spareWheel: data.spareWheel,
                ));
              }),
              buildRadioTile('Spare Wheel', data.spareWheel, (value) {
                bloc.add(UpdateVehicleDetailsEvent(
                  dateOfInspection: data.dateOfInspection,
                  tyreFrtRh: data.tyreFrtRh,
                  tyreFrtLh: data.tyreFrtLh,
                  tyreRrRh: data.tyreRrRh,
                  tyreRrLh: data.tyreRrLh,
                  spareWheel: value,
                ));
              }),
            ],
          ),
        );
      },
    );
  }

 
}
