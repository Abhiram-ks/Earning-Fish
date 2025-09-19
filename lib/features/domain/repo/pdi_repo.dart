import 'package:earningfish/features/data/model/pdi_model.dart';

abstract class PDIRepository {
  Future<bool> createPDI({required PDIModel pdi});
}