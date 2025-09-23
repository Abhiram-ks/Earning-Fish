
import 'package:earningfish/core/common/custom_snackbar.dart';
import 'package:earningfish/core/pdfservice/pdf_generate.dart';
import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/features/data/model/pdi_model.dart';
import 'package:earningfish/features/presentation/bloc/pdistatus_cubit/pdistatus_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PDICustomCardWidget extends StatelessWidget {
  final double screenHeight;
  final PDIModel model;
  const PDICustomCardWidget({
    super.key,
    required this.screenHeight,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMark = model.status == "pending" ? true : false;
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: AppPalette.whiteColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model.brand.toUpperCase()}: ${model.modelName}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Text(
                        model.modelVariant,
                        style: TextStyle(
                          color: AppPalette.blackColor,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final success =
                              await PdiPdfMaker.generatePdiChecklist(
                                model: model,
                              );
                          if (!success && context.mounted) {
                            CustomSnackBar.show(
                              context,
                              message: "Failed to generate PDF. Try again",
                              backgroundColor: AppPalette.redColor,
                              textAlign: TextAlign.center,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.picture_as_pdf_rounded,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Generate PDF",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppPalette.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withValues(alpha: 0.9),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PopupMenuButton<String>(
                          color: AppPalette.whiteColor,
                          offset: const Offset(0, 35),
                          padding: EdgeInsets.zero,
                          onSelected: (value) {
                            final cubit = context.read<PDIStatusCubit>();
                            cubit.updateStatus(
                              pdiId: model.docId ?? '',
                              newStatus: value,
                            );
                          },
                          itemBuilder: (context) {
                            List<PopupMenuItem<String>> items = [];
                            if (model.status == 'pending') {
                              items.add(
                                const PopupMenuItem(
                                  value: 'complete',
                                  child: Text('complete'),
                                ),
                              );
                            } else if (model.status == 'complete') {
                              items.add(
                                const PopupMenuItem(
                                  value: 'pending',
                                  child: Text('pending'),
                                ),
                              );
                            }
                            return items;
                          },
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isMark
                                    ? AppPalette.orengeColor.withAlpha(
                                      (0.1 * 255).toInt(),
                                    )
                                    : AppPalette.greenColor.withAlpha(
                                      (0.1 * 255).toInt(),
                                    ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  isMark
                                      ? AppPalette.orengeColor
                                      : AppPalette.greenColor,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isMark
                                    ? Icons.pending_actions_rounded
                                    : Icons.check_circle_sharp,
                                color:
                                    isMark
                                        ? AppPalette.orengeColor
                                        : AppPalette.greenColor,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                model.status,
                                style: TextStyle(
                                  color:
                                      isMark
                                          ? AppPalette.orengeColor
                                          : AppPalette.greenColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}