import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/common/constants.dart';
import 'package:rentcarapp/widgets/form_error.dart';
import 'package:rentcarapp/blocs/mstwarna/warnacrud_bloc.dart';
import 'package:rentcarapp/models/mstwarna/warnacrud_model.dart';


class WarnaCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const WarnaCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	WarnaCrudFormPageFormState createState() => WarnaCrudFormPageFormState();
}

class WarnaCrudFormPageFormState extends State<WarnaCrudFormPage> {
	late WarnaCrudBloc warnaCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldWarnaNamaController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		warnaCrudBloc = BlocProvider.of<WarnaCrudBloc>(context);
		return BlocConsumer<WarnaCrudBloc, WarnaCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Warna",
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
											controller: fieldWarnaNamaController,
											decoration: const InputDecoration(
												labelText: "warnaNama",
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
						fieldWarnaNamaController.text = state.record!.warnaNama;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		warnaCrudBloc.add(
			WarnaCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			WarnaCrudModel record = WarnaCrudModel(
				mwarnaId: '',
				warnaNama: fieldWarnaNamaController.text,
			);
			if (widget.viewMode == "tambah") {
				warnaCrudBloc.add(WarnaCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mwarnaId = warnaCrudBloc.state.record!.mwarnaId;
				warnaCrudBloc.add(WarnaCrudUbahEvent(record: record));
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
