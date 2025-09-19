part of 'logout_bloc.dart';

@immutable
abstract class LogoutEvent {}
final class LogoutRequest extends LogoutEvent {}
final class LogoutProceed extends LogoutEvent {}