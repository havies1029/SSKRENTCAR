part of 'tipecari_bloc.dart';

abstract class TipeCariEvents extends Equatable {
	const TipeCariEvents();

	@override
	List<Object> get props => [];
}

class FetchTipeCariEvent extends TipeCariEvents {
	final int hal;
	final String searchText;

	const FetchTipeCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshTipeCariEvent extends TipeCariEvents {
	final int hal;
	final String searchText;

	const RefreshTipeCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahTipeCariEvent extends TipeCariEvents {
	final String recordId;

	const UbahTipeCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahTipeCariEvent extends TipeCariEvents{}
class HapusTipeCariEvent extends TipeCariEvents{}
class CloseDialogTipeCariEvent extends TipeCariEvents{}
