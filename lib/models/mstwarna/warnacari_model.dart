class WarnaCariModel {
	String mwarnaId;
	String warnaNama;

	WarnaCariModel({required this.mwarnaId, required this.warnaNama});

	factory WarnaCariModel.fromJson(Map<String, dynamic> data) =>
		WarnaCariModel(
			mwarnaId: data['mwarnaId'],
			warnaNama: data['warnaNama']
		);

	Map<String, dynamic> toJson() =>
		{'mwarnaId': mwarnaId,
		'warnaNama': warnaNama};

}
