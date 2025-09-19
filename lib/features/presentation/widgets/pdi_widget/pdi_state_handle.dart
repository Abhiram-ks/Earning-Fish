import 'package:earningfish/core/common/custom_snackbar.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/presentation/bloc/pdi_bloc/pdi_bloc.dart';
import 'package:earningfish/features/presentation/bloc/progresser_cubit/progresser_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void pdiStateHandle(BuildContext context, PDIState state) {
  final button = context.read<ProgresserCubit>();
  if (state is PDiLoaidngState) {
    button.startLoading();
  } else if (state is PDiSuccessState) {
    button.stopLoading();
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    CustomSnackBar.show(
      context,
      message: "Your PDI has been successfully created!",
      backgroundColor: AppPalette.greenColor,
      textAlign: TextAlign.center,
    );
  } else if (state is PDiFailureState) {
    button.stopLoading();
    CustomSnackBar.show(
      context,
      message: state.message,
      backgroundColor: AppPalette.redColor,
      textAlign: TextAlign.center,
    );
  }
}
