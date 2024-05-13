import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/models/combobox/combosupir_model.dart';
import 'package:rentcarapp/models/sewamobil/antarcrud_model.dart';
import 'package:rentcarapp/repositories/sewamobil/antarcrud_repository.dart';

part 'antarcrud_event.dart';
part 'antarcrud_state.dart';

class AntarCrudBloc extends Bloc<AntarCrudEvents, AntarCrudState> {
	final AntarCrudRepository repository;
	AntarCrudBloc({required this.repository}) : super(const AntarCrudState()) {
		on<AntarCrudUbahEvent>(onUbahAntarCrud);
		on<AntarCrudTambahEvent>(onTambahAntarCrud);
		on<AntarCrudHapusEvent>(onHapusAntarCrud);
		on<AntarCrudLihatEvent>(onLihatAntarCrud);
		on<ComboSupirChangedEvent>(onComboSupirChanged);
	}

	Future<void> onTambahAntarCrud(
		AntarCrudTambahEvent event, Emitter<AntarCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.antarCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahAntarCrud(
		AntarCrudUbahEvent event, Emitter<AntarCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.antarCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusAntarCrud(
		AntarCrudHapusEvent event, Emitter<AntarCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.antarCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatAntarCrud(
		AntarCrudLihatEvent event, Emitter<AntarCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		AntarCrudModel record = await repository.antarCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

	Future<void> onComboSupirChanged(
			ComboSupirChangedEvent event, Emitter<AntarCrudState> emit) async {

		emit(state.copyWith(isLoading: true, isLoaded: false));

		ComboSupirModel comboSupir = event.comboSupir;
		AntarCrudModel rec = state.record!;
		rec.supirId = comboSupir.mstaffId;
		rec.comboSupir = comboSupir;

		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			record: rec));
	}

}