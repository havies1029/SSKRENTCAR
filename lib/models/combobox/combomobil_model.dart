import 'package:equatable/equatable.dart';

class ComboMobilModel extends Equatable {
	final String mmobilId;
  final String platNo;
	final String warnaNama;
	final String tipeNama;
	final int thnBuat;

	const ComboMobilModel({this.mmobilId = "", this.platNo='', this.warnaNama='', this.tipeNama='', this.thnBuat=2000});

	factory ComboMobilModel.fromJson(Map<String, dynamic> data) =>
		ComboMobilModel(			
			mmobilId: data['mmobilId'],
			platNo: data['platNo'],
			warnaNama: data['warnaNama'],
			tipeNama: data['tipeNama'],
			thnBuat: data['thnBuat'],		
  );

	Map<String, dynamic> toJson() =>
		{
		'mmobilId': mmobilId,
		'platNo': platNo,
		'warnaNama': warnaNama,
		'tipeNama': tipeNama,
		'thnBuat': thnBuat};

	@override
	List<Object> get props => [mmobilId, platNo, warnaNama, tipeNama, thnBuat];
}
