import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rentcarapp/widgets/my_colors.dart';
import 'package:rentcarapp/widgets/my_text.dart';

class SewaCariTileWidget extends StatelessWidget {  
  final double biayaTotal;    
  final bool isLepaskunci;  
  final String masaNama;
  final String platNo;
  final int qty;
  final String customerNama;
  final DateTime akhirTgl;
  final DateTime akhirJam;
  final DateTime mulaiTgl;
  final DateTime mulaiJam;
  final String sewa1Id;
  final String supirNama;
  final DateTime tglTrx;
  final String wilayahNama;
  final String statusSewa;

  const SewaCariTileWidget(
      {super.key,     
      required this.biayaTotal,
      required this.isLepaskunci,
      required this.masaNama,
      required this.platNo,
      required this.qty,
      required this.customerNama,
      required this.akhirTgl,
      required this.akhirJam,
      required this.mulaiTgl,
      required this.mulaiJam,
      required this.sewa1Id,
      required this.supirNama,
      required this.tglTrx,
      required this.wilayahNama,
      required this.statusSewa});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Booking No.",
                            style: MyText.bodyLarge(context)!
                                .copyWith(color: MyColors.grey_40)),
                        Container(height: 5),
                        Text(sewa1Id,
                            style: MyText.bodyLarge(context)!
                                .copyWith(color: MyColors.grey_80)),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Booking Tgl",
                            style: MyText.bodyLarge(context)!
                                .copyWith(color: MyColors.grey_40)),
                        Container(height: 5),
                        Text(DateFormat("dd/MM/yyyy").format(tglTrx),
                            style: MyText.bodyLarge(context)!
                                .copyWith(color: MyColors.grey_80)),
                      ],
                    ),
                  ),
                ],
              ),
            Container(height: 10),
            Text("Customer",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(customerNama,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("biayaTotal",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(NumberFormat("#,###").format(biayaTotal),
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            
            Container(height: 10),
            Text("isLepaskunci",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(isLepaskunci.toString(),
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            
            Text("masaNama",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(masaNama,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            
            Text("platNo",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(platNo,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("qty",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(NumberFormat("#,###").format(qty),
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            
            Text("akhirTgl",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(akhirTgl.toString(),
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("akhirJam",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(akhirJam.toString(),
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("mulaiTgl",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(mulaiTgl.toString(),
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("mulaiJam",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(mulaiJam.toString(),
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            
            Text("supirNama",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(supirNama,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),            
            
            Text("wilayahNama",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(wilayahNama,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
            Text("statusSewa",
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_40)),
            Container(height: 5),
            Text(statusSewa,
                style: MyText.bodyLarge(context)!
                    .copyWith(color: MyColors.grey_80)),
            Container(height: 10),
          ]),
        ));
  }
}
