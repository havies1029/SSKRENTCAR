part of 'hargacrud_bloc.dart';

abstract class HargaCrudEvents extends Equatable {
	const HargaCrudEvents();

	@override
	List<Object> get props => [];
}

class HargaCrudTambahEvent extends HargaCrudEvents {
	final HargaCrudModel record;
	const HargaCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class HargaCrudUbahEvent extends HargaCrudEvents {
	final HargaCrudModel record;
	const HargaCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class HargaCrudHapusEvent extends HargaCrudEvents {
	final String recordId;
	const HargaCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class HargaCrudLihatEvent extends HargaCrudEvents {
	final String recordId;
	const HargaCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

