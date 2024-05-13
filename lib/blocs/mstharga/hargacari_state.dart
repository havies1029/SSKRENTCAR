part of 'hargacari_bloc.dart';

enum ListStatus { initial, success, failure }

class HargaCariState extends Equatable {

	final ListStatus status;
	final List<HargaCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const HargaCariState(
		{this.status = ListStatus.initial,
		this.items = const <HargaCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const HargaCariState.success(List<HargaCariModel> items)
			: this(status: ListStatus.success, items: items);

	const HargaCariState.failure() : this(status: ListStatus.failure);

	HargaCariState copyWith(
		{List<HargaCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return HargaCariState(
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
