import 'package:bloc/bloc.dart';
import 'package:earningfish/core/hash/hashfunction.dart';
import 'package:earningfish/features/domain/usecase/auth_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthUseCase useCase;

  LoginBloc({required this.useCase}) : super(LoginInitial()) {
    on<LoginRequest>(_login);
  }

  Future<void> _login(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginRequest) {
      emit(LoginLoading());
      try {
         final String hashPassword = Hashfunction.generateHash(event.password);
        final success = await useCase.execute(
          email: event.email,
          password: hashPassword,
        );

        if (success) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(message: 'Login failed. UID not returned. Plese try again'));
        }
      } on FirebaseAuthException catch (e) {
        emit(LoginFailure(message: e.message ?? 'Firebase login error'));
      } catch (e) {
        emit(LoginFailure(message: 'Unexpected error: $e'));
      }
    }
  }
}