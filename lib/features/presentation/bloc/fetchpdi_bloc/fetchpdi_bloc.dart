import 'package:bloc/bloc.dart';
import 'package:earningfish/features/data/datasource/auth_local_datasource.dart';
import 'package:earningfish/features/data/model/pdi_model.dart';
import 'package:earningfish/features/domain/repo/fetch_pdi_usecase.dart';
import 'package:flutter/material.dart';

part 'fetchpdi_event.dart';
part 'fetchpdi_state.dart';

class FetchPDIBloc extends Bloc<FetchPDIEvent, FetchPDIState> {
  final FetchPDIUseCase fetchPDIUseCase;
  final AuthLocalDatasource localDS;

  FetchPDIBloc({required this.fetchPDIUseCase, required this.localDS}) : super(FetchPDIInitial()) {
    on<LoadPDIEvent>(_onLoadPDI);
    on<LoadPDIEventWIthQuary>(_onQuary);
  }

  void _onLoadPDI(
      LoadPDIEvent event, Emitter<FetchPDIState> emit) async {
    emit(FetchPDILoading());

    try {
      final uid = await localDS.get();
      if (uid == null) {
        return emit( FetchPDIError(message: "Failed to Request PDI. user not found Please login again."));
      }
      final pdiStream = fetchPDIUseCase.execute(uid: uid);
      await emit.forEach<List<PDIModel>>(
        pdiStream,
        onData: (data) {
          if (data.isEmpty) {
            return FetchPDIEmpty(message: "PDI");
          } else {
            return FetchPDILoaded(pdiList: data);
          }
        },
        onError: (error, _) => FetchPDIError(message: error.toString()),
      );
    } catch (e) {
      emit(FetchPDIError(message: e.toString()));
    }
  }

    void _onQuary(
      LoadPDIEventWIthQuary event, Emitter<FetchPDIState> emit) async {
    emit(FetchPDILoading());

    try {
      final uid = await localDS.get();
      if (uid == null) {
        return emit( FetchPDIError(message: "Failed to Request PDI. user not found Please login again."));
      }
      final pdiStream = fetchPDIUseCase.executeQuary(uid: uid,quary: event.quary);
      await emit.forEach<List<PDIModel>>(
        pdiStream,
        onData: (data) {
          if (data.isEmpty) {
            return FetchPDIEmpty(message: "PDI");
          } else {
            return FetchPDILoaded(pdiList: data);
          }
        },
        onError: (error, _) => FetchPDIError(message: error.toString()),
      );
    } catch (e) {
      emit(FetchPDIError(message: e.toString()));
    }
  }
}