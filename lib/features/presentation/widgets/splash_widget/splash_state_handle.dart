
import 'package:earningfish/core/routes/app_routes.dart';
import 'package:earningfish/features/presentation/bloc/splash_bloc/splash_bloc.dart';
import 'package:flutter/material.dart';

void splashStateHandle(BuildContext context, SplashState state) {
  if (state is SplashBlocGoToLogin) {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }else if (state is SplashBlocGoToDashBord){
   Navigator.pushReplacementNamed(context, AppRoutes.dashbord);
  }
}
