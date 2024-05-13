import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/models/mstmobil/mobilcrud_model.dart';
import 'package:rentcarapp/repositories/mstmobil/mobilcrud_repository.dart';

part 'mobilcrud_event.dart';
part 'mobilcrud_state.dart';

class MobilCrudBloc extends Bloc<MobilCrudEvents, MobilCrudState> {
	final MobilCrudRepository repository;
	MobilCrudBloc({required this.repository}) : super(const MobilCrudState()) {
		on<MobilCrudUbahEvent>(onUbahMobilCrud);
		on<MobilCrudTambahEvent>(onTambahMobilCrud);
		on<MobilCrudHapusEvent>(onHapusMobilCrud);
		on<MobilCrudLihatEvent>(onLihatMobilCrud);
	}

	Future<void> onTambahMobilCrud(
		MobilCrudTambahEvent event, Emitter<MobilCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.mobilCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahMobilCrud(
		MobilCrudUbahEvent event, Emitter<MobilCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.mobilCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusMobilCrud(
		MobilCrudHapusEvent event, Emitter<MobilCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.mobilCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatMobilCrud(
		MobilCrudLihatEvent event, Emitter<MobilCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		MobilCrudModel record = await repository.mobilCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}