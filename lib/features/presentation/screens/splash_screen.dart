import 'package:earningfish/features/data/datasource/auth_local_datasource.dart';
import 'package:earningfish/features/presentation/bloc/splash_bloc/splash_bloc.dart';
import 'package:earningfish/features/presentation/widgets/splash_widget/splash_body_widget.dart';
import 'package:earningfish/features/presentation/widgets/splash_widget/splash_state_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(local: AuthLocalDatasource())..add(SplashEventRequest()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, splashState) {
         splashStateHandle(context, splashState);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

            return Scaffold(
              body: SplashScreenBody(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            );
          },
        ),
      ),
    );
  }
}
