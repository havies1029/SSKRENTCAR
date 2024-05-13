import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rentcarapp/blocs/mstmerk/merkcari_bloc.dart';
import 'package:rentcarapp/blocs/mstmerk/merkcrud_bloc.dart';
import 'package:rentcarapp/pages/mstmerk/merkcari_tile_widget.dart';
import 'package:rentcarapp/widgets/showdialoghapus_widget.dart';

class MerkCariListWidget extends StatefulWidget {
  final String searchText;
  const MerkCariListWidget({super.key, required this.searchText});

  @override
  MerkCariListWidgetState createState() => MerkCariListWidgetState();
}

class MerkCariListWidgetState extends State<MerkCariListWidget> {
  late MerkCariBloc merkCariBloc;
  late MerkCrudBloc merkCrudBloc;

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
    merkCariBloc = BlocProvider.of<MerkCariBloc>(context);
    merkCrudBloc = BlocProvider.of<MerkCrudBloc>(context);

    return BlocConsumer<MerkCariBloc, MerkCariState>(
        builder: (context, state) {
          if (state.status == ListStatus.success) {
            return state.items.isNotEmpty
                ? Flexible(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: _scrollController,
                        itemCount: state.items.length,
                        itemBuilder: (_, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
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
                                                merkCariBloc.add(
                                                    UbahMerkCariEvent(
                                                        recordId: state
                                                            .items[index]
                                                            .mmerkId));
                                              },
                                              backgroundColor: Colors.green,
                                              icon: Icons.edit,
                                              label: "Edit",
                                            ),
                                            SlidableAction(
                                              onPressed: (context) {
                                                showDialogHapus(
                                                    state.items[index].mmerkId);
                                              },
                                              backgroundColor: Colors.red,
                                              icon: Icons.delete,
                                              label: "Delete",
                                            ),
                                          ]),
                                      child: MerkCariTileWidget(
                                          mmerkId: state.items[index].mmerkId,
                                          merkNama:
                                              state.items[index].merkNama)),
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
        },
        buildWhen: (previous, current) {
          return (current.status == ListStatus.success);
        },
        listener: (context, state) {});
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      merkCariBloc.add(FetchMerkCariEvent(
          searchText: widget.searchText, hal: merkCariBloc.state.hal));
    }
  }

  onHapusFunction(String recordId) {
    merkCrudBloc.add(MerkCrudHapusEvent(recordId: recordId));
  }

  void showDialogHapus(String recordId) {
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowDialogHapusWidget(onHapusFunction: onHapusFunction, recordId: recordId);
      }
      
    ).then((value) {
      merkCariBloc.add(CloseDialogMerkCariEvent());
    });
  }
}
