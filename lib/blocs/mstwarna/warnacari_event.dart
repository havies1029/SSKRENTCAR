part of 'warnacari_bloc.dart';

abstract class WarnaCariEvents extends Equatable {
	const WarnaCariEvents();

	@override
	List<Object> get props => [];
}

class FetchWarnaCariEvent extends WarnaCariEvents {
	final int hal;
	final String searchText;

	const FetchWarnaCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshWarnaCariEvent extends WarnaCariEvents {
	final int hal;
	final String searchText;

	const RefreshWarnaCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahWarnaCariEvent extends WarnaCariEvents {
	final String recordId;

	const UbahWarnaCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahWarnaCariEvent extends WarnaCariEvents{}
class HapusWarnaCariEvent extends WarnaCariEvents{}
class CloseDialogWarnaCariEvent extends WarnaCariEvents{}
