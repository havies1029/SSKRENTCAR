import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/blocs/mstmerk/merkcrud_bloc.dart';
import 'package:rentcarapp/pages/mstmerk/merkcrud_form.dart';
import 'package:rentcarapp/widgets/floatingmenumaster_widget.dart';
import 'package:rentcarapp/widgets/listpage_filter_bar_ui.dart';
import 'package:rentcarapp/blocs/mstmerk/merkcari_bloc.dart';
import 'package:rentcarapp/pages/mstmerk/merkcari_list_widget.dart';

class MerkCariPage extends StatefulWidget {
  const MerkCariPage({super.key});

  @override
  MerkCariPageState createState() => MerkCariPageState();
}

class MerkCariPageState extends State<MerkCariPage> {
  late MerkCariBloc merkCariBloc;
  late MerkCrudBloc merkCrudBloc;
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
    merkCariBloc = BlocProvider.of<MerkCariBloc>(context);
    merkCrudBloc = BlocProvider.of<MerkCrudBloc>(context);

    return MultiBlocListener(
        listeners: [
          BlocListener<MerkCariBloc, MerkCariState>(
            listener: (context, state) {
              if (state.viewMode == "tambah") {
                showDialogViewData(context, state.viewMode, "");
              } else if (state.viewMode == "ubah") {
                showDialogViewData(context, state.viewMode, state.recordId);                
              }
          }, listenWhen: (previous, current) {
            return previous.viewMode != current.viewMode;
          }),
          BlocListener<MerkCrudBloc, MerkCrudState>(listener: (context, state) {
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
    merkCariBloc
        .add(RefreshMerkCariEvent(searchText: _searchController.text, hal: 0));
  }

  void onTambahData() {
    debugPrint("onTambahData");    
    merkCariBloc.add(TambahMerkCariEvent());
  }

  IconButton buildSearchButton() {
    return IconButton(
        icon: const Icon(
          Icons.autorenew_rounded,
          size: 35.0,
        ),
        onPressed: () {
          merkCariBloc.add(
              RefreshMerkCariEvent(searchText: _searchController.text, hal: 0));
        });
  }

  Widget buildList() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        MerkCariListWidget(searchText: _searchController.text)
      ],
    ));
  }

  void showDialogViewData(BuildContext context, String viewMode, String recordId) {
    FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return MerkCrudFormPage(viewMode: viewMode, recordId: recordId);
      },
      useSafeArea: true)
    .then((value) {
      merkCariBloc.add(CloseDialogMerkCariEvent());
    });
  }
}
