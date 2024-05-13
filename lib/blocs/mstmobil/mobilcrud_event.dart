part of 'mobilcrud_bloc.dart';

abstract class MobilCrudEvents extends Equatable {
	const MobilCrudEvents();

	@override
	List<Object> get props => [];
}

class MobilCrudTambahEvent extends MobilCrudEvents {
	final MobilCrudModel record;
	const MobilCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class MobilCrudUbahEvent extends MobilCrudEvents {
	final MobilCrudModel record;
	const MobilCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class MobilCrudHapusEvent extends MobilCrudEvents {
	final String recordId;
	const MobilCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class MobilCrudLihatEvent extends MobilCrudEvents {
	final String recordId;
	const MobilCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

