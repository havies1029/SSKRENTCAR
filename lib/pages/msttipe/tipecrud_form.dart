import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/common/constants.dart';
import 'package:rentcarapp/widgets/form_error.dart';
import 'package:rentcarapp/blocs/msttipe/tipecrud_bloc.dart';
import 'package:rentcarapp/models/msttipe/tipecrud_model.dart';
import 'package:rentcarapp/models/combobox/combomerk_model.dart';
import 'package:rentcarapp/widgets/combobox/combomerk_widget.dart';

class TipeCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const TipeCrudFormPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  TipeCrudFormPageFormState createState() => TipeCrudFormPageFormState();
}

class TipeCrudFormPageFormState extends State<TipeCrudFormPage> {
  late TipeCrudBloc tipeCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  ComboMerkModel fieldComboMerk = const ComboMerkModel();
  var fieldTipeNamaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    tipeCrudBloc = BlocProvider.of<TipeCrudBloc>(context);
    return BlocConsumer<TipeCrudBloc, TipeCrudState>(
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
                        const SizedBox(height: 10),
                        Text(
                          "${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Tipe Mobil",
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Color(0xffff6101),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Hind',
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(height: 25),
                        buildFieldComboMerk(
                          initItem: fieldComboMerk,
                          onChangedCallback: (value) {
                            if (value != null) {
                              removeError(
                                  error: "Merk mobil tidak boleh kosong.");
                            }
                          },
                          validatorCallback: (value) {
                            if (value == null) {
                              addError(error: "Merk mobil tidak boleh kosong.");
                            }
                          },
                          onSaveCallback: (value) {
                            fieldComboMerk = value!;
                          },
                        ),
                        TextFormField(
                          controller: fieldTipeNamaController,
                          decoration: const InputDecoration(
                            labelText: "tipeNama",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kStringNullError);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(error: kStringNullError);
                              return "";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        FormError(
                          errors: errors,
                          key: null,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
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
                                  style: TextStyle(fontSize: 13.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ));
      },
      listener: (context, state) {
        if (state.isLoaded) {
          fieldComboMerk = ComboMerkModel(
              mmerkId: state.record!.mmerkId,
              merkNama: state.record!.merkNama!);
          fieldTipeNamaController.text = state.record!.tipeNama;
        }
      },
    );
  }

  void loadData() {
    if (widget.viewMode == "ubah") {
      tipeCrudBloc.add(TipeCrudLihatEvent(recordId: widget.recordId));
    }
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      TipeCrudModel record = TipeCrudModel(
        mtipeId: '',
        mmerkId: fieldComboMerk.mmerkId,
        tipeNama: fieldTipeNamaController.text,
      );
      if (widget.viewMode == "tambah") {
        tipeCrudBloc.add(TipeCrudTambahEvent(record: record));
      } else if (widget.viewMode == "ubah") {
        record.mtipeId = tipeCrudBloc.state.record!.mtipeId;
        tipeCrudBloc.add(TipeCrudUbahEvent(record: record));
      }
      _dismissDialog();
    }
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }
}
