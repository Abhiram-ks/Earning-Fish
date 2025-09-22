import 'dart:developer';
import 'dart:io' as io;
import 'package:earningfish/features/data/model/pdi_model.dart';
import 'package:earningfish/features/presentation/screens/logodetails_screen.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class PdiPdfMaker {
  static Future<pw.MemoryImage?> getBrandLogo(String brand) async {
    try {
      final logoEnum = LogoImageEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == brand.toLowerCase(),
        orElse: () => LogoImageEnum.audi,
      );

      final data = await rootBundle.load(logoEnum.path);
      return pw.MemoryImage(data.buffer.asUint8List());
    } catch (e) {
      return null;
    }
  }

  static Future<bool> generatePdiChecklist({required PDIModel model}) async {
    final pdf = pw.Document();
    final logoData = await rootBundle.load('assets/earningfish_logo.png');
    final logo = pw.MemoryImage(logoData.buffer.asUint8List());
    final brandLogo = await getBrandLogo(model.brand);



    String str(dynamic v) => v?.toString() ?? "-";

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(16),
        build:
            (context) => [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                    pw.Container(
                padding: const pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  borderRadius: pw.BorderRadius.circular(8),
                  boxShadow: [
                    pw.BoxShadow(
                      color: PdfColors.grey300,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: pw.Image(
                  brandLogo ?? logo,
                  height: 40,
                  fit: pw.BoxFit.contain,
                ),
              ),
                  pw.Text(
                    "PDI CHECKLIST",
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text("Date: ${str(model.dateOfInspection)}"),
                ],
              ),
              pw.SizedBox(height: 20),

              pw.Text(
                "PRE-CHECKS",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Vehicle Type: ${str(model.vehicleType)}",
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text('Brand Name: ${str(model.brand)}'),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Model Name: ${str(model.modelName)}"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Model Variant: ${str(model.modelVariant)}",
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Chassis No: ${str(model.chassisNo)}"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Engine No: ${str(model.engineNo)}"),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Key No: ${str(model.keyNo)}"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Battery Make: ${str(model.batteryMake)} / ${str(model.batterySerialNo)}",
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Date of Receipt: ${str(model.dateOfReceipt)}",
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("PDI KMS: ${str(model.pdiKms)}"),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Body Shade: ${str(model.bodyShade)}"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Date of Inspection: ${str(model.dateOfInspection)}",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 15),

              pw.Text(
                "BODY INSPECTION (OUTSIDE INSPECTION)",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Check overall Body and Paint condition:",
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.bodyPaintCondition ?'Ok' : 'Not Ok \n Remark: ${model.bodyPaintRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.bodyPaintCondition? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Check for Dents and other defets in body parts",
                        ),
                      ),
                       pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.dentsDefects ?'Ok' : 'Not Ok \n Remark: ${model.dentsDefectsRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.dentsDefects? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Check Doors and Bonnet alignment"),
                      ),
                       pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.doorsAlignment ?'Ok' : 'Not Ok \n Remark: ${model.doorsAlignmentRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.doorsAlignment? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                   
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Check opening and closing of all doors for Noise/Rattling noise",
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.doorsNoise ?'Ok' : 'Not Ok \n Remark: ${model.doorsNoiseRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.doorsNoise? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Check opening and closing of Tail Gate for Noise/Rattling noise",
                        ),
                      ),
                       pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.tailGateNoise ?'Ok' : 'Not Ok \n Remark: ${model.tailGateNoiseRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.tailGateNoise? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Check operation of remote and vehicle security system (Lock/Unlock)",
                        ),
                      ),
                       pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.remoteOperation ?'Ok' : 'Not Ok \n Remark: ${model.remoteOperationRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.remoteOperation? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                ],
              ),
              
              pw.SizedBox(height: 15),

              pw.Text(
                "WHEELS & TYRES INSPECTION",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Tyre Front RH"),
                      ),
                       pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.tyreFrtRh ?'Ok' : 'Not Ok \n Remark: ${model.tyreFrtRhRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.tyreFrtRh? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Tyre Front LH"),
                      ),
                     pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.tyreFrtLh ?'Ok' : 'Not Ok \n Remark: ${model.tyreFrtLhRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.tyreFrtLh? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Tyre Rear RH"),
                      ),
                       pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.tyreRrRh ?'Ok' : 'Not Ok \n Remark: ${model.tyreRrRhRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.tyreRrRh? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Tyre Rear LH"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.tyreRrLh ?'Ok' : 'Not Ok \n Remark: ${model.tyreRrLhRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.tyreRrLh? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Spare Wheel"),
                      ),
                       pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.spareWheel ?'Ok' : 'Not Ok \n Remark: ${model.spareWheelRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.spareWheel? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Check pressure in all tyres (including spare wheel) as recommended on the label",
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.tyrePressure ?'Ok' : 'Not Ok \n Remark: ${model.tyrePressureRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.tyrePressure? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Check size/fitment of tyres as per vehicle specifications",
                        ),
                      ),
                     pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.tyreFitment ?'Ok' : 'Not Ok \n Remark: ${model.tyreFitmentRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.tyreFitment? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Check spare wheel unlocking"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.spareWheelUnlocking ?'Ok' : 'Not Ok \n Remark: ${model.spareWheelUnlockingRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.spareWheelUnlocking? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Check Jack, Handle, Spanner, Reflector availability",
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.toolsAvailability ?'Ok' : 'Not Ok \n Remark: ${model.toolsAvailabilityRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.toolsAvailability? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Check electric tail gate closing operation",
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.tailGateOperation ?'Ok' : 'Not Ok \n Remark: ${model.tailGateOperationRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.tailGateOperation? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Availability of HSRP (High Security Registration Plate)",
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:pw.Text(model.hsrpAvailability ?'Ok' : 'Not Ok \n Remark: ${model.hsrpAvailabilityRemark ?? 'No remarks available.'}',style: pw.TextStyle(color: model.hsrpAvailability? PdfColors.green : PdfColors.grey)),
                      ),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 25),

              pw.Container(
                padding: const pw.EdgeInsets.all(8),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black, width: 1),
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(5),
                  ),
                ),
                child: pw.Text(
                  "STATUS: ${str(model.status).toUpperCase()}",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.normal,
                    fontSize: 14,
                    color:
                        model.status == 'completed'
                            ? PdfColors.green
                            : PdfColors.orange,
                  ),
                ),
              ),

              pw.SizedBox(height: 30),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Inspector Signature: "),
                      pw.SizedBox(height: 30),
                      pw.Container(
                        width: 150,
                        height: 1,
                        color: PdfColors.black,
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Date: "),
                      pw.SizedBox(height: 30),
                      pw.Container(
                        width: 100,
                        height: 1,
                        color: PdfColors.black,
                      ),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 20),
              pw.Text(
                "Overall Remarks:",
              ),
              pw.Text(
                "__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________",
              ),
            ],
      ),
    );

    try {
      final bytes = await pdf.save();
      final dir =
          await getApplicationDocumentsDirectory(); // Changed from getTemporaryDirectory
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = io.File("${dir.path}/pdi_checklist_$timestamp.pdf");
      await file.writeAsBytes(bytes);

      // Use OpenFilex instead of OpenFile
      final result = await OpenFilex.open(file.path);

      if (result.type == ResultType.done) {
        log('PDF opened successfully');
        return true;
      } else {
        log('Failed to open PDF: ${result.message}');
        return false;
      }
    } catch (e) {
      log('developer: $e');
      return false;
    }
  }
}