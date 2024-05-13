import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/list_extension.dart';
import 'package:rentcarapp/models/msttipe/tipecari_model.dart';
import 'package:rentcarapp/repositories/msttipe/tipecari_repository.dart';

part 'tipecari_event.dart';
part 'tipecari_state.dart';

class TipeCariBloc extends Bloc<TipeCariEvents, TipeCariState> {
	TipeCariBloc() : super(const TipeCariState()) {
		on<FetchTipeCariEvent>(onFetchTipeCari);
		on<RefreshTipeCariEvent>(onRefreshTipeCari);
		on<UbahTipeCariEvent>(onUbahTipeCari);
		on<TambahTipeCariEvent>(onTambahTipeCari);
		on<HapusTipeCariEvent>(onHapusTipeCari);
		on<CloseDialogTipeCariEvent>(onCloseDialogTipeCari);
	}

	Future<void> onRefreshTipeCari(
			RefreshTipeCariEvent event, Emitter<TipeCariState> emit) async {
		emit(const TipeCariState());

		await Future.delayed(const Duration(seconds: 1));

		add(FetchTipeCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchTipeCari(
			FetchTipeCariEvent event, Emitter<TipeCariState> emit) async {
		if (state.hasReachedMax) return;

		TipeCariRepository repo = TipeCariRepository();
		if (state.status == ListStatus.initial) {
			List<TipeCariModel> items = await repo.getTipeCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<TipeCariModel> items = await repo.getTipeCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<TipeCariModel> tipeCari = List.of(state.items)..addAll(items);

			final result = tipeCari
				.whereWithIndex((e, index) =>
					tipeCari.indexWhere((e2) => e2.mtipeId == e.mtipeId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusTipeCari(
		HapusTipeCariEvent event, Emitter<TipeCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogTipeCari(
		CloseDialogTipeCariEvent event, Emitter<TipeCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahTipeCari(
		TambahTipeCariEvent event, Emitter<TipeCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahTipeCari(
		UbahTipeCariEvent event, Emitter<TipeCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}