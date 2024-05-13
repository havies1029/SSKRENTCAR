import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/widgets/checkbox_widget.dart';
import 'package:rentcarapp/widgets/form_error.dart';
import 'package:rentcarapp/blocs/mstmobil/mobilcrud_bloc.dart';
import 'package:rentcarapp/models/mstmobil/mobilcrud_model.dart';
import 'package:rentcarapp/models/combobox/comboinsurer_model.dart';
import 'package:rentcarapp/widgets/combobox/comboinsurer_widget.dart';
import 'package:rentcarapp/models/combobox/combostsmobil_model.dart';
import 'package:rentcarapp/widgets/combobox/combostsmobil_widget.dart';
import 'package:rentcarapp/models/combobox/combotipe_model.dart';
import 'package:rentcarapp/widgets/combobox/combotipe_widget.dart';
import 'package:rentcarapp/models/combobox/combowarna_model.dart';
import 'package:rentcarapp/widgets/combobox/combowarna_widget.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:string_validator/string_validator.dart';

class MobilCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const MobilCrudFormPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  MobilCrudFormPageFormState createState() => MobilCrudFormPageFormState();
}

class MobilCrudFormPageFormState extends State<MobilCrudFormPage> {
  late MobilCrudBloc mobilCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  ComboInsurerModel? fieldComboInsurer;
  //ComboArg selectedComboInsurer = ComboArg();
  ComboStsmobilModel? fieldComboStsmobil;
  //ComboArg selectedComboStsmobil = ComboArg();
  ComboTipeModel? fieldComboTipe;
  //ComboArg selectedComboTipe = ComboArg();
  ComboWarnaModel? fieldComboWarna;
  //ComboArg selectedComboWarna = ComboArg();
  var fieldPlatNoController = TextEditingController();
  var fieldPolisAkhirController = TextEditingController();
  var fieldPolisMulaiController = TextEditingController();
  var fieldPolisNoController = TextEditingController();
  var fieldStnkNoController = TextEditingController();
  var fieldStnkTempoController = TextEditingController();
  var fieldThnBuatController = TextEditingController();
  var fieldIsAsuransi = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    mobilCrudBloc = BlocProvider.of<MobilCrudBloc>(context);
    return BlocConsumer<MobilCrudBloc, MobilCrudState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: fieldPlatNoController,
                      decoration: const InputDecoration(
                        labelText: "Plat No.",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          removeError(error: "Plat No. tidak boleh kosong.");
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          addError(error: "Plat No. tidak boleh kosong.");
                          return "";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5.0,),
                    buildFieldComboTipe(
                      initItem: fieldComboTipe,
                      onChangedCallback: (value) {
                        if (value != null) {
                          removeError(error: "Tipe mobil tidak boleh kosong.");
                        }
                      },
                      onSaveCallback: (value) {
                        fieldComboTipe = value!;
                      },
                      validatorCallback: (value) {
                        if (value == null) {
                          addError(error: "Tipe mobil tidak boleh kosong.");
                        }
                      },
                    ),
                    const SizedBox(height: 5.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: fieldThnBuatController,
                            decoration: const InputDecoration(
                              labelText: "Tahun Buat",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(
                                    error: "Tahun Buat tidak boleh kosong.");
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                addError(
                                    error: "Tahun Buat tidak boleh kosong.");
                                return "";
                              }
                              return null;
                            },
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: buildFieldComboWarna(
                                initItem: fieldComboWarna,
                                onChangedCallback: (value) {
                                  if (value != null) {
                                    removeError(
                                        error:
                                            "Warna mobil tidak boleh kosong.");
                                  }
                                },
                                onSaveCallback: (value) {
                                  fieldComboWarna = value!;
                                },
                                validatorCallback: (value) {
                                  if (value == null) {
                                    addError(
                                        error:
                                            "Warna mobil tidak boleh kosong.");
                                  }
                                },
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 5.0,),
                    TextFormField(
                      controller: fieldStnkNoController,
                      decoration: const InputDecoration(
                        labelText: "No. STNK",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          removeError(error: "No. STNK tidak boleh kosong.");
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          addError(error: "No. STNK tidak boleh kosong.");
                          return "";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5.0,),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: DateTimeFormField(
                            mode: DateTimeFieldPickerMode.date,
                            dateFormat: DateFormat('dd/MM/yyyy'),
                            initialValue: DateTime.now(),
                            decoration: const InputDecoration(
                              labelText: "Batas Berlaku",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            onChanged: (DateTime? value) {
                              if (value != null) {
                                removeError(
                                    error:
                                        "Batas Berlaku STNK tidak boleh kosong.");
                                fieldStnkTempoController.text =
                                    value.toIso8601String();
                              }
                            },
                            validator: (value) {
                              if (value == null) {
                                addError(
                                    error:
                                        "Batas Berlaku STNK tidak boleh kosong.");
                                return '';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              debugPrint("STNK Batas Berlaku : ${value.toString()}");
                              fieldStnkTempoController.text =
                                  value!.toIso8601String();
                            },
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: buildFieldComboStsmobil(
                              initItem: fieldComboStsmobil,
                              onChangedCallback: (value) {
                                if (value != null) {
                                  removeError(
                                      error:
                                          "Status Mobil tidak boleh kosong.");
                                }
                              },
                              onSaveCallback: (value) {
                                fieldComboStsmobil = value!;
                              },
                              validatorCallback: (value) {
                                if (value == null) {
                                  addError(
                                      error:
                                          "Status Mobil tidak boleh kosong.");
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0,),
                    CheckboxWidget(
                        leftLabel: "",
                        rightLabel: "Diasuransikan",
                        initialValue: toBoolean(fieldIsAsuransi.text),
                        callback: (value) {
                          setState(() {
                            fieldIsAsuransi.text = value.toString();
                          });
                        }),
                    Visibility(
                      visible: toBoolean(fieldIsAsuransi.text),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: fieldPolisNoController,
                            decoration: const InputDecoration(
                              labelText: "No. Polis",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            onChanged: (value) {
                              if (toBoolean(fieldIsAsuransi.text)) {
                                if (value.isNotEmpty) {
                                  removeError(
                                      error:
                                          "No. Polis Asuransi tidak boleh kosong.");
                                }
                              }
                            },
                            validator: (value) {
                              if (toBoolean(fieldIsAsuransi.text)) {
                                if (value == null || value.isEmpty) {
                                  addError(
                                      error:
                                          "No. Polis Asuransi tidak boleh kosong.");
                                  return "";
                                }
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 5.0,),
                          buildFieldComboInsurer(
                            initItem: fieldComboInsurer,
                            //selectedItem: selectedComboInsurer,
                            onChangedCallback: (value) {
                              if (value != null) {
                                removeError(
                                    error: "Nama Asuransi tidak boleh kosong.");
                              }
                            },
                            onSaveCallback: (value) {
                              if (value != null) {
                                fieldComboInsurer = value;
                              }
                            },
                            validatorCallback: (value) {
                              if (value == null) {
                                addError(
                                    error: "Nama Asuransi tidak boleh kosong.");
                              }
                            },
                          ),
                          const SizedBox(height: 5.0,),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: DateTimeFormField(
                                  mode: DateTimeFieldPickerMode.date,
                                  dateFormat: DateFormat('dd/MM/yyyy'),
                                  initialValue: DateTime.tryParse(
                                      fieldPolisMulaiController.text),
                                  decoration: const InputDecoration(
                                    labelText: "Polis Mulai",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                  ),
                                  onChanged: (DateTime? value) {
                                    if (toBoolean(fieldIsAsuransi.text)) {
                                      if (value != null) {
                                        removeError(
                                            error:
                                                "Tanggal Polis Mulai tidak boleh kosong.");
                                        fieldPolisMulaiController.text =
                                            value.toIso8601String();
                                      }
                                    }
                                  },
                                  validator: (value) {
                                    if (toBoolean(fieldIsAsuransi.text)) {
                                      if (value == null) {
                                        addError(
                                            error:
                                                "Tanggal Polis Mulai tidak boleh kosong.");
                                        return '';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: DateTimeFormField(
                                    mode: DateTimeFieldPickerMode.date,
                                    dateFormat: DateFormat('dd/MM/yyyy'),
                                    initialValue: DateTime.tryParse(
                                        fieldPolisAkhirController.text),
                                    decoration: const InputDecoration(
                                      labelText: "Polis Akhir",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    onChanged: (DateTime? value) {
                                      if (toBoolean(fieldIsAsuransi.text)) {
                                        if (value != null) {
                                          removeError(
                                              error:
                                                  "Tanggal Polis Mulai Akhir boleh kosong.");
                                          fieldPolisAkhirController.text =
                                              value.toIso8601String();
                                        }
                                      }
                                    },
                                    validator: (value) {
                                      if (toBoolean(fieldIsAsuransi.text)) {
                                        if (value == null) {
                                          addError(
                                              error:
                                                  "Tanggal Polis Akhir tidak boleh kosong.");
                                          return '';
                                        }
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
        );
      },
      listener: (context, state) {
        if (state.isLoaded) {
          fieldComboInsurer = state.record!.insurerId == null
              ? null
              : ComboInsurerModel(
                  mrekanId: state.record!.insurerId!,
                  rekanNama: state.record!.insurerNama!);
          fieldComboStsmobil = state.record!.mstsmobilId == null
              ? null
              : ComboStsmobilModel(
                  mstsmobilId: state.record!.mstsmobilId!,
                  statusNama: state.record!.statusNama!);
          fieldComboTipe = state.record!.mtipeId == null
              ? null
              : ComboTipeModel(
                  mtipeId: state.record!.mtipeId!,
                  tipeNama: state.record!.tipeNama!);
          debugPrint("state.record!.mwarnaId : ${state.record!.mwarnaId}");
          fieldComboWarna = state.record!.mwarnaId == null
              ? null
              : ComboWarnaModel(
                  mwarnaId: state.record!.mwarnaId!,
                  warnaNama: state.record!.warnaNama!);
          fieldPlatNoController.text = state.record!.platNo;
          fieldPolisAkhirController.text = state.record!.polisAkhir == null
              ? ""
              : state.record!.polisAkhir!.toIso8601String();
          fieldPolisMulaiController.text = state.record!.polisMulai == null
              ? ""
              : state.record!.polisMulai!.toIso8601String();
          fieldPolisNoController.text = state.record!.polisNo;
          fieldStnkNoController.text = state.record!.stnkNo;
          fieldStnkTempoController.text =
              state.record!.stnkTempo.toIso8601String();
          fieldThnBuatController.text = state.record!.thnBuat.toString();
          fieldIsAsuransi.text = state.record!.isAsuransi.toString();
        }
      },
    );
  }

  void loadData() {
    if (widget.viewMode == "ubah") {
      mobilCrudBloc.add(MobilCrudLihatEvent(recordId: widget.recordId));
    }
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void onSaveForm() {
    debugPrint("onSaveForm #00");
    debugPrint(
        "fieldStnkTempoController.text : ${fieldStnkTempoController.text}");
    if (_formKey.currentState!.validate()) {
      debugPrint("onSaveForm #10");
      _formKey.currentState!.save();

      debugPrint("onSaveForm #30");

      if (!toBoolean(fieldIsAsuransi.text)) {
        fieldPolisNoController.text = "";
        fieldComboInsurer = const ComboInsurerModel();
        fieldPolisAkhirController.text = "";
        fieldPolisMulaiController.text = "";
      }

      MobilCrudModel record = MobilCrudModel(
          insurerId: fieldComboInsurer?.mrekanId,
          mmobilId: '',
          mstsmobilId: fieldComboStsmobil?.mstsmobilId,
          mtipeId: fieldComboTipe?.mtipeId,
          mwarnaId: fieldComboWarna?.mwarnaId,
          platNo: fieldPlatNoController.text,
          polisAkhir: DateTime.tryParse(fieldPolisAkhirController.text),
          polisMulai: DateTime.tryParse(fieldPolisMulaiController.text),
          polisNo: fieldPolisNoController.text,
          stnkNo: fieldStnkNoController.text,
          stnkTempo: DateTime.parse(fieldStnkTempoController.text),
          thnBuat: int.parse(fieldThnBuatController.text),
          isAsuransi: toBoolean(fieldIsAsuransi.text));
      if (widget.viewMode == "tambah") {
        mobilCrudBloc.add(MobilCrudTambahEvent(record: record));
      } else if (widget.viewMode == "ubah") {
        record.mmobilId = mobilCrudBloc.state.record!.mmobilId;
        mobilCrudBloc.add(MobilCrudUbahEvent(record: record));
      }

      debugPrint("onSaveForm #40");

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
