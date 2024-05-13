class MasaCariModel {
	String masaNama;
	String mmasaId;

	MasaCariModel({required this.masaNama, required this.mmasaId});

	factory MasaCariModel.fromJson(Map<String, dynamic> data) =>
		MasaCariModel(
			masaNama: data['masaNama'],
			mmasaId: data['mmasaId']
		);

	Map<String, dynamic> toJson() =>
		{'masaNama': masaNama,
		'mmasaId': mmasaId};

}
