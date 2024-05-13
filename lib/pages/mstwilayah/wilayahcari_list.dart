import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/listpage_filter_bar_ui.dart';
import 'package:rentcarapp/widgets/floatingmenumaster_widget.dart';
import 'package:rentcarapp/blocs/mstwilayah/wilayahcari_bloc.dart';
import 'package:rentcarapp/blocs/mstwilayah/wilayahcrud_bloc.dart';
import 'package:rentcarapp/pages/mstwilayah/wilayahcrud_form.dart';
import 'package:rentcarapp/pages/mstwilayah/wilayahcari_list_widget.dart';

class WilayahCariPage extends StatefulWidget {
	const WilayahCariPage({super.key});

	@override
	WilayahCariPageState createState() => WilayahCariPageState();
}

class WilayahCariPageState extends State<WilayahCariPage> {
	late WilayahCariBloc wilayahCariBloc;
	late WilayahCrudBloc wilayahCrudBloc;
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
		wilayahCariBloc = BlocProvider.of<WilayahCariBloc>(context);
		wilayahCrudBloc = BlocProvider.of<WilayahCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<WilayahCariBloc, WilayahCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<WilayahCrudBloc, WilayahCrudState>(
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
		wilayahCariBloc.add(
			RefreshWilayahCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		wilayahCariBloc.add(TambahWilayahCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			wilayahCariBloc.add(RefreshWilayahCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[WilayahCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return WilayahCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			wilayahCariBloc.add(CloseDialogWilayahCariEvent());
		});
	}

}
