part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashBlocGoToLogin extends SplashState {}
final class SplashBlocGoToDashBord extends SplashState {}