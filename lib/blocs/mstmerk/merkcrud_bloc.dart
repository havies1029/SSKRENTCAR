import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/models/mstmerk/merkcrud_model.dart';
import 'package:rentcarapp/repositories/mstmerk/merkcrud_repository.dart';

import '../../models/responseAPI/returndataapi_model.dart';

part 'merkcrud_event.dart';
part 'merkcrud_state.dart';

class MerkCrudBloc extends Bloc<MerkCrudEvents, MerkCrudState> {
  final MerkCrudRepository repository;

  MerkCrudBloc({required this.repository})
      : super(const MerkCrudState()) {
    on<MerkCrudTambahEvent>(onTambah);
    on<MerkCrudUbahEvent>(onUbah);
    on<MerkCrudHapusEvent>(onHapus);
    on<MerkCrudLihatEvent>(onLihat);
  }

  Future<void> onTambah(
      MerkCrudTambahEvent event, Emitter<MerkCrudState> emit) async {
    debugPrint("#### onTambahMember ####");

    ReturnDataAPI returnData;
    bool hasFailure = true;

    emit(state.copyWith(isSaving: true, isSaved: false));
    returnData = await repository.merkCrudTambah(event.record);
    hasFailure = !returnData.success;

    emit(state.copyWith(
        isSaving: false,
        isSaved: true,
        hasFailure: hasFailure));
  }

  Future<void> onUbah(
      MerkCrudUbahEvent event, Emitter<MerkCrudState> emit) async {

    debugPrint("#### onUbahMember ####");

    emit(state.copyWith(isSaving: true, isSaved: false));

    bool hasFailure = !await repository.merkCrudUbah(event.record);

    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onHapus(
      MerkCrudHapusEvent event, Emitter<MerkCrudState> emit) async {
    
    debugPrint("#### onHapus ####");

    emit(state.copyWith(isSaving: true, isSaved: false));

    bool hasFailure = !await repository.merkCrudHapus(event.recordId);

    emit(
        state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
  }

  Future<void> onLihat(
      MerkCrudLihatEvent event, Emitter<MerkCrudState> emit) async {
    
    debugPrint("#### onLihat ####");
    
    emit(state.copyWith(isLoading: true, isLoaded: false));
    MerkCrudModel record = await repository.merkCrudLihat(event.recordId);    
    emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
  }

}
