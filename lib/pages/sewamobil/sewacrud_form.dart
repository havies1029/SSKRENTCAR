import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/models/combobox/combocustomer_model.dart';
import 'package:rentcarapp/widgets/combobox/combocustomer_widget.dart';
import 'package:rentcarapp/widgets/form_error.dart';
import 'package:rentcarapp/blocs/sewamobil/sewacrud_bloc.dart';
import 'package:rentcarapp/models/sewamobil/sewacrud_model.dart';
import 'package:rentcarapp/models/combobox/comboharga_model.dart';
import 'package:rentcarapp/widgets/combobox/comboharga_widget.dart';
import 'package:rentcarapp/models/combobox/combomasasewa_model.dart';
import 'package:rentcarapp/widgets/combobox/combomasasewa_widget.dart';
import 'package:rentcarapp/models/combobox/combomobil_model.dart';
import 'package:rentcarapp/widgets/combobox/combomobil_widget.dart';
import 'package:rentcarapp/models/combobox/combowilayah_model.dart';
import 'package:rentcarapp/widgets/combobox/combowilayah_widget.dart';
import 'package:rentcarapp/models/combobox/combosupir_model.dart';
import 'package:rentcarapp/widgets/combobox/combosupir_widget.dart';
import 'package:intl/intl.dart';
import 'package:rentcarapp/common/thousand_separator_input_formatter.dart';
import 'package:date_field/date_field.dart';
import 'package:string_validator/string_validator.dart';
import 'package:rentcarapp/widgets/checkbox_widget.dart';

class SewaCrudFormPage extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const SewaCrudFormPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  SewaCrudFormPageFormState createState() => SewaCrudFormPageFormState();
}

