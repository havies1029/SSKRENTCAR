part of 'wilayahcari_bloc.dart';

abstract class WilayahCariEvents extends Equatable {
	const WilayahCariEvents();

	@override
	List<Object> get props => [];
}

class FetchWilayahCariEvent extends WilayahCariEvents {
	final int hal;
	final String searchText;

	const FetchWilayahCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshWilayahCariEvent extends WilayahCariEvents {
	final int hal;
	final String searchText;

	const RefreshWilayahCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class UbahWilayahCariEvent extends WilayahCariEvents {
	final String recordId;

	const UbahWilayahCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class TambahWilayahCariEvent extends WilayahCariEvents{}
class HapusWilayahCariEvent extends WilayahCariEvents{}
class CloseDialogWilayahCariEvent extends WilayahCariEvents{}
