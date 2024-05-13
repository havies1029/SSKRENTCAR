import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/listpage_filter_bar_ui.dart';
import 'package:rentcarapp/widgets/floatingmenumaster_widget.dart';
import 'package:rentcarapp/blocs/msttipe/tipecari_bloc.dart';
import 'package:rentcarapp/blocs/msttipe/tipecrud_bloc.dart';
import 'package:rentcarapp/pages/msttipe/tipecrud_form.dart';
import 'package:rentcarapp/pages/msttipe/tipecari_list_widget.dart';

class TipeCariPage extends StatefulWidget {
	const TipeCariPage({super.key});

	@override
	TipeCariPageState createState() => TipeCariPageState();
}

class TipeCariPageState extends State<TipeCariPage> {
	late TipeCariBloc tipeCariBloc;
	late TipeCrudBloc tipeCrudBloc;
	final TextEditingController _searchController = TextEditingController();
	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			refreshData();
		});
	}

	@override
	Widget build(BuildContext context) {
		tipeCariBloc = BlocProvider.of<TipeCariBloc>(context);
		tipeCrudBloc = BlocProvider.of<TipeCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<TipeCariBloc, TipeCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<TipeCrudBloc, TipeCrudState>(
					listener: (context, state) {
						if (state.isSaved) {
							refreshData();
						}
				}, listenWhen: (previous, current) {
					return previous.isSaved != current.isSaved;
				}),
			],
			child: Scaffold(
        backgroundColor: Colors.grey[200],
				floatingActionButton: FloatingMenuMasterWidget(
					onTambah: onTambahData),
				body: Center(
					child: Column(
						mainAxisAlignment: MainAxisAlignment.start,
						children: [
							ListPageFilterBarUIWidget(
								searchController: _searchController,
								searchButton: buildSearchButton()),
							buildList()
						],

					),
				),
			));
	}

	void refreshData() {
		tipeCariBloc.add(
			RefreshTipeCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		tipeCariBloc.add(TambahTipeCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			tipeCariBloc.add(RefreshTipeCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[TipeCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return TipeCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			tipeCariBloc.add(CloseDialogTipeCariEvent());
		});
	}

}
