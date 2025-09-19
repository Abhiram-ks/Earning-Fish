import 'package:earningfish/core/common/custom_button.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/data/datasource/auth_local_datasource.dart';
import 'package:earningfish/features/data/datasource/pdi_remote_datasource.dart';
import 'package:earningfish/features/data/repo/pdi_repo_impl.dart';
import 'package:earningfish/features/domain/usecase/pdi_usecase.dart';
import 'package:earningfish/features/presentation/bloc/pdi_bloc/pdi_bloc.dart';
import 'package:earningfish/features/presentation/bloc/progresser_cubit/progresser_cubit.dart';
import 'package:earningfish/features/presentation/widgets/pdi_widget/pdi_body_inspection_tap.dart';
import 'package:earningfish/features/presentation/widgets/pdi_widget/pdi_initial_deatails_tap.dart';
import 'package:earningfish/features/presentation/widgets/pdi_widget/pdi_vehicle_details_tap.dart';
import 'package:earningfish/features/presentation/widgets/pdi_widget/pdi_wheel_inspecion_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PdiformScreen extends StatefulWidget {
  const PdiformScreen({super.key});

  @override
  State<PdiformScreen> createState() => _PdiformScreenState();
}

class _PdiformScreenState extends State<PdiformScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PDIBloc(createPDIUseCase: CreatePDIUseCase(PdiRepositoryImpl(datasource: PDIFirebaseDatasource())),localDS: AuthLocalDatasource())),
        BlocProvider(create: (context) => ProgresserCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pre Delivery Inspection',
            style: TextStyle(color: AppPalette.blackColor),
          ),
          backgroundColor: Color(0xFFEAF4F4),
          elevation: 2,
          centerTitle: true,
          automaticallyImplyLeading: true,
          bottom: TabBar(
            dividerColor: AppPalette.whiteColor,
            controller: _tabController,
            labelColor: AppPalette.blackColor,
            unselectedLabelColor: AppPalette.greyColor,
            indicatorColor: AppPalette.blackColor,
            tabs: const [
              Tab(text: 'Initial Details'),
              Tab(text: 'Vehicle Details'),
              Tab(text: 'Body Inspection'),
              Tab(text: 'Wheels & Boot'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            InitialDetailsTab(),
            VehicleDetailsTab(),
            BodyInspectionTab(),
            WheelsInspectionTab(),
          ],
        ),
        bottomNavigationBar: BlocBuilder<PDIBloc, PDIState>(
          builder: (context, state) {
            final bloc = context.read<PDIBloc>();
            final isComplete = bloc.currentData.isComplete;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: CustomButton(
                    text: isComplete ? 'Submit PDI' : 'Complete All Fields',
                    onPressed:
                        isComplete
                            ? () {
                              bloc.add(SubmitPDIEvent());
                            }
                            : null,
                    bgColor:
                        isComplete
                            ? AppPalette.blueColor
                            : AppPalette.greyColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


