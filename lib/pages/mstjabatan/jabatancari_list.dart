import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/listpage_filter_bar_ui.dart';
import 'package:rentcarapp/widgets/floatingmenumaster_widget.dart';
import 'package:rentcarapp/blocs/mstjabatan/jabatancari_bloc.dart';
import 'package:rentcarapp/blocs/mstjabatan/jabatancrud_bloc.dart';
import 'package:rentcarapp/pages/mstjabatan/jabatancrud_form.dart';
import 'package:rentcarapp/pages/mstjabatan/jabatancari_list_widget.dart';

class JabatanCariPage extends StatefulWidget {
	const JabatanCariPage({super.key});

	@override
	JabatanCariPageState createState() => JabatanCariPageState();
}

class JabatanCariPageState extends State<JabatanCariPage> {
	late JabatanCariBloc jabatanCariBloc;
	late JabatanCrudBloc jabatanCrudBloc;
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
		jabatanCariBloc = BlocProvider.of<JabatanCariBloc>(context);
		jabatanCrudBloc = BlocProvider.of<JabatanCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<JabatanCariBloc, JabatanCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<JabatanCrudBloc, JabatanCrudState>(
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
		jabatanCariBloc.add(
			RefreshJabatanCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		jabatanCariBloc.add(TambahJabatanCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			jabatanCariBloc.add(RefreshJabatanCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[JabatanCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return JabatanCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			jabatanCariBloc.add(CloseDialogJabatanCariEvent());
		});
	}

}
