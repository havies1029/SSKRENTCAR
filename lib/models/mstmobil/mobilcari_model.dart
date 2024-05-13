class MobilCariModel {	
	String? insurerNama;
	String mmobilId;	
	String? statusNama;	
	String? tipeNama;	
	String? warnaNama;
	String platNo;
	DateTime? polisAkhir;
	DateTime? polisMulai;
	String? polisNo;
	String stnkNo;
	DateTime stnkTempo;
	int thnBuat;

	MobilCariModel({this.insurerNama, required this.mmobilId, this.statusNama, 
    this.tipeNama, this.warnaNama, required this.platNo, 
		this.polisAkhir, this.polisMulai, 
		this.polisNo, required this.stnkNo, 
		required this.stnkTempo, required this.thnBuat});

	factory MobilCariModel.fromJson(Map<String, dynamic> data) =>
		MobilCariModel(			
			insurerNama: data['insurerNama']??"",
			mmobilId: data['mmobilId']??"",			
			statusNama: data['statusNama']??"",			
			tipeNama: data['tipeNama']??"",			
			warnaNama: data['warnaNama']??"",
			platNo: data['platNo']??"",
      polisMulai: data["polisMulai"]!=null?DateTime.tryParse(data['polisMulai']):null,
      polisAkhir: data["polisMulai"]!=null?DateTime.tryParse(data['polisAkhir']):null,
			//polisAkhir: DateTime.tryParse(data['polisAkhir']),
			//polisMulai: DateTime.tryParse(data['polisMulai']),
			polisNo: data['polisNo']??"",
			stnkNo: data['stnkNo']??"",
			stnkTempo: DateTime.tryParse(data['stnkTempo'])??DateTime.now(),
			thnBuat: int.tryParse(data['thnBuat'].toString())??0
		);

	Map<String, dynamic> toJson() =>
		{
		'insurerNama': insurerNama,
		'mmobilId': mmobilId,		
		'statusNama': statusNama,		
		'tipeNama': tipeNama,		
		'warnaNama': warnaNama,
		'platNo': platNo,
		'polisAkhir': polisAkhir?.toIso8601String(),
		'polisMulai': polisMulai?.toIso8601String(),
		'polisNo': polisNo,
		'stnkNo': stnkNo,
		'stnkTempo': stnkTempo.toIso8601String(),
		'thnBuat': thnBuat.toString()};

}
