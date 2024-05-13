import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/models/mstharga/hargacrud_model.dart';
import 'package:rentcarapp/repositories/mstharga/hargacrud_repository.dart';

part 'hargacrud_event.dart';
part 'hargacrud_state.dart';

class HargaCrudBloc extends Bloc<HargaCrudEvents, HargaCrudState> {
	final HargaCrudRepository repository;
	HargaCrudBloc({required this.repository}) : super(const HargaCrudState()) {
		on<HargaCrudUbahEvent>(onUbahHargaCrud);
		on<HargaCrudTambahEvent>(onTambahHargaCrud);
		on<HargaCrudHapusEvent>(onHapusHargaCrud);
		on<HargaCrudLihatEvent>(onLihatHargaCrud);
	}

	Future<void> onTambahHargaCrud(
		HargaCrudTambahEvent event, Emitter<HargaCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.hargaCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahHargaCrud(
		HargaCrudUbahEvent event, Emitter<HargaCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.hargaCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusHargaCrud(
		HargaCrudHapusEvent event, Emitter<HargaCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.hargaCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatHargaCrud(
		HargaCrudLihatEvent event, Emitter<HargaCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		HargaCrudModel record = await repository.hargaCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}