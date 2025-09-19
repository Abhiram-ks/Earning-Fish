part of 'fetchpdi_bloc.dart';

@immutable
abstract class FetchPDIEvent {}

class LoadPDIEvent extends FetchPDIEvent {}
class LoadPDIEventWIthQuary extends FetchPDIEvent {
  final String quary;

  LoadPDIEventWIthQuary({required this.quary});
}