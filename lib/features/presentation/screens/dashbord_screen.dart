
import 'package:earningfish/core/routes/app_routes.dart';
import 'package:earningfish/features/data/datasource/auth_local_datasource.dart';
import 'package:earningfish/features/data/datasource/pdi_fech_remote_datasource.dart';
import 'package:earningfish/features/data/repo/fech_pdi_repo_impl.dart';
import 'package:earningfish/features/domain/repo/fetch_pdi_usecase.dart';
import 'package:earningfish/features/presentation/bloc/fetchpdi_bloc/fetchpdi_bloc.dart';
import 'package:earningfish/features/presentation/bloc/logout_bloc/logout_bloc.dart';
import 'package:earningfish/features/presentation/bloc/pdistatus_cubit/pdistatus_cubit.dart';
import 'package:earningfish/features/presentation/widgets/dashbord_widget/dashbord_body_widget.dart';
import 'package:earningfish/features/presentation/widgets/dashbord_widget/dashbord_custom_appbar.dart';
import 'package:earningfish/features/presentation/widgets/dashbord_widget/dashbord_custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => FetchPDIBloc(
                fetchPDIUseCase: FetchPDIUseCase(
                  FetchPDIRepositoryImpl(
                    datasource: FechPDIFirebaseDatasource(),
                  ),
                ),
                localDS: AuthLocalDatasource(),
              ),
        ),
        BlocProvider(create: (context) => LogoutBloc(local: AuthLocalDatasource())),
        BlocProvider(create: (context) => PDIStatusCubit()),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenHight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;
          return Scaffold(
            drawer: AppDrawer(
              screenWidth: screenWidth,
              screenHight: screenHight,
            ),
            appBar: CustomAppBarDashbord(
              onNotificationTap: () {
                Navigator.pushNamed(context, AppRoutes.pdiform);
              },
            ),
            body: DashbordBodyWIdget(
              screenHeight: screenHight,
              screenWidth: screenWidth,
            ),
          );
        },
      ),
    );
  }
}
