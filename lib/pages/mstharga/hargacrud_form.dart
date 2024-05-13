import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rentcarapp/common/constants.dart';
import 'package:rentcarapp/widgets/form_error.dart';
import 'package:rentcarapp/blocs/mstharga/hargacrud_bloc.dart';
import 'package:rentcarapp/models/mstharga/hargacrud_model.dart';

class HargaCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const HargaCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	HargaCrudFormPageFormState createState() => HargaCrudFormPageFormState();
}

class HargaCrudFormPageFormState extends State<HargaCrudFormPage> {
	late HargaCrudBloc hargaCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];	
	var fieldHargaController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		hargaCrudBloc = BlocProvider.of<HargaCrudBloc>(context);
		return BlocConsumer<HargaCrudBloc, HargaCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Harga Sewa",
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
											controller: fieldHargaController,
											decoration: const InputDecoration(
												labelText: "harga",
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
						fieldHargaController.text =  NumberFormat("#,###").parse(state.record!.harga.toString()).toString();
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		hargaCrudBloc.add(
			HargaCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			HargaCrudModel record = HargaCrudModel(
				mhargaId: '',				
				harga: double.parse(fieldHargaController.text),
			);
			if (widget.viewMode == "tambah") {
				hargaCrudBloc.add(HargaCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mhargaId = hargaCrudBloc.state.record!.mhargaId;
				hargaCrudBloc.add(HargaCrudUbahEvent(record: record));
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
