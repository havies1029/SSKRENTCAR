import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/list_extension.dart';
import 'package:rentcarapp/models/mstmasa/masacari_model.dart';
import 'package:rentcarapp/repositories/mstmasa/masacari_repository.dart';

part 'masacari_event.dart';
part 'masacari_state.dart';

class MasaCariBloc extends Bloc<MasaCariEvents, MasaCariState> {
	MasaCariBloc() : super(const MasaCariState()) {
		on<FetchMasaCariEvent>(onFetchMasaCari);
		on<RefreshMasaCariEvent>(onRefreshMasaCari);
		on<UbahMasaCariEvent>(onUbahMasaCari);
		on<TambahMasaCariEvent>(onTambahMasaCari);
		on<HapusMasaCariEvent>(onHapusMasaCari);
		on<CloseDialogMasaCariEvent>(onCloseDialogMasaCari);
	}

	Future<void> onRefreshMasaCari(
			RefreshMasaCariEvent event, Emitter<MasaCariState> emit) async {
		emit(const MasaCariState());

		await Future.delayed(const Duration(seconds: 1));

		add(FetchMasaCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchMasaCari(
			FetchMasaCariEvent event, Emitter<MasaCariState> emit) async {
		if (state.hasReachedMax) return;

		MasaCariRepository repo = MasaCariRepository();
		if (state.status == ListStatus.initial) {
			List<MasaCariModel> items = await repo.getMasaCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<MasaCariModel> items = await repo.getMasaCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<MasaCariModel> masaCari = List.of(state.items)..addAll(items);

			final result = masaCari
				.whereWithIndex((e, index) =>
					masaCari.indexWhere((e2) => e2.mmasaId == e.mmasaId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusMasaCari(
		HapusMasaCariEvent event, Emitter<MasaCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogMasaCari(
		CloseDialogMasaCariEvent event, Emitter<MasaCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahMasaCari(
		TambahMasaCariEvent event, Emitter<MasaCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahMasaCari(
		UbahMasaCariEvent event, Emitter<MasaCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}