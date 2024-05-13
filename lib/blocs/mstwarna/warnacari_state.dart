part of 'warnacari_bloc.dart';

enum ListStatus { initial, success, failure }

class WarnaCariState extends Equatable {

	final ListStatus status;
	final List<WarnaCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const WarnaCariState(
		{this.status = ListStatus.initial,
		this.items = const <WarnaCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const WarnaCariState.success(List<WarnaCariModel> items)
			: this(status: ListStatus.success, items: items);

	const WarnaCariState.failure() : this(status: ListStatus.failure);

	WarnaCariState copyWith(
		{List<WarnaCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return WarnaCariState(
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
