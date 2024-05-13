import 'package:flutter/material.dart';
import 'package:rentcarapp/pages/mstmobil/mobilcrud_form.dart';
import 'package:rentcarapp/widgets/mobiledesign_widget.dart';

class MobilCrudMainPage extends StatelessWidget {
  final String viewMode;
  final String recordId;

  const MobilCrudMainPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  Widget build(BuildContext context) {   

    return MobileDesignWidget(
        child: Scaffold(
            appBar: AppBar(
              title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Mobil'),
            ),
            //backgroundColor: Colors.grey[200],
            body: MobilCrudFormPage(viewMode: viewMode, recordId: recordId)));
  }
}
