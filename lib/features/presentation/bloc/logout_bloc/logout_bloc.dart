import 'package:bloc/bloc.dart';
import 'package:earningfish/features/data/datasource/auth_local_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthLocalDatasource local;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LogoutBloc({required this.local}) : super(LogoutInitial()) {
    on<LogoutRequest>((event, emit) {
      emit(LogoutAlertState());
    });

    on<LogoutProceed>((event, emit) async {
      try {
        final bool cleared = await local.clear();
        if (cleared) {
          await _auth.signOut(); 
          emit(LogoutSuccess());
        } else {
          emit(LogoutFailure(message: "Failed to clear local data."));
        }
      } catch (e) {
        emit(LogoutFailure(message: "Logout failed: ${e.toString()}"));
      }
    });
  }
}