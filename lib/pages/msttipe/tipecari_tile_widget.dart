import 'package:flutter/material.dart';
import 'package:rentcarapp/widgets/my_colors.dart';
import 'package:rentcarapp/widgets/my_text.dart';

class TipeCariTileWidget extends StatelessWidget {
	final String merkNama;
	final String mmerkId;
	final String mtipeId;
	final String tipeNama;

	const TipeCariTileWidget(
		{super.key,
		required this.merkNama, 
		required this.mmerkId, 
		required this.mtipeId, 
		required this.tipeNama});

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
							tipeNama,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 10),
				]),
			)
		);
	}
}
