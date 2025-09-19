part of 'pdi_bloc.dart';

@immutable
abstract class PDIState {
}

class PDIInitial extends PDIState {}

class PDIUpdated extends PDIState {
  final PDIData pdiData;
   PDIUpdated(this.pdiData);
}

class PDICompleted extends PDIState {
  final PDIData pdiData;
   PDICompleted(this.pdiData);
}

class PDiLoaidngState extends PDIState {}
class PDiSuccessState extends PDIState {}
class PDiFailureState extends PDIState {
  final String message;
  PDiFailureState({required this.message});
}