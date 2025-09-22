part of 'brand_cubit.dart';

class BrandModelState {
  final String vehicle;
  final String brandName;
  final String modelName;
  final String variantName; 
  
  BrandModelState({
    required this.vehicle,
    required this.brandName,
    required this.modelName,
    this.variantName = '',
  });

  BrandModelState copyWith({
    String? vehicle,
    String? brandName,
    String? modelName,
    String? variantName,
  }) {
    return BrandModelState(
      vehicle: vehicle ?? this.vehicle,
      brandName: brandName ?? this.brandName,
      modelName: modelName ?? this.modelName,
      variantName: variantName ?? this.variantName,
    );
  }
}
