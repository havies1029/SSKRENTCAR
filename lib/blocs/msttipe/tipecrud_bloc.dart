import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/models/msttipe/tipecrud_model.dart';
import 'package:rentcarapp/repositories/msttipe/tipecrud_repository.dart';

part 'tipecrud_event.dart';
part 'tipecrud_state.dart';

class TipeCrudBloc extends Bloc<TipeCrudEvents, TipeCrudState> {
	final TipeCrudRepository repository;
	TipeCrudBloc({required this.repository}) : super(const TipeCrudState()) {
		on<TipeCrudUbahEvent>(onUbahTipeCrud);
		on<TipeCrudTambahEvent>(onTambahTipeCrud);
		on<TipeCrudHapusEvent>(onHapusTipeCrud);
		on<TipeCrudLihatEvent>(onLihatTipeCrud);
	}

	Future<void> onTambahTipeCrud(
		TipeCrudTambahEvent event, Emitter<TipeCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.tipeCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahTipeCrud(
		TipeCrudUbahEvent event, Emitter<TipeCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.tipeCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusTipeCrud(
		TipeCrudHapusEvent event, Emitter<TipeCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.tipeCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatTipeCrud(
		TipeCrudLihatEvent event, Emitter<TipeCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		TipeCrudModel record = await repository.tipeCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}