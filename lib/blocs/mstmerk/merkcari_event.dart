part of 'merkcari_bloc.dart';

abstract class MerkCariEvents extends Equatable {
	const MerkCariEvents();

	@override
	List<Object> get props => [];
}

class FetchMerkCariEvent extends MerkCariEvents {
	final int hal;
	final String searchText;

	const FetchMerkCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class RefreshMerkCariEvent extends MerkCariEvents {
	final int hal;
	final String searchText;

	const RefreshMerkCariEvent({required this.hal, required this.searchText});

	@override
	List<Object> get props => [hal, searchText];
}

class TambahMerkCariEvent extends MerkCariEvents{}
class HapusMerkCariEvent extends MerkCariEvents{}

class UbahMerkCariEvent extends MerkCariEvents{
  final String recordId;

  const UbahMerkCariEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];

}
class CloseDialogMerkCariEvent extends MerkCariEvents{}