import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rentcarapp/widgets/showdialoghapus_widget.dart';
import 'package:rentcarapp/blocs/mstwilayah/wilayahcari_bloc.dart';
import 'package:rentcarapp/blocs/mstwilayah/wilayahcrud_bloc.dart';
import 'package:rentcarapp/pages/mstwilayah/wilayahcari_tile_widget.dart';

class WilayahCariListWidget extends StatefulWidget {
	final String searchText;
	const WilayahCariListWidget({super.key, required this.searchText});

	@override
	WilayahCariListWidgetState createState() => WilayahCariListWidgetState();
}

class WilayahCariListWidgetState extends State<WilayahCariListWidget> {
	late WilayahCariBloc wilayahCariBloc;
	late WilayahCrudBloc wilayahCrudBloc;
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
		wilayahCariBloc = BlocProvider.of<WilayahCariBloc>(context);
		wilayahCrudBloc = BlocProvider.of<WilayahCrudBloc>(context);
		return BlocConsumer<WilayahCariBloc, WilayahCariState>(
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
															wilayahCariBloc.add(
																UbahWilayahCariEvent(
																	recordId: state
																		.items[index]
																		.mwilayahId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mwilayahId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: WilayahCariTileWidget(
												mwilayahId: state.items[index].mwilayahId,
												wilayahNama: state.items[index].wilayahNama,
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
			wilayahCariBloc.add(FetchWilayahCariEvent(
				searchText: widget.searchText, hal: wilayahCariBloc.state.hal));
		}
	}

	onHapusFunction(String recordId) {
		wilayahCrudBloc.add(WilayahCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			wilayahCariBloc.add(CloseDialogWilayahCariEvent());
		});
	}

}
