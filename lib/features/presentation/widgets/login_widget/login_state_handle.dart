import 'package:earningfish/core/common/custom_snackbar.dart';
import 'package:earningfish/core/routes/app_routes.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/presentation/bloc/googlesign_bloc/googlesing_bloc.dart';
import 'package:earningfish/features/presentation/bloc/progresser_cubit/progresser_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void loginStatehandle(BuildContext context, GooglesignState state) {
  final progresser = context.read<ProgresserCubit>();
  if (state is GooglesingFailure) {
    progresser.stopLoading();
    CustomSnackBar.show(
      context,
      message: 'Login Failure! ${state.message}',
      backgroundColor: AppPalette.redColor,
      textAlign: TextAlign.center,
      durationSeconds: 4,
    );
  } else if (state is GooglesingSuccess) {
    progresser.stopLoading();
    Navigator.pushReplacementNamed(context, AppRoutes.dashbord);
  } else if (state is GooglesingLoading) {
    progresser.startLoading();
  }
}

