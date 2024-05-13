import 'package:flutter/material.dart';
import 'package:rentcarapp/pages/mstmerk/merkcari_list.dart';

class MerkCariMainPage extends StatelessWidget {
  const MerkCariMainPage({super.key});

  @override
  Widget build(BuildContext context) {   
      
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const MerkCariPage(),
      
    );
  }
}
