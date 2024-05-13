part of 'tipecari_bloc.dart';

enum ListStatus { initial, success, failure }

class TipeCariState extends Equatable {

	final ListStatus status;
	final List<TipeCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const TipeCariState(
		{this.status = ListStatus.initial,
		this.items = const <TipeCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const TipeCariState.success(List<TipeCariModel> items)
			: this(status: ListStatus.success, items: items);

	const TipeCariState.failure() : this(status: ListStatus.failure);

	TipeCariState copyWith(
		{List<TipeCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return TipeCariState(
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
