part of 'sewacari_bloc.dart';

enum ListStatus { initial, success, failure }

class SewaCariState extends Equatable {

	final ListStatus status;
	final List<SewaCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const SewaCariState(
		{this.status = ListStatus.initial,
		this.items = const <SewaCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const SewaCariState.success(List<SewaCariModel> items)
			: this(status: ListStatus.success, items: items);

	const SewaCariState.failure() : this(status: ListStatus.failure);

	SewaCariState copyWith(
		{List<SewaCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return SewaCariState(
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
