import 'package:flutter/material.dart';
import 'package:rentcarapp/pages/sewamobil/sewacrud_form.dart';
import 'package:rentcarapp/widgets/mobiledesign_widget.dart';

class SewaCrudMainPage extends StatelessWidget {
  final String viewMode;
  final String recordId;

  const SewaCrudMainPage(
      {super.key, required this.viewMode, required this.recordId});

  @override
  Widget build(BuildContext context) {   

    return MobileDesignWidget(
        child: Scaffold(
            appBar: AppBar(
              title: Text('${viewMode == "tambah"?"Tambah":"Ubah"} Sewa'),
            ),
            //backgroundColor: Colors.grey[200],
            body: SewaCrudFormPage(viewMode: viewMode, recordId: recordId)));
  }
}
