import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/common/constants.dart';
import 'package:rentcarapp/widgets/form_error.dart';
import 'package:rentcarapp/blocs/mstmasa/masacrud_bloc.dart';
import 'package:rentcarapp/models/mstmasa/masacrud_model.dart';

class MasaCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const MasaCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	MasaCrudFormPageFormState createState() => MasaCrudFormPageFormState();
}

class MasaCrudFormPageFormState extends State<MasaCrudFormPage> {
	late MasaCrudBloc masaCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldMasaNamaController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		masaCrudBloc = BlocProvider.of<MasaCrudBloc>(context);
		return BlocConsumer<MasaCrudBloc, MasaCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Masa Sewa",
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
											controller: fieldMasaNamaController,
											decoration: const InputDecoration(
												labelText: "masaNama",
												floatingLabelBehavior: FloatingLabelBehavior.always,
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
					));
				},
				listener: (context, state) {
					if (state.isLoaded) {
						fieldMasaNamaController.text = state.record!.masaNama;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		masaCrudBloc.add(
			MasaCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			MasaCrudModel record = MasaCrudModel(
				mmasaId: '',
				masaNama: fieldMasaNamaController.text,
			);
			if (widget.viewMode == "tambah") {
				masaCrudBloc.add(MasaCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mmasaId = masaCrudBloc.state.record!.mmasaId;
				masaCrudBloc.add(MasaCrudUbahEvent(record: record));
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
