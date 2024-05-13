import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:rentcarapp/widgets/showdialoghapus_widget.dart';
import 'package:rentcarapp/blocs/msttipe/tipecari_bloc.dart';
import 'package:rentcarapp/blocs/msttipe/tipecrud_bloc.dart';
import 'package:rentcarapp/pages/msttipe/tipecari_tile_widget.dart';

class TipeCariListWidget extends StatefulWidget {
  final String searchText;
  const TipeCariListWidget({super.key, required this.searchText});

  @override
  TipeCariListWidgetState createState() => TipeCariListWidgetState();
}

class TipeCariListWidgetState extends State<TipeCariListWidget> {
  late TipeCariBloc tipeCariBloc;
  late TipeCrudBloc tipeCrudBloc;
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
    tipeCariBloc = BlocProvider.of<TipeCariBloc>(context);
    tipeCrudBloc = BlocProvider.of<TipeCrudBloc>(context);
    return BlocConsumer<TipeCariBloc, TipeCariState>(
        builder: (context, state) {
          if (state.status == ListStatus.success) {
            return state.items.isNotEmpty
                ? Flexible(
                    child: GroupedListView<dynamic, String>(
                      elements: state.items.map((e) => e.toJson()).toList(),
                      groupBy: (elements) => elements['merkNama'],
                      groupComparator: (value1, value2) =>
                          value2.compareTo(value1),
                      itemComparator: (item1, item2) =>
                          item1['tipeNama'].compareTo(item2['tipeNama']),
                      order: GroupedListOrder.ASC,
                      useStickyGroupSeparators: true,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      groupSeparatorBuilder: (String value) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            //color: Colors.blueGrey,
                            color: Colors.yellow,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      indexedItemBuilder: (c, element, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TipeCariTileWidget(
                            merkNama: element["merkNama"],
                            mmerkId: element["mmerkId"],
                            mtipeId: element["mtipeId"],
                            tipeNama: element["tipeNama"],
                          ),
                        );
                      },
                    ),
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
      tipeCariBloc.add(FetchTipeCariEvent(
          searchText: widget.searchText, hal: tipeCariBloc.state.hal));
    }
  }

  onHapusFunction(String recordId) {
    tipeCrudBloc.add(TipeCrudHapusEvent(recordId: recordId));
  }

  void showDialogHapus(String recordId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ShowDialogHapusWidget(
              onHapusFunction: onHapusFunction, recordId: recordId);
        }).then((value) {
      tipeCariBloc.add(CloseDialogTipeCariEvent());
    });
  }
}
