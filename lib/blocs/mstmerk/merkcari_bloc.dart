import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/list_extension.dart';
import 'package:rentcarapp/models/mstmerk/merkcari_model.dart';
import 'package:rentcarapp/repositories/mstmerk/merkcari_repository.dart';

part 'merkcari_event.dart';
part 'merkcari_state.dart';

class MerkCariBloc extends Bloc<MerkCariEvents, MerkCariState> {
  MerkCariBloc() : super(const MerkCariState()) {
    on<FetchMerkCariEvent>(onFetchMerkCari);
    on<RefreshMerkCariEvent>(onRefreshMerkCari);
    on<TambahMerkCariEvent>(onTambahMerk);
    on<CloseDialogMerkCariEvent>(onCloseDialog);
    on<HapusMerkCariEvent>(onHapusMerk);
    on<UbahMerkCariEvent>(onUbahMerk);    
  }

  Future<void> onHapusMerk(
      HapusMerkCariEvent event, Emitter<MerkCariState> emit) async {
    debugPrint("MerkCariBloc -> onHapusMerk");

    return emit(state.copyWith(viewMode: "hapus"));
  }

  Future<void> onCloseDialog(
      CloseDialogMerkCariEvent event, Emitter<MerkCariState> emit) async {
    return emit(state.copyWith(viewMode: ""));
  }

  Future<void> onRefreshMerkCari(
      RefreshMerkCariEvent event, Emitter<MerkCariState> emit) async {
    emit(const MerkCariState());

    await Future.delayed(const Duration(seconds: 1));

    add(FetchMerkCariEvent(hal: 0, searchText: event.searchText));
  }

  Future<void> onFetchMerkCari(
      FetchMerkCariEvent event, Emitter<MerkCariState> emit) async {
    debugPrint("onFetchMerkCari #10");

    if (state.hasReachedMax) return;

    MerkCariRepository repo = MerkCariRepository();
    if (state.status == ListStatus.initial) {
      List<MerkCariModel> items = await repo.getMerkCari(event.searchText, 0);
      return emit(state.copyWith(
          items: items,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: 1));
    }

    List<MerkCariModel> items =
        await repo.getMerkCari(event.searchText, state.hal);

    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {
      List<MerkCariModel> merkCari = List.of(state.items)..addAll(items);

      final result = merkCari
          .whereWithIndex((e, index) =>
              merkCari.indexWhere((e2) => e2.mmerkId == e.mmerkId) == index)
          .toList();

      return emit(state.copyWith(
          items: result,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: state.hal + 1));
    }
  }

  Future<void> onTambahMerk(
      TambahMerkCariEvent event, Emitter<MerkCariState> emit) async {
    return emit(state.copyWith(viewMode: "tambah"));
  }

  Future<void> onUbahMerk(
      UbahMerkCariEvent event, Emitter<MerkCariState> emit) async {
    return emit(
        state.copyWith(viewMode: "ubah", recordId: event.recordId));
  }
}
