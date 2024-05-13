import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/listpage_filter_bar_ui.dart';
import 'package:rentcarapp/widgets/floatingmenumaster_widget.dart';
import 'package:rentcarapp/blocs/mstharga/hargacari_bloc.dart';
import 'package:rentcarapp/blocs/mstharga/hargacrud_bloc.dart';
import 'package:rentcarapp/pages/mstharga/hargacrud_form.dart';
import 'package:rentcarapp/pages/mstharga/hargacari_list_widget.dart';

class HargaCariPage extends StatefulWidget {
	const HargaCariPage({super.key});

	@override
	HargaCariPageState createState() => HargaCariPageState();
}

class HargaCariPageState extends State<HargaCariPage> {
	late HargaCariBloc hargaCariBloc;
	late HargaCrudBloc hargaCrudBloc;
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
		hargaCariBloc = BlocProvider.of<HargaCariBloc>(context);
		hargaCrudBloc = BlocProvider.of<HargaCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<HargaCariBloc, HargaCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<HargaCrudBloc, HargaCrudState>(
					listener: (context, state) {
						if (state.isSaved) {
							refreshData();
						}
				}, listenWhen: (previous, current) {
					return previous.isSaved != current.isSaved;
				}),
			],
			child: Scaffold(
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
		hargaCariBloc.add(
			RefreshHargaCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		hargaCariBloc.add(TambahHargaCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			hargaCariBloc.add(RefreshHargaCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[HargaCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return HargaCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			hargaCariBloc.add(CloseDialogHargaCariEvent());
		});
	}

}
