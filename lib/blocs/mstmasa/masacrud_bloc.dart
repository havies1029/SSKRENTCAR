import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/models/mstmasa/masacrud_model.dart';
import 'package:rentcarapp/repositories/mstmasa/masacrud_repository.dart';

part 'masacrud_event.dart';
part 'masacrud_state.dart';

class MasaCrudBloc extends Bloc<MasaCrudEvents, MasaCrudState> {
	final MasaCrudRepository repository;
	MasaCrudBloc({required this.repository}) : super(const MasaCrudState()) {
		on<MasaCrudUbahEvent>(onUbahMasaCrud);
		on<MasaCrudTambahEvent>(onTambahMasaCrud);
		on<MasaCrudHapusEvent>(onHapusMasaCrud);
		on<MasaCrudLihatEvent>(onLihatMasaCrud);
	}

	Future<void> onTambahMasaCrud(
		MasaCrudTambahEvent event, Emitter<MasaCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.masaCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahMasaCrud(
		MasaCrudUbahEvent event, Emitter<MasaCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.masaCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusMasaCrud(
		MasaCrudHapusEvent event, Emitter<MasaCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.masaCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatMasaCrud(
		MasaCrudLihatEvent event, Emitter<MasaCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		MasaCrudModel record = await repository.masaCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}