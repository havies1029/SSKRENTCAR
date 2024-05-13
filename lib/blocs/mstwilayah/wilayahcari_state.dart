part of 'wilayahcari_bloc.dart';

enum ListStatus { initial, success, failure }

class WilayahCariState extends Equatable {

	final ListStatus status;
	final List<WilayahCariModel> items;
	final bool hasReachedMax;
	final int hal;
	final String viewMode;
	final String recordId;

	const WilayahCariState(
		{this.status = ListStatus.initial,
		this.items = const <WilayahCariModel>[],
		this.hasReachedMax = false,
		this.hal = 0,
		this.viewMode = "",
		this.recordId = ""});

	const WilayahCariState.success(List<WilayahCariModel> items)
			: this(status: ListStatus.success, items: items);

	const WilayahCariState.failure() : this(status: ListStatus.failure);

	WilayahCariState copyWith(
		{List<WilayahCariModel>? items,
		bool? hasReachedMax,
		ListStatus? status,
		int? hal,
		String? viewMode,
		String? recordId}) {
		return WilayahCariState(
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
