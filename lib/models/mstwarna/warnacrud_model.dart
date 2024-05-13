class WarnaCrudModel {
	String mwarnaId;
	String warnaNama;

	WarnaCrudModel({required this.mwarnaId, required this.warnaNama});

	factory WarnaCrudModel.fromJson(Map<String, dynamic> data) =>
		WarnaCrudModel(
			mwarnaId: data['mwarnaId'],
			warnaNama: data['warnaNama']
		);

	Map<String, dynamic> toJson() =>
		{'mwarnaId': mwarnaId,
		'warnaNama': warnaNama};

}
