import 'package:equatable/equatable.dart';

class ComboWarnaModel extends Equatable {
	final String mwarnaId;
	final String warnaNama;

	const ComboWarnaModel({this.mwarnaId='', this.warnaNama=''});

	factory ComboWarnaModel.fromJson(Map<String, dynamic> data) =>
		ComboWarnaModel(
			mwarnaId: data['mwarnaId'],
			warnaNama: data['warnaNama']
		);

	Map<String, dynamic> toJson() =>
		{'mwarnaId': mwarnaId,
		'warnaNama': warnaNama};

	@override
	List<Object> get props => [mwarnaId, warnaNama];
}
