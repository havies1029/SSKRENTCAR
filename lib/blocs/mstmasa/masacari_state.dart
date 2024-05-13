part of 'masacari_bloc.dart';

enum ListStatus { initial, success, failure }

class MasaCariState extends Equatable {

	final ListStatus status;
	final List<MasaCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const MasaCariState(
		{this.status = ListStatus.initial,
		this.items = const <MasaCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const MasaCariState.success(List<MasaCariModel> items)
			: this(status: ListStatus.success, items: items);

	const MasaCariState.failure() : this(status: ListStatus.failure);

	MasaCariState copyWith(
		{List<MasaCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return MasaCariState(
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
