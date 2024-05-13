class RekanCariModel {
	String alamat1;
	String alamat2;
	String ktpNo;
	String mrekanId;
	String mtiperekanId;
	String mtitleId;
	String? titleDesc;
	String rekanNama;
	String telp1;
	String telp2;

	RekanCariModel({required this.alamat1, required this.alamat2, 
		required this.ktpNo, required this.mrekanId, 
		required this.mtiperekanId, required this.mtitleId, this.titleDesc, 
		required this.rekanNama, required this.telp1, 
		required this.telp2});

	factory RekanCariModel.fromJson(Map<String, dynamic> data) =>
		RekanCariModel(
			alamat1: data['alamat1'],
			alamat2: data['alamat2'],
			ktpNo: data['ktpNo'],
			mrekanId: data['mrekanId'],
			mtiperekanId: data['mtiperekanId'],
			mtitleId: data['mtitleId'],
			titleDesc: data['titleDesc'],
			rekanNama: data['rekanNama'],
			telp1: data['telp1'],
			telp2: data['telp2']
		);

	Map<String, dynamic> toJson() =>
		{'alamat1': alamat1,
		'alamat2': alamat2,
		'ktpNo': ktpNo,
		'mrekanId': mrekanId,
		'mtiperekanId': mtiperekanId,
		'mtitleId': mtitleId,
		'titleDesc': titleDesc,
		'rekanNama': rekanNama,
		'telp1': telp1,
		'telp2': telp2};

}
