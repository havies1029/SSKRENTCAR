import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/listpage_filter_bar_ui.dart';
import 'package:rentcarapp/widgets/floatingmenumaster_widget.dart';
import 'package:rentcarapp/blocs/mstmasa/masacari_bloc.dart';
import 'package:rentcarapp/blocs/mstmasa/masacrud_bloc.dart';
import 'package:rentcarapp/pages/mstmasa/masacrud_form.dart';
import 'package:rentcarapp/pages/mstmasa/masacari_list_widget.dart';

class MasaCariPage extends StatefulWidget {
	const MasaCariPage({super.key});

	@override
	MasaCariPageState createState() => MasaCariPageState();
}

class MasaCariPageState extends State<MasaCariPage> {
	late MasaCariBloc masaCariBloc;
	late MasaCrudBloc masaCrudBloc;
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
		masaCariBloc = BlocProvider.of<MasaCariBloc>(context);
		masaCrudBloc = BlocProvider.of<MasaCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<MasaCariBloc, MasaCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<MasaCrudBloc, MasaCrudState>(
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
		masaCariBloc.add(
			RefreshMasaCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		masaCariBloc.add(TambahMasaCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			masaCariBloc.add(RefreshMasaCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[MasaCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return MasaCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			masaCariBloc.add(CloseDialogMasaCariEvent());
		});
	}

}
