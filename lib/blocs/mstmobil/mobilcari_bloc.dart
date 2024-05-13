import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/list_extension.dart';
import 'package:rentcarapp/models/mstmobil/mobilcari_model.dart';
import 'package:rentcarapp/repositories/mstmobil/mobilcari_repository.dart';

part 'mobilcari_event.dart';
part 'mobilcari_state.dart';

class MobilCariBloc extends Bloc<MobilCariEvents, MobilCariState> {
  MobilCariBloc() : super(const MobilCariState()) {
    on<FetchMobilCariEvent>(onFetchMobilCari);
    on<RefreshMobilCariEvent>(onRefreshMobilCari);
    on<UbahMobilCariEvent>(onUbahMobilCari);
    on<TambahMobilCariEvent>(onTambahMobilCari);
    on<HapusMobilCariEvent>(onHapusMobilCari);
    on<CloseDialogMobilCariEvent>(onCloseDialogMobilCari);
  }

  Future<void> onRefreshMobilCari(
      RefreshMobilCariEvent event, Emitter<MobilCariState> emit) async {
    emit(const MobilCariState());

    await Future.delayed(const Duration(seconds: 1));

    add(FetchMobilCariEvent(hal: 0, searchText: event.searchText));
  }

  Future<void> onFetchMobilCari(
      FetchMobilCariEvent event, Emitter<MobilCariState> emit) async {
    debugPrint("onFetchMobilCari #10");

    if (state.hasReachedMax) return;

    MobilCariRepository repo = MobilCariRepository();
    if (state.status == ListStatus.initial) {
      List<MobilCariModel> items = await repo.getMobilCari(event.searchText, 0);
      return emit(state.copyWith(
          items: items,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: 1));
    }

    debugPrint("onFetchMobilCari #20");

    List<MobilCariModel> items =
        await repo.getMobilCari(event.searchText, state.hal);
    if (items.isEmpty) {
      return emit(state.copyWith(hasReachedMax: true));
    } else {

      debugPrint("onFetchMobilCari #30");

      List<MobilCariModel> mobilCari = List.of(state.items)..addAll(items);

      final result = mobilCari
          .whereWithIndex((e, index) =>
              mobilCari.indexWhere((e2) => e2.mmobilId == e.mmobilId) == index)
          .toList();

      debugPrint("onFetchMobilCari #40");

      return emit(state.copyWith(
          items: result,
          hasReachedMax: false,
          status: ListStatus.success,
          hal: state.hal + 1));
    }
  }

  Future<void> onHapusMobilCari(
      HapusMobilCariEvent event, Emitter<MobilCariState> emit) async {
    return emit(state.copyWith(viewMode: "hapus"));
  }

  Future<void> onCloseDialogMobilCari(
      CloseDialogMobilCariEvent event, Emitter<MobilCariState> emit) async {
    return emit(state.copyWith(viewMode: ""));
  }

  Future<void> onTambahMobilCari(
      TambahMobilCariEvent event, Emitter<MobilCariState> emit) async {
    return emit(state.copyWith(viewMode: "tambah"));
  }

  Future<void> onUbahMobilCari(
      UbahMobilCariEvent event, Emitter<MobilCariState> emit) async {
    return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
  }
}
