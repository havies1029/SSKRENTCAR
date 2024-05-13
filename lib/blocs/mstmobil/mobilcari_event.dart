part of 'mobilcari_bloc.dart';

abstract class MobilCariEvents extends Equatable {
	const MobilCariEvents();

	@override
	List<Object> get props => [];
}

class FetchMobilCariEvent extends MobilCariEvents {
	final int hal;
	final String searchText;

	const FetchMobilCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshMobilCariEvent extends MobilCariEvents {
	final int hal;
	final String searchText;

	const RefreshMobilCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahMobilCariEvent extends MobilCariEvents {
	final String recordId;

	const UbahMobilCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahMobilCariEvent extends MobilCariEvents{}
class HapusMobilCariEvent extends MobilCariEvents{}
class CloseDialogMobilCariEvent extends MobilCariEvents{}
