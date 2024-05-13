part of 'merkcari_bloc.dart';

enum ListStatus { initial, success, failure }

class MerkCariState extends Equatable {
  final ListStatus status;
  final List<MerkCariModel> items;
  final bool hasReachedMax;
  final int hal;
  final String viewMode;
  final String recordId;

  const MerkCariState(
      {this.status = ListStatus.initial,
      this.items = const <MerkCariModel>[],
      this.hasReachedMax = false,
      this.hal = 0,
      this.viewMode = "",
      this.recordId = ""});

  const MerkCariState.success(List<MerkCariModel> items)
      : this(status: ListStatus.success, items: items);

  const MerkCariState.failure() : this(status: ListStatus.failure);

  MerkCariState copyWith(
      {List<MerkCariModel>? items,
      bool? hasReachedMax,
      ListStatus? status,
      int? hal,
      String? viewMode,
      String? recordId}) {
    return MerkCariState(
        items: items ?? this.items,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status,
        hal: hal ?? this.hal,
        viewMode: viewMode ?? this.viewMode,
        recordId: recordId ?? this.recordId);
  }

  @override
  List<Object> get props => [status, items, hasReachedMax, hal, viewMode, recordId];
}
