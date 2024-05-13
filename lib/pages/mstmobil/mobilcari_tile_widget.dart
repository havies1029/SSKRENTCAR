import 'package:flutter/material.dart';
import 'package:rentcarapp/widgets/my_colors.dart';
import 'package:rentcarapp/widgets/my_text.dart';

class MobilCariTileWidget extends StatelessWidget {
	final String mmobilId;
	final String platNo;
	final DateTime? polisAkhir;
	final DateTime? polisMulai;
	final String? polisNo;
	final String? insurerNama;
	final String statusNama;
	final String stnkNo;
	final DateTime stnkTempo;
	final int thnBuat;
	final String tipeNama;
	final String warnaNama;

	const MobilCariTileWidget(
		{super.key,		
		required this.mmobilId, 		
		required this.platNo, 
		this.polisAkhir, 
		this.polisMulai, 
		this.polisNo, 
		this.insurerNama, 
		required this.statusNama, 
		required this.stnkNo, 
		required this.stnkTempo, 
		required this.thnBuat, 
		required this.tipeNama, 
		required this.warnaNama});

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
						Text("Plat No. : $platNo",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 5),						
            const Divider(height: 10, thickness: 1.0, color: Colors.greenAccent,),  
						Container(height: 5),
            Text("Tipe Mobil",
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_40)),
						Container(height: 5),
						Text(
							tipeNama,
							style: MyText.bodyLarge(context)!
								.copyWith(color: MyColors.grey_80)),
						Container(height: 5),
            const Divider(height: 10, thickness: 5.0, color: Colors.greenAccent,),            
						Container(height: 5),
						Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
						  children: [
                Column(
						      children: [
                    Text("Tahun",
                      style: MyText.bodyLarge(context)!
                        .copyWith(color: MyColors.grey_40)),
                    Container(height: 5),
                    Text(
                      thnBuat.toString(),
                      style: MyText.bodyLarge(context)!
                        .copyWith(color: MyColors.grey_80)),
                  ],
						    ),

						    Column(
						      children: [
						        Text("Warna",
                      style: MyText.bodyLarge(context)!
                        .copyWith(color: MyColors.grey_40)),
                    Container(height: 5),
                    Text(
                      warnaNama,
                      style: MyText.bodyLarge(context)!
                        .copyWith(color: MyColors.grey_80)),
						      ],
						    ),

                Column(
						      children: [
						        Text("Status",
						        	style: MyText.bodyLarge(context)!
						        		.copyWith(color: MyColors.grey_40)),
                    Container(height: 5),
                    Text(
                      statusNama,
                      style: MyText.bodyLarge(context)!
                        .copyWith(color: MyColors.grey_80)),
						      ],
						    ),

						  ],
						),
						
						Container(height: 10),												
						
				]),
			)
		);
	}
}
