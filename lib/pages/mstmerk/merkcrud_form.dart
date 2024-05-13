import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/blocs/mstmerk/merkcrud_bloc.dart';
import 'package:rentcarapp/models/mstmerk/merkcrud_model.dart';

class MerkCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const MerkCrudFormPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  MerkCrudFormPageState createState() => MerkCrudFormPageState();
}

class MerkCrudFormPageState extends State<MerkCrudFormPage> {
  var fieldMerkController = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();
  late MerkCrudBloc merkCrudBloc;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  void loadData() {
    debugPrint("widget.recordId : ${widget.recordId}");

    if (widget.viewMode == "ubah") {
      merkCrudBloc.add(MerkCrudLihatEvent(recordId: widget.recordId));
    }
  }

  @override
  Widget build(BuildContext context) {
    merkCrudBloc = BlocProvider.of<MerkCrudBloc>(context);
    return BlocConsumer<MerkCrudBloc, MerkCrudState>(
      builder: (context, state) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Merk",
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Color(0xffff6101),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Hind',
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Merk', icon: Icon(Icons.car_rental)),
                        controller: fieldMerkController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  _dismissDialog();
                                },
                                child: const Text(
                                  'Close',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  onSaveForm();
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
      listener: (context, state) {
        debugPrint(
            "MerkCrudBloc -> listener -> state.isLoaded : ${state.isLoaded}");
        if (state.isLoaded) {
          fieldMerkController.text = state.record!.merkNama;
        }
      },
    );
  }

  void _dismissDialog() {
    debugPrint("_dismissDialog");
    //debugPrint(jsonEncode(returnData!.toJson()));
    Navigator.pop(context);
  }

  void onSaveForm() {
    debugPrint("onSaveForm");
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      MerkCrudModel record =
          MerkCrudModel(merkNama: fieldMerkController.text, mmerkId: "");

      if (widget.viewMode == "tambah") {
        merkCrudBloc.add(MerkCrudTambahEvent(record: record));
      } else if (widget.viewMode == "ubah") {
        record.mmerkId = merkCrudBloc.state.record!.mmerkId;
        merkCrudBloc.add(MerkCrudUbahEvent(record: record));
      }

      _dismissDialog();
    }
  }
}
