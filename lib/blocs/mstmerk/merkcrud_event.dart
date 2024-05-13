part of 'merkcrud_bloc.dart';

abstract class MerkCrudEvents extends Equatable {
	const MerkCrudEvents();

	@override
	List<Object> get props => [];
}

class MerkCrudTambahEvent extends MerkCrudEvents {
	final MerkCrudModel record;
	const MerkCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class MerkCrudUbahEvent extends MerkCrudEvents {
	final MerkCrudModel record;
	const MerkCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class MerkCrudHapusEvent extends MerkCrudEvents {
	final String recordId;
	const MerkCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class MerkCrudLihatEvent extends MerkCrudEvents {
	final String recordId;
	const MerkCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

