import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/list_extension.dart';
import 'package:rentcarapp/models/sewamobil/sewacari_model.dart';
import 'package:rentcarapp/repositories/sewamobil/sewacari_repository.dart';

part 'sewacari_event.dart';
part 'sewacari_state.dart';

class SewaCariBloc extends Bloc<SewaCariEvents, SewaCariState> {
	SewaCariBloc() : super(const SewaCariState()) {
		on<FetchSewaCariEvent>(onFetchSewaCari);
		on<RefreshSewaCariEvent>(onRefreshSewaCari);
		on<UbahSewaCariEvent>(onUbahSewaCari);
		on<TambahSewaCariEvent>(onTambahSewaCari);
		on<HapusSewaCariEvent>(onHapusSewaCari);
		on<CloseDialogSewaCariEvent>(onCloseDialogSewaCari);
	}

	Future<void> onRefreshSewaCari(
			RefreshSewaCariEvent event, Emitter<SewaCariState> emit) async {
		emit(const SewaCariState());

		await Future.delayed(const Duration(seconds: 1));

		add(FetchSewaCariEvent(hal: 0, searchText: event.searchText));
	}

	Future<void> onFetchSewaCari(
			FetchSewaCariEvent event, Emitter<SewaCariState> emit) async {
		if (state.hasReachedMax) return;

		SewaCariRepository repo = SewaCariRepository();
		if (state.status == ListStatus.initial) {
			List<SewaCariModel> items = await repo.getSewaCari(event.searchText, 0);
			return emit(state.copyWith(
				items: items,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: 1));
		}
		List<SewaCariModel> items = await repo.getSewaCari(event.searchText, state.hal);
		if (items.isEmpty) {
			return emit(state.copyWith(hasReachedMax: true));
		} else {
			List<SewaCariModel> sewaCari = List.of(state.items)..addAll(items);

			final result = sewaCari
				.whereWithIndex((e, index) =>
					sewaCari.indexWhere((e2) => e2.sewa1Id == e.sewa1Id) ==
					index)
				.toList();

			return emit(state.copyWith(
				items: result,
				hasReachedMax: false,
				status: ListStatus.success,
				hal: state.hal + 1));
		}
	}

	Future<void> onHapusSewaCari(
		HapusSewaCariEvent event, Emitter<SewaCariState> emit) async {
		return emit(state.copyWith(viewMode: "hapus"));
	}

	Future<void> onCloseDialogSewaCari(
		CloseDialogSewaCariEvent event, Emitter<SewaCariState> emit) async {
		return emit(state.copyWith(viewMode: ""));
	}

	Future<void> onTambahSewaCari(
		TambahSewaCariEvent event, Emitter<SewaCariState> emit) async {
		return emit(state.copyWith(viewMode: "tambah"));
	}

	Future<void> onUbahSewaCari(
		UbahSewaCariEvent event, Emitter<SewaCariState> emit) async {
		return emit(state.copyWith(viewMode: "ubah", recordId: event.recordId));
	}

}