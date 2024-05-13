part of 'wilayahcrud_bloc.dart';

abstract class WilayahCrudEvents extends Equatable {
	const WilayahCrudEvents();

	@override
	List<Object> get props => [];
}

class WilayahCrudTambahEvent extends WilayahCrudEvents {
	final WilayahCrudModel record;
	const WilayahCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class WilayahCrudUbahEvent extends WilayahCrudEvents {
	final WilayahCrudModel record;
	const WilayahCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class WilayahCrudHapusEvent extends WilayahCrudEvents {
	final String recordId;
	const WilayahCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class WilayahCrudLihatEvent extends WilayahCrudEvents {
	final String recordId;
	const WilayahCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

