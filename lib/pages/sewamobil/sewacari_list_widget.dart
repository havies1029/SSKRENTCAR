import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rentcarapp/widgets/showdialoghapus_widget.dart';
import 'package:rentcarapp/blocs/sewamobil/sewacari_bloc.dart';
import 'package:rentcarapp/blocs/sewamobil/sewacrud_bloc.dart';
import 'package:rentcarapp/pages/sewamobil/sewacari_tile_widget.dart';

class SewaCariListWidget extends StatefulWidget {
	final String searchText;
	const SewaCariListWidget({super.key, required this.searchText});

	@override
	SewaCariListWidgetState createState() => SewaCariListWidgetState();
}

class SewaCariListWidgetState extends State<SewaCariListWidget> {
	late SewaCariBloc sewaCariBloc;
	late SewaCrudBloc sewaCrudBloc;
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
		sewaCariBloc = BlocProvider.of<SewaCariBloc>(context);
		sewaCrudBloc = BlocProvider.of<SewaCrudBloc>(context);
		return BlocConsumer<SewaCariBloc, SewaCariState>(
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
															sewaCariBloc.add(
																UbahSewaCariEvent(
																	recordId: state
																		.items[index]
																		.sewa1Id));
														},
														backgroundColor: Colors.green,
														icon: Icons.edit,
														label: "Edit",
													),
													SlidableAction(
														onPressed: (context) {
															showDialogHapus(
																state.items[index].sewa1Id);
														},
														backgroundColor: Colors.red,
														icon: Icons.delete,
														label: "Delete",
													),
												]),
											child: SewaCariTileWidget(												
												biayaTotal: state.items[index].biayaTotal,
												isLepaskunci: state.items[index].isLepaskunci,												
												masaNama: state.items[index].masaNama,
												platNo: state.items[index].platNo,
												qty: state.items[index].qty,
												customerNama: state.items[index].customerNama,
												akhirTgl: state.items[index].akhirTgl,
												akhirJam: state.items[index].akhirJam,
												mulaiTgl: state.items[index].mulaiTgl,
												mulaiJam: state.items[index].mulaiJam,
												sewa1Id: state.items[index].sewa1Id,
												supirNama: state.items[index].supirNama,												
												tglTrx: state.items[index].tglTrx,
												wilayahNama: state.items[index].wilayahNama,
												statusSewa: state.items[index].statusSewa,
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
			sewaCariBloc.add(FetchSewaCariEvent(
				searchText: widget.searchText, hal: sewaCariBloc.state.hal));
		}
	}

	onHapusFunction(String recordId) {
		sewaCrudBloc.add(SewaCrudHapusEvent(recordId: recordId));
	}

	void showDialogHapus(String recordId) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
			}
		).then((value) {
			sewaCariBloc.add(CloseDialogSewaCariEvent());
		});
	}

}