class SewaCrudFormPageFormState extends State<SewaCrudFormPage> {
  late SewaCrudBloc sewaCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var fieldBiayaAntarController = TextEditingController();
  var fieldBiayaJemputController = TextEditingController();
  var fieldBiayaSewaController = TextEditingController();
  var fieldBiayaTotalController = TextEditingController();
  ComboCustomerModel? fieldComboCustomer;
  var fieldHargaController = TextEditingController();
  var fieldIsLepaskunciController = TextEditingController();
  var fieldKeteranganController = TextEditingController();
  ComboHargaModel? fieldComboHarga;
  ComboMasasewaModel? fieldComboMasasewa = const ComboMasasewaModel();
  ComboMobilModel? fieldComboMobil;
  ComboWilayahModel? fieldComboWilayah;
  var fieldQtyController = TextEditingController();
  var fieldAkhirTglController = TextEditingController();
  var fieldAkhirJamController = TextEditingController();
  var fieldMulaiTglController = TextEditingController();
  var fieldMulaiJamController = TextEditingController();
  ComboSupirModel? fieldcomboSupirKontrak;
  var fieldTglTrxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    sewaCrudBloc = BlocProvider.of<SewaCrudBloc>(context);
    return BlocConsumer<SewaCrudBloc, SewaCrudState>(
      /*
      buildWhen: (previous, current) {
        if (!current.isLoading && current.isLoaded) {
          debugPrint(
              "SewaCrudBloc -> buildWhen -> current.isLoaded : ${current.isLoaded}");
          return true;
        }
        return false;
      },
      */
      builder: (context, state) {
        debugPrint(
            "SewaCrudBloc -> builder -> state.isLoaded : ${state.isLoaded}");
        return state.isLoaded
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DateTimeFormField(
                                    canClear: false,
                                    mode: DateTimeFieldPickerMode.date,
                                    dateFormat: DateFormat('dd/MM/yyyy'),
                                    initialValue: DateTime.tryParse(
                                        fieldTglTrxController.text),
                                    decoration: const InputDecoration(
                                      labelText: "Tanggal Booking",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    onChanged: (value) {
                                      if (value != null) {
                                        removeError(
                                            error:
                                                'Tanggal Booking tidak boleh kosong.');
                                      }
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        addError(
                                            error:
                                                'Tanggal Booking tidak boleh kosong.');
                                        return "";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildFieldComboWilayah(
                                    initItem: fieldComboWilayah,
                                    onChangedCallback: (value) {
                                      if (value != null) {
                                        removeError(
                                            error:
                                                "Field Wilayah tidak boleh kosong.");
                                        fieldComboWilayah = value;
                                      }
                                    },
                                    onSaveCallback: (value) {
                                      if (value != null) {
                                        fieldComboWilayah = value;
                                      }
                                    },
                                    validatorCallback: (value) {
                                      if (value == null) {
                                        addError(
                                            error:
                                                "Field Wilayah tidak boleh kosong.");
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          buildFieldComboCustomer(
                            initItem: fieldComboCustomer,
                            onChangedCallback: (value) {
                              if (value != null) {
                                removeError(
                                    error:
                                        "Field Customer tidak boleh kosong.");
                                fieldComboCustomer = value;
                                sewaCrudBloc.add(
                                    CustomerChangedEvent(comboCustomer: value));
                              }
                            },
                            onSaveCallback: (value) {
                              if (value != null) {
                                fieldComboCustomer = value;
                              }
                            },
                            validatorCallback: (value) {
                              if (value == null) {
                                addError(
                                    error:
                                        "Field Customer tidak boleh kosong.");
                              }
                            },
                          ),
                          buildFieldComboMobil(
                            initItem: fieldComboMobil,
                            onChangedCallback: (value) {
                              if (value != null) {
                                removeError(
                                    error: "Field Mobil tidak boleh kosong.");
                              }
                            },
                            onSaveCallback: (value) {
                              if (value != null) {
                                fieldComboMobil = value;
                              }
                            },
                            validatorCallback: (value) {
                              if (value == null) {
                                addError(
                                    error: "Field Mobil tidak boleh kosong.");
                              }
                            },
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CheckboxWidget(
                                      leftLabel: "",
                                      rightLabel: "Lepas Kunci",
                                      initialValue: toBoolean(
                                          fieldIsLepaskunciController.text),
                                      callback: (value) {
                                        setState(() {
                                          fieldIsLepaskunciController.text =
                                              value.toString();
                                        });
                                      }),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Visibility(
                                  visible: !toBoolean(
                                      fieldIsLepaskunciController.text),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: buildFieldComboSupir(
                                      labelText: 'Supir Kontrak',
                                      initItem: fieldcomboSupirKontrak,
                                      onChangedCallback: (value) {
                                        if (value != null) {
                                          removeError(
                                              error:
                                                  "Field Supir Kontrak tidak boleh kosong.");
                                          sewaCrudBloc.add(
                                              SupirKontrakChangedEvent(
                                                  comboSupirKontrak: value));
                                        }
                                      },
                                      onSaveCallback: (value) {
                                        if (value != null) {
                                          fieldcomboSupirKontrak = value;
                                        }
                                      },
                                      validatorCallback: (value) {
                                        if (value == null) {
                                          addError(
                                              error:
                                                  "Field Supir Kontrak tidak boleh kosong.");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildFieldComboMasasewa(
                                    initItem: fieldComboMasasewa,
                                    onChangedCallback: (value) {
                                      if (value != null) {
                                        removeError(
                                            error:
                                                "Field Masa Sewa tidak boleh kosong.");

                                        sewaCrudBloc.add(MasaSewaChangedEvent(
                                            masasewaRec: value));
                                      }
                                    },
                                    onSaveCallback: (value) {
                                      if (value != null) {
                                        fieldComboMasasewa = value;
                                      }
                                    },
                                    validatorCallback: (value) {
                                      if (value == null) {
                                        addError(
                                            error:
                                                "Field Masa Sewa tidak boleh kosong.");
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    //initialValue: "1",
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      ThousandsSeparatorInputFormatter()
                                    ],
                                    controller: fieldQtyController,
                                    decoration: InputDecoration(
                                      labelText: "Qty",
                                      suffixText: fieldComboMasasewa?.satuan,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        value = "0";
                                      }
                                      if (value.isNotEmpty) {
                                        removeError(
                                            error: 'Qty tidak boleh kosong');

                                        debugPrint("Qty value : $value");

                                        sewaCrudBloc.add(QtySewaChangedEvent(
                                            qty: int.parse(value)));
                                        /*
                                  onQtySewaChanged(
                                      state.record!, int.parse(value));
                                      */
                                      }
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        addError(
                                            error: 'Qty tidak boleh kosong');
                                        return "";
                                      }
                                      return null;
                                    },
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      DateTimeFormField(
                                        canClear: false,
                                        mode: DateTimeFieldPickerMode.date,
                                        dateFormat: DateFormat('dd/MM/yyyy'),
                                        initialValue: DateTime.tryParse(
                                            fieldMulaiTglController.text),
                                        decoration: const InputDecoration(
                                          labelText: "Mulai Sewa",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                        ),
                                        onChanged: (value) {
                                          if (value != null) {
                                            removeError(
                                                error:
                                                    "Tanggal Mulai Sewa tidak boleh kosong.");

                                            sewaCrudBloc.add(
                                                TglMulaiSewaChangedEvent(
                                                    tglMulaiSewa: value));

                                            /*
                                      onTglMulaiSewaChanged(
                                          state.record!, value);
                                          */
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            addError(
                                                error:
                                                    "Tanggal Mulai Sewa tidak boleh kosong.");
                                            return "";
                                          }
                                          return null;
                                        },
                                      ),
                                      DateTimeFormField(
                                        canClear: false,
                                        mode: DateTimeFieldPickerMode.time,
                                        dateFormat: DateFormat('HH:mm'),
                                        initialValue: DateTime.tryParse(
                                            fieldMulaiJamController.text),
                                        decoration: const InputDecoration(
                                            suffixIcon:
                                                Icon(Icons.access_alarm)),
                                        onChanged: (value) {
                                          if (value != null) {
                                            removeError(
                                                error:
                                                    "Jam Mulai Sewa tidak boleh kosong.");

                                            sewaCrudBloc.add(
                                                JamMulaiChangedEvent(
                                                    mulaiJam: value));
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            addError(
                                                error:
                                                    "Jam Mulai Sewa tidak boleh kosong.");
                                            return "";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        readOnly: true,
                                        controller: fieldAkhirTglController,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(Icons.date_range),
                                          labelText: "Selesai Sewa",
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                        ),
                                      ),
                                      TextFormField(
                                        readOnly: true,
                                        controller: fieldAkhirJamController,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(Icons.access_alarm),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildFieldComboHarga(
                                    initItem: fieldComboHarga,
                                    onChangedCallback: (value) {
                                      if (value != null) {
                                        removeError(
                                            error:
                                                "Field Harga tidak boleh kosong.");

                                        sewaCrudBloc.add(HargaSewaChangedEvent(
                                            comboHarga: value));
                                      }
                                    },
                                    onSaveCallback: (value) {
                                      if (value != null) {
                                        fieldComboHarga = value;
                                      }
                                    },
                                    validatorCallback: (value) {
                                      if (value == null) {
                                        addError(
                                            error:
                                                "Field Harga tidak boleh kosong.");
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: fieldBiayaSewaController,
                                    decoration: const InputDecoration(
                                      labelText: "Biaya Sewa",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CheckboxWidget(
                                      leftLabel: "",
                                      rightLabel: "Lepas Kunci",
                                      initialValue: toBoolean(
                                          fieldIsLepaskunciController.text),
                                      callback: (value) {
                                        setState(() {
                                          fieldIsLepaskunciController.text =
                                              value.toString();
                                        });
                                      }),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Visibility(
                                  visible: !toBoolean(
                                      fieldIsLepaskunciController.text),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: buildFieldComboSupir(
                                      labelText: 'Supir Antar',
                                      initItem: fieldcomboSupirKontrak,
                                      onChangedCallback: (value) {
                                        if (value != null) {
                                          removeError(
                                              error:
                                                  "Field Supir Antar tidak boleh kosong.");
                                          sewaCrudBloc.add(
                                              SupirKontrakChangedEvent(
                                                  comboSupirKontrak: value));
                                        }
                                      },
                                      onSaveCallback: (value) {
                                        if (value != null) {
                                          fieldcomboSupirKontrak = value;
                                        }
                                      },
                                      validatorCallback: (value) {
                                        if (value == null) {
                                          addError(
                                              error:
                                                  "Field Supir Antar tidak boleh kosong.");
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              ThousandsSeparatorInputFormatter()
                            ],
                            controller: fieldBiayaAntarController,
                            decoration: const InputDecoration(
                              labelText: "Biaya Antar",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              ThousandsSeparatorInputFormatter()
                            ],
                            controller: fieldBiayaJemputController,
                            decoration: const InputDecoration(
                              labelText: "Biaya Jemput",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          TextFormField(
                            controller: fieldBiayaTotalController,
                            decoration: const InputDecoration(
                              labelText: "Total Biaya",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 3,
                            controller: fieldKeteranganController,
                            decoration: const InputDecoration(
                              labelText: "keterangan",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
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
              )
            : const Center(
                child: Center(
                child: CircularProgressIndicator(),
              ));
      },
      listener: (context, state) {
        if (state.isLoaded) {
          debugPrint("listener -> state.isLoaded");

          debugPrint("listener -> state.isLoaded #5");

          fieldBiayaAntarController.text =
              NumberFormat("#,###").format(state.record!.biayaAntar ?? 0);

          debugPrint("listener -> state.isLoaded #10");

          fieldBiayaJemputController.text =
              NumberFormat("#,###").format(state.record!.biayaJemput ?? 0);

          debugPrint("listener -> state.isLoaded #20");

          fieldBiayaSewaController.text =
              NumberFormat("#,###").format(state.record!.biayaSewa ?? 0);
          fieldBiayaTotalController.text =
              NumberFormat("#,###").format(state.record!.biayaTotal ?? 0);

          fieldHargaController.text =
              NumberFormat("#,###").format(state.record!.harga ?? 0);

          debugPrint("listener -> state.isLoaded #30");

          fieldIsLepaskunciController.text =
              (state.record!.isLepaskunci ?? true).toString();
          fieldKeteranganController.text = state.record!.keterangan ?? "";

          fieldComboCustomer = state.record!.comboCustomer;

          
          debugPrint("listener -> fieldComboCustomer.mrekanId -> ${fieldComboCustomer!.mrekanId}");


          fieldComboHarga = state.record!.comboHarga;

          fieldComboMasasewa = state.record!.comboMasaSewa;

          fieldcomboSupirKontrak = state.record!.comboSupirKontrak;

          debugPrint("listener -> state.isLoaded #32");

          //fieldComboWilayah = state.record!.comboWilayah;
          fieldComboWilayah = state.record!.comboWilayah;

          debugPrint("listener -> state.isLoaded #34");

          fieldComboMobil = state.record!.comboMobil;

          fieldQtyController.text = (state.record!.qty ?? 1).toString();

          fieldAkhirTglController.text =
              DateFormat("dd/MM/yyyy").format(state.record!.akhirTgl!);

          fieldAkhirJamController.text =
              DateFormat("HH:mm").format(state.record!.akhirJam!);
          fieldMulaiTglController.text =
              state.record!.mulaiTgl!.toIso8601String();
          fieldMulaiJamController.text =
              state.record!.mulaiJam!.toIso8601String();

          debugPrint(
              "listener -> state.record!.mulaiJam : ${state.record!.mulaiJam}");

          fieldTglTrxController.text = state.record!.tglTrx!.toIso8601String();
        }
      },
    );
  }

  void loadData() {
    debugPrint("loadData #10");

    if (widget.viewMode == "ubah") {
      sewaCrudBloc.add(SewaCrudLihatEvent(recordId: widget.recordId));
    } else if (widget.viewMode == "tambah") {
      sewaCrudBloc.add(InitRecordEvent());
    }
  }

  void _dismissDialog() {
    Navigator.pop(context);
  }

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      debugPrint(
          "fieldComboCustomer!.mrekanId : ${fieldComboCustomer!.mrekanId}");

      SewaCrudModel record = SewaCrudModel(
          customerId: fieldComboCustomer!.mrekanId,
          keterangan: fieldKeteranganController.text,
          mmobilId: fieldComboMobil!.mmobilId,
          mwilayahId: fieldComboWilayah!.mwilayahId,
          supirId: fieldcomboSupirKontrak?.mstaffId,
          tglTrx: DateTime.parse(fieldTglTrxController.text),
          isLepaskunci: toBoolean(fieldIsLepaskunciController.text),
          isAntarMobil: false);          
      if (widget.viewMode == "tambah") {
        sewaCrudBloc.add(SewaCrudTambahEvent(record: record));
      } else if (widget.viewMode == "ubah") {
        record.sewa1Id = sewaCrudBloc.state.record!.sewa1Id;
        sewaCrudBloc.add(SewaCrudUbahEvent(record: record));
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
