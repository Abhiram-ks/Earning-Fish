import 'package:bloc/bloc.dart';
import 'package:earningfish/features/domain/usecase/auth_usecase.dart';
import 'package:flutter/material.dart';
part 'googlesing_event.dart';
part 'googlesing_state.dart';


class GooglesignBloc extends Bloc<GooglesignEvent, GooglesignState> {
  final AuthUseCase _usecase;
  GooglesignBloc(this._usecase) : super(GooglesignInitial()) {
    on<GoogleSignUP>(_auth);
  }

  Future<void> _auth(GoogleSignUP event, Emitter<GooglesignState> emit) async {
    emit(GooglesingLoading());
    try {
      final success = await _usecase.execute();
      if (success) {
        emit(GooglesingSuccess());
      } else {
        emit(GooglesingFailure(message: 'Sign-In failed. Please try again.'));
      }
    } catch (e) {
      emit(GooglesingFailure(message: e.toString()));
    }
  }
}
