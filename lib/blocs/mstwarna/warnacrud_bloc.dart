import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/models/responseAPI/returndataapi_model.dart';
import 'package:rentcarapp/models/mstwarna/warnacrud_model.dart';
import 'package:rentcarapp/repositories/mstwarna/warnacrud_repository.dart';

part 'warnacrud_event.dart';
part 'warnacrud_state.dart';

class WarnaCrudBloc extends Bloc<WarnaCrudEvents, WarnaCrudState> {
	final WarnaCrudRepository repository;
	WarnaCrudBloc({required this.repository}) : super(const WarnaCrudState()) {
		on<WarnaCrudUbahEvent>(onUbahWarnaCrud);
		on<WarnaCrudTambahEvent>(onTambahWarnaCrud);
		on<WarnaCrudHapusEvent>(onHapusWarnaCrud);
		on<WarnaCrudLihatEvent>(onLihatWarnaCrud);
	}

	Future<void> onTambahWarnaCrud(
		WarnaCrudTambahEvent event, Emitter<WarnaCrudState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isSaving: true, isSaved: false));
		returnData = await repository.warnaCrudTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isSaving: false,
			isSaved: true,
			hasFailure: hasFailure));
	}

	Future<void> onUbahWarnaCrud(
		WarnaCrudUbahEvent event, Emitter<WarnaCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.warnaCrudUbah(event.record);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onHapusWarnaCrud(
		WarnaCrudHapusEvent event, Emitter<WarnaCrudState> emit) async {
		emit(state.copyWith(isSaving: true, isSaved: false));
		bool hasFailure = !await repository.warnaCrudHapus(event.recordId);
		emit(state.copyWith(isSaving: false, isSaved: true, hasFailure: hasFailure));
	}

	Future<void> onLihatWarnaCrud(
		WarnaCrudLihatEvent event, Emitter<WarnaCrudState> emit) async {
		emit(state.copyWith(isLoading: true, isLoaded: false));
		WarnaCrudModel record = await repository.warnaCrudLihat(event.recordId);
		emit(state.copyWith(isLoading: false, isLoaded: true, record: record));
	}

}