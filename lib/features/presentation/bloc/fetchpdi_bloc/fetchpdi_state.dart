part of 'fetchpdi_bloc.dart';

@immutable
abstract class FetchPDIState {}

class FetchPDIInitial extends FetchPDIState {}

class FetchPDILoading extends FetchPDIState {}

class FetchPDILoaded extends FetchPDIState {
  final List<PDIModel> pdiList;
  FetchPDILoaded({required this.pdiList});
}

class FetchPDIEmpty extends FetchPDIState {
  final String message;
  FetchPDIEmpty({required this.message});
}

class FetchPDIError extends FetchPDIState {
  final String message;
  FetchPDIError({required this.message});
}
