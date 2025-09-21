import 'package:earningfish/core/constant/app_images.dart';
import 'package:earningfish/core/constant/constant.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/presentation/bloc/fetchpdi_bloc/fetchpdi_bloc.dart';
import 'package:earningfish/features/presentation/screens/pdi_screen.dart';
import 'package:earningfish/features/presentation/widgets/dashbord_widget/dashbord_pdi_customcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.screenWidth * .1,
            vertical: widget.screenHeight * 0.01,
          ),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.5,
            children: List.generate(4, (index) {
              final isFirst = index == 0;
              final bgColor = isFirst ? Colors.purple : Colors.grey.shade400;
              final textColor = isFirst ? Colors.white : Colors.black87;

              return CustomPDIDemoCard(bgColor: bgColor, text: isFirst ? 'PDI': '', textColor: textColor, onTap: isFirst ? (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PdiScreen()));
              } : (){});
            }),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
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
                        ),
                        ConstantWidgets.hight30(context),
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
                          style: TextStyle(
                            color: AppPalette.blackColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is FetchPDILoaded) {
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
                      ),
                      ConstantWidgets.hight20(context),
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
          ),
        ),
      ],
    );
  }
}

class CustomPDIDemoCard extends StatelessWidget {
  const CustomPDIDemoCard({
    super.key,
    required this.bgColor,
    required this.text,
    required this.textColor,
    this.onTap,
  });

  final Color bgColor;
  final String text;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:AppPalette.blackColor.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
