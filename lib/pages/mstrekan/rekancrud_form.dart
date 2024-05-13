import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/form_error.dart';
import 'package:rentcarapp/blocs/mstrekan/rekancrud_bloc.dart';
import 'package:rentcarapp/models/mstrekan/rekancrud_model.dart';
import 'package:rentcarapp/models/combobox/combotitle_model.dart';
import 'package:rentcarapp/widgets/combobox/combotitle_widget.dart';

class RekanCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const RekanCrudFormPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  RekanCrudFormPageFormState createState() => RekanCrudFormPageFormState();
}

class RekanCrudFormPageFormState extends State<RekanCrudFormPage> {
  late RekanCrudBloc rekanCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var fieldAlamat1Controller = TextEditingController();
  var fieldAlamat2Controller = TextEditingController();
  var fieldKtpNoController = TextEditingController();
  var fieldMtiperekanIdController = TextEditingController();
  ComboTitleModel fieldComboTitle = const ComboTitleModel();
  //ComboArg selectedComboTitle = ComboArg();
  var fieldRekanNamaController = TextEditingController();
  var fieldTelp1Controller = TextEditingController();
  var fieldTelp2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    rekanCrudBloc = BlocProvider.of<RekanCrudBloc>(context);
    return BlocConsumer<RekanCrudBloc, RekanCrudState>(
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
                          "${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Customer",
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
                        buildFieldComboTitle(
                          initItem: fieldComboTitle,
                          onSaveCallback: (value) {
                            fieldComboTitle = value!;
                          },
                        ),
                        TextFormField(
                          controller: fieldRekanNamaController,
                          decoration: const InputDecoration(
                            labelText: "Nama Lengkap",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: 'Nama tidak boleh kosong.');
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(error: 'Nama tidak boleh kosong.');
                              return "";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: fieldKtpNoController,
                          decoration: const InputDecoration(
                            labelText: "No. KTP",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: 'No. KTP tidak boleh kosong.');
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(error: 'No. KTP tidak boleh kosong.');
                              return "";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 3,
                          controller: fieldAlamat1Controller,
                          decoration: const InputDecoration(
                            labelText: "Alamat 1",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: 'Alamat tidak boleh kosong.');
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(error: 'Alamat tidak boleh kosong.');
                              return "";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 3,
                          controller: fieldAlamat2Controller,
                          decoration: const InputDecoration(
                            labelText: "Alamat 2",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onChanged: (value) {},
                        ),
                        TextFormField(
                          controller: fieldTelp1Controller,
                          decoration: const InputDecoration(
                            labelText: "Telp / HP #1",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(
                                  error: 'Telp / HP tidak boleh kosong.');
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(error: 'Telp / HP tidak boleh kosong.');
                              return "";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Telp / HP #2",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          controller: fieldTelp2Controller,
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 25),
                        FormError(
                          errors: errors,
                          key: null,
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
                                    style: TextStyle(fontSize: 13.0),
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
                                    style: TextStyle(fontSize: 13.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ));
      },
      listener: (context, state) {
        if (state.isLoaded) {
          fieldAlamat1Controller.text = state.record!.alamat1;
          fieldAlamat2Controller.text = state.record!.alamat2;
          fieldKtpNoController.text = state.record!.ktpNo;
          fieldMtiperekanIdController.text = state.record!.mtiperekanId;
          fieldComboTitle = ComboTitleModel(
              mtitleId: state.record!.mtitleId ?? "",
              titleDesc: state.record!.titleDesc ?? "");
          fieldRekanNamaController.text = state.record!.rekanNama;
          fieldTelp1Controller.text = state.record!.telp1;
          fieldTelp2Controller.text = state.record!.telp2;
        }
      },
    );
  }

  void loadData() {
    if (widget.viewMode == "ubah") {
      rekanCrudBloc.add(RekanCrudLihatEvent(recordId: widget.recordId));
    }
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      RekanCrudModel record = RekanCrudModel(
        mrekanId: '',
        alamat1: fieldAlamat1Controller.text,
        alamat2: fieldAlamat2Controller.text,
        ktpNo: fieldKtpNoController.text,
        mtiperekanId: fieldMtiperekanIdController.text,
        mtitleId: fieldComboTitle.mtitleId,
        rekanNama: fieldRekanNamaController.text,
        telp1: fieldTelp1Controller.text,
        telp2: fieldTelp2Controller.text,
      );
      if (widget.viewMode == "tambah") {
        rekanCrudBloc.add(RekanCrudTambahEvent(record: record));
      } else if (widget.viewMode == "ubah") {
        record.mrekanId = rekanCrudBloc.state.record!.mrekanId;
        rekanCrudBloc.add(RekanCrudUbahEvent(record: record));
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
