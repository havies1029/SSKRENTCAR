part of 'hargacari_bloc.dart';

abstract class HargaCariEvents extends Equatable {
	const HargaCariEvents();

	@override
	List<Object> get props => [];
}

class FetchHargaCariEvent extends HargaCariEvents {
	final int hal;
	final String searchText;

	const FetchHargaCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshHargaCariEvent extends HargaCariEvents {
	final int hal;
	final String searchText;

	const RefreshHargaCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahHargaCariEvent extends HargaCariEvents {
	final String recordId;

	const UbahHargaCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahHargaCariEvent extends HargaCariEvents{}
class HapusHargaCariEvent extends HargaCariEvents{}
class CloseDialogHargaCariEvent extends HargaCariEvents{}
