import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/common/constants.dart';
import 'package:rentcarapp/widgets/form_error.dart';
import 'package:rentcarapp/blocs/mstwilayah/wilayahcrud_bloc.dart';
import 'package:rentcarapp/models/mstwilayah/wilayahcrud_model.dart';


class WilayahCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const WilayahCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	WilayahCrudFormPageFormState createState() => WilayahCrudFormPageFormState();
}

class WilayahCrudFormPageFormState extends State<WilayahCrudFormPage> {
	late WilayahCrudBloc wilayahCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldWilayahNamaController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		wilayahCrudBloc = BlocProvider.of<WilayahCrudBloc>(context);
		return BlocConsumer<WilayahCrudBloc, WilayahCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Wilayah Sewa",
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
											controller: fieldWilayahNamaController,
											decoration: const InputDecoration(
												labelText: "wilayahNama",
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
						fieldWilayahNamaController.text = state.record!.wilayahNama;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		wilayahCrudBloc.add(
			WilayahCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			WilayahCrudModel record = WilayahCrudModel(
				mwilayahId: '',
				wilayahNama: fieldWilayahNamaController.text,
			);
			if (widget.viewMode == "tambah") {
				wilayahCrudBloc.add(WilayahCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mwilayahId = wilayahCrudBloc.state.record!.mwilayahId;
				wilayahCrudBloc.add(WilayahCrudUbahEvent(record: record));
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
