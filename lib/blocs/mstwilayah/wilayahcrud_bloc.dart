import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/models/mstwilayah/wilayahcrud_model.dart';
import 'package:rentcarapp/repositories/mstwilayah/wilayahcrud_repository.dart';

part 'wilayahcrud_event.dart';
part 'wilayahcrud_state.dart';

class WilayahCrudBloc extends Bloc<WilayahCrudEvents, WilayahCrudState> {
	final WilayahCrudRepository repository;
	WilayahCrudBloc({required this.repository}) : super(const WilayahCrudState()) {
		on<WilayahCrudUbahEvent>(onUbahWilayahCrud);
		on<WilayahCrudTambahEvent>(onTambahWilayahCrud);
		on<WilayahCrudHapusEvent>(onHapusWilayahCrud);
		on<WilayahCrudLihatEvent>(onLihatWilayahCrud);
	}

	Future<void> onTambahWilayahCrud(
		WilayahCrudTambahEvent event, Emitter<WilayahCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.wilayahCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahWilayahCrud(
		WilayahCrudUbahEvent event, Emitter<WilayahCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.wilayahCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusWilayahCrud(
		WilayahCrudHapusEvent event, Emitter<WilayahCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.wilayahCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatWilayahCrud(
		WilayahCrudLihatEvent event, Emitter<WilayahCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		WilayahCrudModel record = await repository.wilayahCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}