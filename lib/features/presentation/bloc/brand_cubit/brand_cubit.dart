import 'package:bloc/bloc.dart';
part 'brand_state.dart';


class BrandModelCubit extends Cubit<BrandModelState> {
  BrandModelCubit() : super(BrandModelState(vehicle: '', brandName: '', modelName: '', variantName: ''));

  void selectBrand(String brandName) {
    emit(state.copyWith(brandName: brandName));
  }

  void selectModel(String modelName) {
    emit(state.copyWith(modelName: modelName));
  }

  void selectVehicle(String vehicle) {
    emit(state.copyWith(vehicle: vehicle));
  }

  void selectVariant(String variantName) {
    emit(state.copyWith(variantName: variantName));
  }

  void reset() {
    emit(BrandModelState(vehicle: '', brandName: '', modelName: '', variantName: ''));
  }
}
