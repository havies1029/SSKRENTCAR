part of 'mobilcari_bloc.dart';

enum ListStatus { initial, success, failure }

class MobilCariState extends Equatable {

	final ListStatus status;
	final List<MobilCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const MobilCariState(
		{this.status = ListStatus.initial,
		this.items = const <MobilCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const MobilCariState.success(List<MobilCariModel> items)
			: this(status: ListStatus.success, items: items);

	const MobilCariState.failure() : this(status: ListStatus.failure);

	MobilCariState copyWith(
		{List<MobilCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return MobilCariState(
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
