import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/listpage_filter_bar_ui.dart';
import 'package:rentcarapp/widgets/floatingmenumaster_widget.dart';
import 'package:rentcarapp/blocs/mstwarna/warnacari_bloc.dart';
import 'package:rentcarapp/blocs/mstwarna/warnacrud_bloc.dart';
import 'package:rentcarapp/pages/mstwarna/warnacrud_form.dart';
import 'package:rentcarapp/pages/mstwarna/warnacari_list_widget.dart';

class WarnaCariPage extends StatefulWidget {
	const WarnaCariPage({super.key});

	@override
	WarnaCariPageState createState() => WarnaCariPageState();
}

class WarnaCariPageState extends State<WarnaCariPage> {
	late WarnaCariBloc warnaCariBloc;
	late WarnaCrudBloc warnaCrudBloc;
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
		warnaCariBloc = BlocProvider.of<WarnaCariBloc>(context);
		warnaCrudBloc = BlocProvider.of<WarnaCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<WarnaCariBloc, WarnaCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<WarnaCrudBloc, WarnaCrudState>(
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
		warnaCariBloc.add(
			RefreshWarnaCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		warnaCariBloc.add(TambahWarnaCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			warnaCariBloc.add(RefreshWarnaCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[WarnaCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return WarnaCrudFormPage(viewMode: viewMode, recordId: recordId);
			},
			useSafeArea: true)
		.then((value) {
			warnaCariBloc.add(CloseDialogWarnaCariEvent());
		});
	}

}
