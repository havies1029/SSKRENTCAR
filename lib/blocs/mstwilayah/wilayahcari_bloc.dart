import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/list_extension.dart';
import 'package:rentcarapp/models/mstwilayah/wilayahcari_model.dart';
import 'package:rentcarapp/repositories/mstwilayah/wilayahcari_repository.dart';

part 'wilayahcari_event.dart';
part 'wilayahcari_state.dart';

class WilayahCariBloc extends Bloc<WilayahCariEvents, WilayahCariState> {
	WilayahCariBloc() : super(const WilayahCariState()) {
		on<FetchWilayahCariEvent>(onFetchWilayahCari);
		on<RefreshWilayahCariEvent>(onRefreshWilayahCari);
		on<UbahWilayahCariEvent>(onUbahWilayahCari);
		on<TambahWilayahCariEvent>(onTambahWilayahCari);
		on<HapusWilayahCariEvent>(onHapusWilayahCari);
		on<CloseDialogWilayahCariEvent>(onCloseDialogWilayahCari);
	}

	Future<void> onRefreshWilayahCari(
			RefreshWilayahCariEvent event, Emitter<WilayahCariState> emit) async {
		emit(const WilayahCariState());

		await Future.delayed(const Duration(seconds: 1));

		add(FetchWilayahCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchWilayahCari(
			FetchWilayahCariEvent event, Emitter<WilayahCariState> emit) async {
		if (state.hasReachedMax) return;

		WilayahCariRepository repo = WilayahCariRepository();
		if (state.status == ListStatus.initial) {
			List<WilayahCariModel> items = await repo.getWilayahCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<WilayahCariModel> items = await repo.getWilayahCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<WilayahCariModel> wilayahCari = List.of(state.items)..addAll(items);

			final result = wilayahCari
				.whereWithIndex((e, index) =>
					wilayahCari.indexWhere((e2) => e2.mwilayahId == e.mwilayahId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusWilayahCari(
		HapusWilayahCariEvent event, Emitter<WilayahCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogWilayahCari(
		CloseDialogWilayahCariEvent event, Emitter<WilayahCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahWilayahCari(
		TambahWilayahCariEvent event, Emitter<WilayahCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahWilayahCari(
		UbahWilayahCariEvent event, Emitter<WilayahCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}