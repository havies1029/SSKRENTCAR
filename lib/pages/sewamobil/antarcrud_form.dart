import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/common/constants.dart';
import 'package:rentcarapp/widgets/form_error.dart';
import 'package:rentcarapp/blocs/sewamobil/antarcrud_bloc.dart';
import 'package:rentcarapp/models/sewamobil/antarcrud_model.dart';
import 'package:rentcarapp/models/combobox/combosupir_model.dart';
import 'package:rentcarapp/widgets/combobox/combosupir_widget.dart';
import 'package:intl/intl.dart';
import 'package:rentcarapp/common/thousand_separator_input_formatter.dart';


class AntarCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const AntarCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	AntarCrudFormPageFormState createState() => AntarCrudFormPageFormState();
}

class AntarCrudFormPageFormState extends State<AntarCrudFormPage> {
	late AntarCrudBloc antarCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldAlamat1Controller = TextEditingController();
	var fieldAlamat2Controller = TextEditingController();
	var fieldBiayaController = TextEditingController();
	var fieldKeteranganController = TextEditingController();
	var fieldPicNamaController = TextEditingController();
	var fieldPicTelpController = TextEditingController();
	ComboSupirModel? fieldComboSupir;

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		antarCrudBloc = BlocProvider.of<AntarCrudBloc>(context);
		return BlocConsumer<AntarCrudBloc, AntarCrudState>(
			builder: (context, state) {
				return Dialog(
					shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
					child: SingleChildScrollView(
						child: Padding(
							padding: const EdgeInsets.all(8.0),
							child: Form(
								key: _formKey,
								child: Column(
									children: [
										const SizedBox(height: 10),
										Text(
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Antar Mobil",
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
										TextFormField(
											keyboardType: TextInputType.multiline,
											minLines: 1,
											maxLines: 3,
											controller: fieldAlamat1Controller,
											decoration: const InputDecoration(
												labelText: "alamat1",
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
										TextFormField(
											keyboardType: TextInputType.multiline,
											minLines: 1,
											maxLines: 3,
											controller: fieldAlamat2Controller,
											decoration: const InputDecoration(
												labelText: "alamat2",
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
										TextFormField(
											keyboardType: TextInputType.number,
											inputFormatters: [ThousandsSeparatorInputFormatter()],
											controller: fieldBiayaController,
											decoration: const InputDecoration(
												labelText: "biaya",
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
											textAlign: TextAlign.right,
										),
										TextFormField(
											keyboardType: TextInputType.multiline,
											minLines: 1,
											maxLines: 3,
											controller: fieldKeteranganController,
											decoration: const InputDecoration(
												labelText: "keterangan",
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
										TextFormField(
											controller: fieldPicNamaController,
											decoration: const InputDecoration(
												labelText: "picNama",
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
										TextFormField(
											controller: fieldPicTelpController,
											decoration: const InputDecoration(
												labelText: "picTelp",
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
										TextFormField(
										),
										buildFieldComboSupir(
											labelText: 'supirId',
											initItem: fieldComboSupir,
											onChangedCallback: (value) {
												if (value != null) {
													removeError(
														error: "Field ComboSupir tidak boleh kosong.");
													fieldComboSupir = value;
												}
											},
											onSaveCallback: (value) {
												if (value != null) {
													fieldComboSupir = value;
												}
											},
											validatorCallback: (value) {
												if (value == null) {
													addError(
														error: "Field ComboSupir tidak boleh kosong.");
												}
											},
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
						fieldBiayaController.text = NumberFormat("#,###").format(state.record!.biaya);
						fieldKeteranganController.text = state.record!.keterangan;
						fieldPicNamaController.text = state.record!.picNama;
						fieldPicTelpController.text = state.record!.picTelp;
						fieldComboSupir = state.record!.comboSupir;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		antarCrudBloc.add(
			AntarCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			AntarCrudModel record = AntarCrudModel(
				alamat1: fieldAlamat1Controller.text,
				alamat2: fieldAlamat2Controller.text,
				antarmobilId: '',
				biaya: double.parse(fieldBiayaController.text.replaceAll(',', '')),
				keterangan: fieldKeteranganController.text,
				picNama: fieldPicNamaController.text,
				picTelp: fieldPicTelpController.text,
				supirId: fieldComboSupir?.mstaffId,
			);
			if (widget.viewMode == "tambah") {
				antarCrudBloc.add(AntarCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.antarmobilId = antarCrudBloc.state.record!.antarmobilId;
				antarCrudBloc.add(AntarCrudUbahEvent(record: record));
			}
			_dismissDialog();
		}
	}

	void addError({required String error}) {
		if (!errors.contains(error)){
			setState(() {
				errors.add(error);
			});
		}
	}

	void removeError({required String error}) {
		if (errors.contains(error)){
			setState(() {
				errors.remove(error);
			});
		}
	}

}
