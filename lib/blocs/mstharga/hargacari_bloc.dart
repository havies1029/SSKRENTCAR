import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/list_extension.dart';
import 'package:rentcarapp/models/mstharga/hargacari_model.dart';
import 'package:rentcarapp/repositories/mstharga/hargacari_repository.dart';

part 'hargacari_event.dart';
part 'hargacari_state.dart';

class HargaCariBloc extends Bloc<HargaCariEvents, HargaCariState> {
	HargaCariBloc() : super(const HargaCariState()) {
		on<FetchHargaCariEvent>(onFetchHargaCari);
		on<RefreshHargaCariEvent>(onRefreshHargaCari);
		on<UbahHargaCariEvent>(onUbahHargaCari);
		on<TambahHargaCariEvent>(onTambahHargaCari);
		on<HapusHargaCariEvent>(onHapusHargaCari);
		on<CloseDialogHargaCariEvent>(onCloseDialogHargaCari);
	}

	Future<void> onRefreshHargaCari(
			RefreshHargaCariEvent event, Emitter<HargaCariState> emit) async {
		emit(const HargaCariState());

		await Future.delayed(const Duration(seconds: 1));

		add(FetchHargaCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchHargaCari(
			FetchHargaCariEvent event, Emitter<HargaCariState> emit) async {
		if (state.hasReachedMax) return;

		HargaCariRepository repo = HargaCariRepository();
		if (state.status == ListStatus.initial) {
			List<HargaCariModel> items = await repo.getHargaCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<HargaCariModel> items = await repo.getHargaCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<HargaCariModel> hargaCari = List.of(state.items)..addAll(items);

			final result = hargaCari
				.whereWithIndex((e, index) =>
					hargaCari.indexWhere((e2) => e2.mhargaId == e.mhargaId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusHargaCari(
		HapusHargaCariEvent event, Emitter<HargaCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogHargaCari(
		CloseDialogHargaCariEvent event, Emitter<HargaCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahHargaCari(
		TambahHargaCariEvent event, Emitter<HargaCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahHargaCari(
		UbahHargaCariEvent event, Emitter<HargaCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}