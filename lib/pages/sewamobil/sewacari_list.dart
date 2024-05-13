import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/pages/sewamobil/sewacrud_main.dart';
import 'package:rentcarapp/widgets/listpage_filter_bar_ui.dart';
import 'package:rentcarapp/widgets/floatingmenumaster_widget.dart';
import 'package:rentcarapp/blocs/sewamobil/sewacari_bloc.dart';
import 'package:rentcarapp/blocs/sewamobil/sewacrud_bloc.dart';
import 'package:rentcarapp/pages/sewamobil/sewacari_list_widget.dart';

class SewaCariPage extends StatefulWidget {
	const SewaCariPage({super.key});

	@override
	SewaCariPageState createState() => SewaCariPageState();
}

class SewaCariPageState extends State<SewaCariPage> {
	late SewaCariBloc sewaCariBloc;
	late SewaCrudBloc sewaCrudBloc;
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
		sewaCariBloc = BlocProvider.of<SewaCariBloc>(context);
		sewaCrudBloc = BlocProvider.of<SewaCrudBloc>(context);

		return MultiBlocListener(
			listeners: [
				BlocListener<SewaCariBloc, SewaCariState>(
					listener: (context, state) {
						if (state.viewMode == "tambah") {
							showDialogViewData(context, state.viewMode, "");
						} else if (state.viewMode == "ubah") {
							showDialogViewData(context, state.viewMode, state.recordId);
						}
				}, listenWhen: (previous, current) {
					return previous.viewMode != current.viewMode;
				}),
				BlocListener<SewaCrudBloc, SewaCrudState>(
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
		sewaCariBloc.add(
			RefreshSewaCariEvent(searchText: _searchController.text, hal: 0));
	}

	void onTambahData() {
		sewaCariBloc.add(TambahSewaCariEvent());
	}

	IconButton buildSearchButton() {
		return IconButton(
			icon: const Icon(
				Icons.autorenew_rounded,
				size: 35.0,
			),
			onPressed: () {
			sewaCariBloc.add(RefreshSewaCariEvent(
				searchText: _searchController.text, hal: 0));
			});
	}

	Widget buildList() {
		return Expanded(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[SewaCariListWidget(searchText: _searchController.text)],
		));
	}

	void showDialogViewData(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {        
        return SewaCrudMainPage(viewMode: viewMode, recordId: recordId);
      }),
    ).then((value) {
      return sewaCariBloc.add(CloseDialogSewaCariEvent());
    });
	}
}
