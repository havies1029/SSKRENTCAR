part of 'tipecrud_bloc.dart';

abstract class TipeCrudEvents extends Equatable {
	const TipeCrudEvents();

	@override
	List<Object> get props => [];
}

class TipeCrudTambahEvent extends TipeCrudEvents {
	final TipeCrudModel record;
	const TipeCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class TipeCrudUbahEvent extends TipeCrudEvents {
	final TipeCrudModel record;
	const TipeCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class TipeCrudHapusEvent extends TipeCrudEvents {
	final String recordId;
	const TipeCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TipeCrudLihatEvent extends TipeCrudEvents {
	final String recordId;
	const TipeCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

