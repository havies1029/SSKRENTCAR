import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/list_extension.dart';
import 'package:rentcarapp/models/mstwarna/warnacari_model.dart';
import 'package:rentcarapp/repositories/mstwarna/warnacari_repository.dart';

part 'warnacari_event.dart';
part 'warnacari_state.dart';

class WarnaCariBloc extends Bloc<WarnaCariEvents, WarnaCariState> {
	WarnaCariBloc() : super(const WarnaCariState()) {
		on<FetchWarnaCariEvent>(onFetchWarnaCari);
		on<RefreshWarnaCariEvent>(onRefreshWarnaCari);
		on<UbahWarnaCariEvent>(onUbahWarnaCari);
		on<TambahWarnaCariEvent>(onTambahWarnaCari);
		on<HapusWarnaCariEvent>(onHapusWarnaCari);
		on<CloseDialogWarnaCariEvent>(onCloseDialogWarnaCari);
	}

	Future<void> onRefreshWarnaCari(
			RefreshWarnaCariEvent event, Emitter<WarnaCariState> emit) async {
		emit(const WarnaCariState());

		await Future.delayed(const Duration(seconds: 1));

		add(FetchWarnaCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchWarnaCari(
			FetchWarnaCariEvent event, Emitter<WarnaCariState> emit) async {
		if (state.hasReachedMax) return;

		WarnaCariRepository repo = WarnaCariRepository();
		if (state.status == ListStatus.initial) {
			List<WarnaCariModel> items = await repo.getWarnaCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<WarnaCariModel> items = await repo.getWarnaCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<WarnaCariModel> warnaCari = List.of(state.items)..addAll(items);

			final result = warnaCari
				.whereWithIndex((e, index) =>
					warnaCari.indexWhere((e2) => e2.mwarnaId == e.mwarnaId) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusWarnaCari(
		HapusWarnaCariEvent event, Emitter<WarnaCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogWarnaCari(
		CloseDialogWarnaCariEvent event, Emitter<WarnaCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahWarnaCari(
		TambahWarnaCariEvent event, Emitter<WarnaCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahWarnaCari(
		UbahWarnaCariEvent event, Emitter<WarnaCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}