class WilayahCrudModel {
	String mwilayahId;
	String wilayahNama;

	WilayahCrudModel({required this.mwilayahId, required this.wilayahNama});

	factory WilayahCrudModel.fromJson(Map<String, dynamic> data) =>
		WilayahCrudModel(
			mwilayahId: data['mwilayahId'],
			wilayahNama: data['wilayahNama']
		);

	Map<String, dynamic> toJson() =>
		{'mwilayahId': mwilayahId,
		'wilayahNama': wilayahNama};

}
