import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentcarapp/widgets/my_colors.dart';
import 'package:rentcarapp/widgets/my_text.dart';

class HargaCariTileWidget extends StatelessWidget {
	final double harga;
	final String mhargaId;
	final String curr;

	const HargaCariTileWidget(
		{super.key,
		required this.harga, 
		required this.mhargaId, 
		required this.curr, });

	@override
	Widget build(BuildContext context) {
		return Card(
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(15),
			),
			color: Colors.white,
			margin: const EdgeInsets.symmetric(horizontal: 10),
			elevation: 2,
			clipBehavior: Clip.antiAliasWithSaveLayer,
			child: Container(
				alignment: Alignment.topLeft,
				padding: const EdgeInsets.all(15),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(
							"$curr ${NumberFormat("#,###").format(harga)}",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
				]),
			)
		);
	}
}
