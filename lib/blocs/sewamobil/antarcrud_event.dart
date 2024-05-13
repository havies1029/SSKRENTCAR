part of 'antarcrud_bloc.dart';

abstract class AntarCrudEvents extends Equatable {
	const AntarCrudEvents();

	@override
	List<Object> get props => [];
}

class AntarCrudTambahEvent extends AntarCrudEvents {
	final AntarCrudModel record;
	const AntarCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class AntarCrudUbahEvent extends AntarCrudEvents {
	final AntarCrudModel record;
	const AntarCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class AntarCrudHapusEvent extends AntarCrudEvents {
	final String recordId;
	const AntarCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class AntarCrudLihatEvent extends AntarCrudEvents {
	final String recordId;
	const AntarCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class ComboSupirChangedEvent extends AntarCrudEvents{
	final ComboSupirModel comboSupir;
	const ComboSupirChangedEvent({required this.comboSupir});

	@override	List<Object> get props => [comboSupir];}

