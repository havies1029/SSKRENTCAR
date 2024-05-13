import 'package:flutter/material.dart';
import 'package:rentcarapp/widgets/my_colors.dart';
import 'package:rentcarapp/widgets/my_text.dart';

class MasaCariTileWidget extends StatelessWidget {
	final String masaNama;
	final String mmasaId;

	const MasaCariTileWidget(
		{super.key,
		required this.masaNama, 
		required this.mmasaId});

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
						Text("masaNama",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
							Container(height: 5),
						Text(
							masaNama,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
							Container(height: 10),
						Text("mmasaId",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
							Container(height: 5),
						Text(
							mmasaId,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
							Container(height: 10),
				]),
			)
		);
	}
}
