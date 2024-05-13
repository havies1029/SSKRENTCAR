import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rentcarapp/widgets/showdialoghapus_widget.dart';
import 'package:rentcarapp/blocs/mstwarna/warnacari_bloc.dart';
import 'package:rentcarapp/blocs/mstwarna/warnacrud_bloc.dart';
import 'package:rentcarapp/pages/mstwarna/warnacari_tile_widget.dart';

class WarnaCariListWidget extends StatefulWidget {
	final String searchText;
	const WarnaCariListWidget({super.key, required this.searchText});

	@override
	WarnaCariListWidgetState createState() => WarnaCariListWidgetState();
}

class WarnaCariListWidgetState extends State<WarnaCariListWidget> {
	late WarnaCariBloc warnaCariBloc;
	late WarnaCrudBloc warnaCrudBloc;
	final ScrollController _scrollController = ScrollController();

	@override
	void initState() {
		super.initState();
		_scrollController.addListener(_onScroll);
	}

	@override
	void dispose() {
		_scrollController
			..removeListener(_onScroll)
			..dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		warnaCariBloc = BlocProvider.of<WarnaCariBloc>(context);
		warnaCrudBloc = BlocProvider.of<WarnaCrudBloc>(context);
		return BlocConsumer<WarnaCariBloc, WarnaCariState>(
			builder: (context, state) {
			if (state.status == ListStatus.success) {
			return state.items.isNotEmpty
				? Flexible(
					child: ListView.builder(
						padding: EdgeInsets.zero,
						controller: _scrollController,
						itemCount: state.items.length,
						itemBuilder: (_, index) => Container(
							margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
							padding: const EdgeInsets.all(0.2),
							decoration: BoxDecoration(
								borderRadius: BorderRadius.circular(15.0)),
							child: Column(
								children: <Widget>[
									Slidable(
										endActionPane: ActionPane(
											motion: const BehindMotion(),
												children: [
													SlidableAction(
														onPressed: (context) {
															warnaCariBloc.add(
																UbahWarnaCariEvent(
																	recordId: state
																		.items[index]
																		.mwarnaId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mwarnaId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: WarnaCariTileWidget(
												mwarnaId: state.items[index].mwarnaId,
												warnaNama: state.items[index].warnaNama,
											)),
							],
						),
					)),
				)
			: const Center(
				child: Padding(
					padding: EdgeInsets.only(top: 80.0),
					child: Text(
						'No Data Available!!',
						style: TextStyle(
							color: Colors.red,
							fontSize: 12.0,
							fontWeight: FontWeight.bold),
					),
				),
			);
		} else {
			return const Center(
					child: Text(
						'No Data Available!!',
						style: TextStyle(
							color: Colors.red,
							fontSize: 12.0,
							fontWeight: FontWeight.bold),
					),
				);
			}
			}, buildWhen: (previous, current) {
				return (current.status == ListStatus.success);
			}, listener: (context, state) {}
		);
	}
	void _onScroll() {
		if (!_scrollController.hasClients) return;
		if (_scrollController.position.pixels ==
				_scrollController.position.maxScrollExtent) {
			warnaCariBloc.add(FetchWarnaCariEvent(
				searchText: widget.searchText, hal: warnaCariBloc.state.hal));
		}
	}

	onHapusFunction(String recordId) {
		warnaCrudBloc.add(WarnaCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			warnaCariBloc.add(CloseDialogWarnaCariEvent());
		});
	}

}
