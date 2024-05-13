import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/pages/mstmobil/mobilcrud_main.dart';
import 'package:rentcarapp/widgets/listpage_filter_bar_ui.dart';
import 'package:rentcarapp/widgets/floatingmenumaster_widget.dart';
import 'package:rentcarapp/blocs/mstmobil/mobilcari_bloc.dart';
import 'package:rentcarapp/blocs/mstmobil/mobilcrud_bloc.dart';
import 'package:rentcarapp/pages/mstmobil/mobilcari_list_widget.dart';

class MobilCariPage extends StatefulWidget {
  const MobilCariPage({super.key});

  @override
  MobilCariPageState createState() => MobilCariPageState();
}

class MobilCariPageState extends State<MobilCariPage> {
  late MobilCariBloc mobilCariBloc;
  late MobilCrudBloc mobilCrudBloc;
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
    mobilCariBloc = BlocProvider.of<MobilCariBloc>(context);
    mobilCrudBloc = BlocProvider.of<MobilCrudBloc>(context);

    return MultiBlocListener(
        listeners: [
          BlocListener<MobilCariBloc, MobilCariState>(
              listener: (context, state) {
            if (state.viewMode == "tambah") {
              showDialogViewData(context, state.viewMode, "");
            } else if (state.viewMode == "ubah") {
              showDialogViewData(context, state.viewMode, state.recordId);
            }
          }, listenWhen: (previous, current) {
            return previous.viewMode != current.viewMode;
          }),
          BlocListener<MobilCrudBloc, MobilCrudState>(
              listener: (context, state) {
            if (state.isSaved) {
              refreshData();
            }
          }, listenWhen: (previous, current) {
            return previous.isSaved != current.isSaved;
          }),
        ],
        child: Scaffold(
          floatingActionButton:
              FloatingMenuMasterWidget(onTambah: onTambahData),
          backgroundColor: Colors.grey[200],
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
    mobilCariBloc
        .add(RefreshMobilCariEvent(searchText: _searchController.text, hal: 0));
  }

  void onTambahData() {
    mobilCariBloc.add(TambahMobilCariEvent());
  }

  IconButton buildSearchButton() {
    return IconButton(
        icon: const Icon(
          Icons.autorenew_rounded,
          size: 35.0,
        ),
        onPressed: () {
          mobilCariBloc.add(RefreshMobilCariEvent(
              searchText: _searchController.text, hal: 0));
        });
  }

  Widget buildList() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        MobilCariListWidget(searchText: _searchController.text)
      ],
    ));
  }

  void showDialogViewData(
      BuildContext context, String viewMode, String recordId) {
    FocusScope.of(context).requestFocus(FocusNode());

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {        
        return MobilCrudMainPage(viewMode: viewMode, recordId: recordId);
      }),
    ).then((value) {
      return mobilCariBloc.add(CloseDialogMobilCariEvent());
    });


/*
    showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              //return MobilCrudFormPage(viewMode: viewMode, recordId: recordId);
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: MobilCrudFormPage(viewMode: viewMode, recordId: recordId)
              );
            },
            useSafeArea: true)
        .then((value) {
      mobilCariBloc.add(CloseDialogMobilCariEvent());
    });
*/

  }
}
