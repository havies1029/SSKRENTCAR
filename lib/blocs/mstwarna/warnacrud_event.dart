part of 'warnacrud_bloc.dart';

abstract class WarnaCrudEvents extends Equatable {
	const WarnaCrudEvents();

	@override
	List<Object> get props => [];
}

class WarnaCrudTambahEvent extends WarnaCrudEvents {
	final WarnaCrudModel record;
	const WarnaCrudTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class WarnaCrudUbahEvent extends WarnaCrudEvents {
	final WarnaCrudModel record;
	const WarnaCrudUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class WarnaCrudHapusEvent extends WarnaCrudEvents {
	final String recordId;
	const WarnaCrudHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class WarnaCrudLihatEvent extends WarnaCrudEvents {
	final String recordId;
	const WarnaCrudLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

