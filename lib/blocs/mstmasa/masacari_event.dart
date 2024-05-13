part of 'masacari_bloc.dart';

abstract class MasaCariEvents extends Equatable {
	const MasaCariEvents();

	@override
	List<Object> get props => [];
}

class FetchMasaCariEvent extends MasaCariEvents {
	final int hal;
	final String searchText;

	const FetchMasaCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshMasaCariEvent extends MasaCariEvents {
	final int hal;
	final String searchText;

	const RefreshMasaCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahMasaCariEvent extends MasaCariEvents {
	final String recordId;

	const UbahMasaCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahMasaCariEvent extends MasaCariEvents{}
class HapusMasaCariEvent extends MasaCariEvents{}
class CloseDialogMasaCariEvent extends MasaCariEvents{}
