import 'dart:developer';
import 'dart:io' as io; 
import 'package:earningfish/features/data/model/pdi_model.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class PdiPdfMaker {
  static Future<bool> generatePdiChecklist({required PDIModel model}) async {
    final pdf = pw.Document();
    final logoData = await rootBundle.load('assets/earningfish_logo.png');
    final logo = pw.MemoryImage(logoData.buffer.asUint8List());

pw.Widget yesNoField(bool? value) {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.center,
    children: [
      pw.Text(
        "Yes",
        style: pw.TextStyle(
          fontSize: 14,
          color: value == true 
              ? PdfColors.green 
              : PdfColor.fromInt(0xFFDDDDDD),
        ),
      ),
      pw.SizedBox(width: 20),

      pw.Text(
        "No",
        style: pw.TextStyle(
          fontSize: 14,
          color: value == false 
              ? PdfColors.red 
              : PdfColor.fromInt(0xFFDDDDDD),
        ),
      ),
    ],
  );
}



    String str(dynamic v) => v?.toString() ?? "-";

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(16),
        build: (context) => [
          // Header
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Image(logo, height: 50),
              pw.Text("PDI CHECKLIST",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.Text("Date: ${str(model.dateOfInspection)}"),
            ],
          ),
          pw.SizedBox(height: 20),

          // Section PRE-CHECKS
          pw.Text("PRE-CHECKS", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Table(
            border: pw.TableBorder.all(),
            children: [
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Model Name: ${str(model.modelName)}")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Model Variant: ${str(model.modelVariant)}")),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Chassis No: ${str(model.chassisNo)}")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Engine No: ${str(model.engineNo)}")),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Key No: ${str(model.keyNo)}")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Battery Make: ${str(model.batteryMake)} / ${str(model.batterySerialNo)}")),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Date of Receipt: ${str(model.dateOfReceipt)}")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("PDI KMS: ${str(model.pdiKms)}")),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Body Shade: ${str(model.bodyShade)}")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Date of Inspection: ${str(model.dateOfInspection)}")),
              ]),
            ],
          ),
          pw.SizedBox(height: 15),

          pw.Text("BODY INSPECTION (OUTSIDE INSPECTION)", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Table(
            border: pw.TableBorder.all(),
            children: [
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Check overall Body and Paint condition:")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.bodyPaintCondition ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Check for Dents and other defets in body parts")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.dentsDefects ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Check Doors and Bonnet alignment")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.doorsAlignment ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Check opening and closing of all doors for Noise/Rattling noise")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.doorsNoise ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Check opening and closing of Tail Gate for Noise/Rattling noise")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.tailGateNoise ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Check operation of remote and vehicle security system (Lock/Unlock)")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.remoteOperation ?? false)),
              ]),
            ],
          ),
          pw.SizedBox(height: 15),

          pw.Text("WHEELS & TYRES INSPECTION", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Table(
            border: pw.TableBorder.all(),
            children: [
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Tyre Front RH")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.tyreFrtRh ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Tyre Front LH")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.tyreFrtLh ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Tyre Rear RH")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.tyreRrRh ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Tyre Rear LH")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.tyreRrLh ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Spare Wheel")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.spareWheel ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Check pressure in all tyres (including spare wheel) as recommended on the label")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.tyrePressure ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Check size/fitment of tyres as per vehicle specifications")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.tyreFitment ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Check spare wheel unlocking")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.spareWheelUnlocking ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Check Jack, Handle, Spanner, Reflector availability")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.toolsAvailability ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Check electric tail gate closing operation")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.tailGateOperation ?? false)),
              ]),
              pw.TableRow(children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: pw.Text("Availability of HSRP (High Security Registration Plate)")),
                pw.Padding(
                    padding: const pw.EdgeInsets.all(4),
                    child: yesNoField(model.hsrpAvailability ?? false)),
              ]),
            ],
          ),

          pw.SizedBox(height: 25),
          
          pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black, width: 2),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
            ),
            child: pw.Text(
              "STATUS: ${str(model.status).toUpperCase()}",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 16,
                color: model.status == 'completed' ? PdfColors.green : PdfColors.orange,
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
          pw.Text("Overall Remarks: ___________________________________________"),
          pw.SizedBox(height: 10),
          pw.Text("__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________"),
        ],
      ),
    );

    try {
      final bytes = await pdf.save();
      final dir = await getApplicationDocumentsDirectory(); // Changed from getTemporaryDirectory
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
      print("PDF Error: $e");
      return false;
    }
  }
}