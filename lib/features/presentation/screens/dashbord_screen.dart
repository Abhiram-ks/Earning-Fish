import 'package:earningfish/core/pdfservice/pdf_generate.dart';
import 'package:earningfish/core/routes/app_routes.dart';
import 'package:earningfish/features/data/datasource/auth_local_datasource.dart';
import 'package:earningfish/features/data/datasource/pdi_fech_remote_datasource.dart';
import 'package:earningfish/features/data/model/pdi_model.dart';
import 'package:earningfish/features/data/repo/fech_pdi_repo_impl.dart';
import 'package:earningfish/features/domain/repo/fetch_pdi_usecase.dart';
import 'package:earningfish/features/presentation/bloc/fetchpdi_bloc/fetchpdi_bloc.dart';
import 'package:earningfish/features/presentation/widgets/dashbord_widget/dashbord_custom_appbar.dart';
import 'package:earningfish/features/presentation/widgets/dashbord_widget/dashbord_custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchPDIBloc(fetchPDIUseCase: FetchPDIUseCase(FetchPDIRepositoryImpl(datasource: FechPDIFirebaseDatasource())), localDS: AuthLocalDatasource()),
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
            body: DashbordBodyWIdget(),
          );
        },
      ),
    );
  }
}

class DashbordBodyWIdget extends StatefulWidget {
  const DashbordBodyWIdget({
    super.key,
  });

  @override
  State<DashbordBodyWIdget> createState() => _DashbordBodyWIdgetState();
}

class _DashbordBodyWIdgetState extends State<DashbordBodyWIdget> {
    @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FetchPDIBloc>()
          .add(LoadPDIEvent());
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchPDIBloc, FetchPDIState>(
  builder: (context, state) {
    if (state is FetchPDILoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is FetchPDILoaded) {
  return ListView.builder(
    itemCount: state.pdiList.length,
    itemBuilder: (context, index) {
      final PDIModel pdi = state.pdiList[index];
      return ListTile(
        leading: const Icon(Icons.assignment), // 📋 Example icon
        title: Text(pdi.modelName),
        subtitle: Text('Chassis: ${pdi.chassisNo}'),
        trailing: IconButton(
          icon: const Icon(Icons.picture_as_pdf, color: Colors.red), 
          onPressed: () async {
            final success = await PdiPdfMaker.generatePdiChecklist(model: pdi);
            if (!success && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to generate PDF")),
              );
            }
          },
        ),
      );
    },
  );
}
else if (state is FetchPDIEmpty) {
      return const Center(child: Text('No PDI records found.'));
    } else if (state is FetchPDIError) {
      return Center(child: Text('Error: ${state.message}'));
    }
    return const SizedBox();
  },
);

  }
}
