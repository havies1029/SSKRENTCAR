class SewaCariModel {
	
	double biayaTotal;	
	String customerNama;
	bool isLepaskunci;
	String masaNama;
	String platNo;
	String wilayahNama;
	int qty;
	DateTime akhirTgl;
	DateTime akhirJam;
	DateTime mulaiTgl;
	DateTime mulaiJam;
	String sewa1Id;
	String supirNama;
	DateTime tglTrx;
	String statusSewa;

	SewaCariModel({required this.biayaTotal, required this.isLepaskunci, 
		required this.masaNama, required this.platNo, required this.wilayahNama, 
		required this.qty, required this.akhirTgl, 
		required this.akhirJam, required this.mulaiTgl, 
		required this.mulaiJam, required this.sewa1Id, 
		required this.customerNama, required this.supirNama, 
    required this.tglTrx, required this.statusSewa});

	factory SewaCariModel.fromJson(Map<String, dynamic> data) =>
		SewaCariModel(			
			biayaTotal: double.tryParse(data['biayaTotal'].toString())??0,			
			customerNama: data['customerNama']??"",			
			isLepaskunci: data['isLepaskunci'],
			masaNama: data['masaNama']??"",
			platNo: data['platNo']??"",			
			wilayahNama: data['wilayahNama']??"",
			qty: int.tryParse(data['qty'].toString())??0,
			akhirTgl: DateTime.tryParse(data['akhirTgl'])??DateTime.now(),
			akhirJam: DateTime.tryParse(data['akhirJam'])??DateTime.now(),
			mulaiTgl: DateTime.tryParse(data['mulaiTgl'])??DateTime.now(),
			mulaiJam: DateTime.tryParse(data['mulaiJam'])??DateTime.now(),
			sewa1Id: data['sewa1Id'],			
			supirNama: data['supirNama']??"",
			tglTrx: DateTime.tryParse(data['tglTrx'])??DateTime.now(),      
			statusSewa: data['statusSewa']??"",
		);

	Map<String, dynamic> toJson() =>
		{
		'biayaTotal': biayaTotal.toString(),		
		'customerNama': customerNama,
		'isLepaskunci': isLepaskunci,		
		'masaNama': masaNama,
		'platNo': platNo,
		'wilayahNama': wilayahNama,
		'qty': qty.toString(),
		'akhirTgl': akhirTgl.toIso8601String(),
		'akhirJam': akhirJam.toIso8601String(),
		'mulaiTgl': mulaiTgl.toIso8601String(),
		'mulaiJam': mulaiJam.toIso8601String(),
		'sewa1Id': sewa1Id,
		'supirNama': supirNama,
		'tglTrx': tglTrx.toIso8601String(),
		'statusSewa': statusSewa};

}
