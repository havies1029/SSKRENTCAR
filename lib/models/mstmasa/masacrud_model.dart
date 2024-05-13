class MasaCrudModel {
	String masaNama;
	String mmasaId;

	MasaCrudModel({required this.masaNama, required this.mmasaId});

	factory MasaCrudModel.fromJson(Map<String, dynamic> data) =>
		MasaCrudModel(
			masaNama: data['masaNama'],
			mmasaId: data['mmasaId']
		);

	Map<String, dynamic> toJson() =>
		{'masaNama': masaNama,
		'mmasaId': mmasaId};

}
