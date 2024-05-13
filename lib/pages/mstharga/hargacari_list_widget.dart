import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rentcarapp/widgets/showdialoghapus_widget.dart';
import 'package:rentcarapp/blocs/mstharga/hargacari_bloc.dart';
import 'package:rentcarapp/blocs/mstharga/hargacrud_bloc.dart';
import 'package:rentcarapp/pages/mstharga/hargacari_tile_widget.dart';

class HargaCariListWidget extends StatefulWidget {
	final String searchText;
	const HargaCariListWidget({super.key, required this.searchText});

	@override
	HargaCariListWidgetState createState() => HargaCariListWidgetState();
}

class HargaCariListWidgetState extends State<HargaCariListWidget> {
	late HargaCariBloc hargaCariBloc;
	late HargaCrudBloc hargaCrudBloc;
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
		hargaCariBloc = BlocProvider.of<HargaCariBloc>(context);
		hargaCrudBloc = BlocProvider.of<HargaCrudBloc>(context);
		return BlocConsumer<HargaCariBloc, HargaCariState>(
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
															hargaCariBloc.add(
																UbahHargaCariEvent(
																	recordId: state
																		.items[index]
																		.mhargaId));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].mhargaId);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: HargaCariTileWidget(
												harga: state.items[index].harga,
												curr: state.items[index].curr,
												mhargaId: state.items[index].mhargaId,
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
			hargaCariBloc.add(FetchHargaCariEvent(
				searchText: widget.searchText, hal: hargaCariBloc.state.hal));
		}
	}

	onHapusFunction(String recordId) {
		hargaCrudBloc.add(HargaCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			hargaCariBloc.add(CloseDialogHargaCariEvent());
		});
	}

}
