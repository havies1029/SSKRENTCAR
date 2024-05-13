part of 'masacrud_bloc.dart';

abstract class MasaCrudEvents extends Equatable {
	const MasaCrudEvents();

	@override
	List<Object> get props => [];
}

class MasaCrudTambahEvent extends MasaCrudEvents {
	final MasaCrudModel record;
	const MasaCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class MasaCrudUbahEvent extends MasaCrudEvents {
	final MasaCrudModel record;
	const MasaCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class MasaCrudHapusEvent extends MasaCrudEvents {
	final String recordId;
	const MasaCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class MasaCrudLihatEvent extends MasaCrudEvents {
	final String recordId;
	const MasaCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

