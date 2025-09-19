part of 'pdistatus_cubit.dart';

abstract class PDIStatusState {}

class PDIStatusInitial extends PDIStatusState {}

class PDIStatusSuccess extends PDIStatusState {}

class PDIStatusFailure extends PDIStatusState {
  final String message;
  PDIStatusFailure({required this.message});
}
