part of 'sewacari_bloc.dart';

abstract class SewaCariEvents extends Equatable {
	const SewaCariEvents();

	@override
	List<Object> get props => [];
}

class FetchSewaCariEvent extends SewaCariEvents {
	final int hal;
	final String searchText;

	const FetchSewaCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshSewaCariEvent extends SewaCariEvents {
	final int hal;
	final String searchText;

	const RefreshSewaCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahSewaCariEvent extends SewaCariEvents {
	final String recordId;

	const UbahSewaCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahSewaCariEvent extends SewaCariEvents{}
class HapusSewaCariEvent extends SewaCariEvents{}
class CloseDialogSewaCariEvent extends SewaCariEvents{}
