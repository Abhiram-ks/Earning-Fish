
import 'package:earningfish/core/constant/app_images.dart';
import 'package:earningfish/core/constant/constant.dart';
import 'package:earningfish/core/routes/app_routes.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/data/datasource/auth_local_datasource.dart';
import 'package:earningfish/features/data/datasource/pdi_fech_remote_datasource.dart';
import 'package:earningfish/features/data/repo/fech_pdi_repo_impl.dart';
import 'package:earningfish/features/domain/repo/fetch_pdi_usecase.dart';
import 'package:earningfish/features/presentation/bloc/fetchpdi_bloc/fetchpdi_bloc.dart';
import 'package:earningfish/features/presentation/widgets/dashbord_widget/dashbord_custom_appbar.dart';
import 'package:earningfish/features/presentation/widgets/dashbord_widget/dashbord_custom_drawer.dart';
import 'package:earningfish/features/presentation/widgets/dashbord_widget/dashbord_pdi_customcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => FetchPDIBloc(
            fetchPDIUseCase: FetchPDIUseCase(
              FetchPDIRepositoryImpl(datasource: FechPDIFirebaseDatasource()),
            ),
            localDS: AuthLocalDatasource(),
          ),
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

class DashbordBodyWIdget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  const DashbordBodyWIdget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  State<DashbordBodyWIdget> createState() => _DashbordBodyWIdgetState();
}

class _DashbordBodyWIdgetState extends State<DashbordBodyWIdget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FetchPDIBloc>().add(LoadPDIEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppPalette.whiteColor,
      color: AppPalette.blueColor,
      onRefresh: () async {
        context.read<FetchPDIBloc>().add(LoadPDIEvent());
      },
      child: BlocBuilder<FetchPDIBloc, FetchPDIState>(
        builder: (context, state) {
          if (state is FetchPDILoading) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 13,
                    height: 13,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppPalette.hintColor,
                      ),
                      backgroundColor: AppPalette.blueColor,
                    ),
                  ),
                  ConstantWidgets.hight20(context),
                  Text(
                    "Please wait a moment...",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Fetching data, your request is being processed.",
                    style: TextStyle(
                      color: AppPalette.blackColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is FetchPDIEmpty) {
              return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.appLogo,
                  height: 60,
                  width: 60,
                  fit: BoxFit.contain,
                ),
                Text(
                  'EARNING FISH',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),ConstantWidgets.hight30(context),
                Text(
                  "No ${state.message} data",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                 "Start adding tasks to manage your time effectively.",
                  style: TextStyle(color: AppPalette.blackColor, fontSize: 12),
                ),
              ],
            ),
          );
          }
          else if (state is FetchPDILoaded) {
            final tasks = state.pdiList;

            return ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: widget.screenWidth * 0.04,
                vertical: widget.screenHeight * .02,
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return PDICustomCardWidget(
                  screenHeight: widget.screenWidth,
                  model: task,
                );
              },
              separatorBuilder:
                  (_, __) => SizedBox(height: widget.screenHeight * .005),
            );
          }
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_off_outlined,
                  color: AppPalette.blackColor,
                  size: 60,
                ),ConstantWidgets.hight20(context),
                Text(
                  "Oop's Unable to complete the request.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ), 
                Text(
                  'Please try again later.',
                  style: TextStyle(color: AppPalette.blackColor),
                ),
                IconButton(
                  onPressed: () {
                    context.read<FetchPDIBloc>().add(LoadPDIEvent());
                  },
                  icon: Icon(Icons.refresh_rounded),
                ),
              ],
            ),
          );
        
        },
      ),
    );
  }
}
