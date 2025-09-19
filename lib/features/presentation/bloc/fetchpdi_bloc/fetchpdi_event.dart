part of 'fetchpdi_bloc.dart';

@immutable
abstract class FetchPDIEvent {}

class LoadPDIEvent extends FetchPDIEvent {}