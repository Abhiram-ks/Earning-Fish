import 'package:earningfish/core/common/custom_snackbar.dart';
import 'package:earningfish/core/routes/app_routes.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:earningfish/features/presentation/bloc/progresser_cubit/progresser_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void loginStateHandle(BuildContext context, LoginState state) {
  final button = context.read<ProgresserCubit>();
  if (state is LoginLoading) {
   button.startLoading();
  }else if (state is LoginSuccess){
    button.stopLoading();
    Navigator.pushReplacementNamed(context, AppRoutes.dashbord);
  }else if (state is LoginFailure){
    button.stopLoading();
     CustomSnackBar.show(context, message: state.message ,backgroundColor: AppPalette.redColor,textAlign: TextAlign.center);
  }
}
