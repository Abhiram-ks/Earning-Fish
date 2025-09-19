import 'package:earningfish/features/data/datasource/auth_local_datasource.dart';
import 'package:earningfish/features/data/datasource/auth_remote_datasource.dart';
import 'package:earningfish/features/data/repo/auth_repo_impl.dart';
import 'package:earningfish/features/domain/usecase/auth_usecase.dart';
import 'package:earningfish/features/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:earningfish/features/presentation/bloc/progresser_cubit/progresser_cubit.dart';
import 'package:earningfish/features/presentation/widgets/login_widget/login_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProgresserCubit()),
        BlocProvider(create: (context) => LoginBloc(useCase: AuthUseCase(AuthRepositoryImpl(remoteDS: FirebaseAuthRemoteDatasource(), localDS: AuthLocalDatasource())))),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 245, 245, 245),
            resizeToAvoidBottomInset: false,
            body: LoginBodyWidget(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
          );
        },
      ),
    );
  }
}
