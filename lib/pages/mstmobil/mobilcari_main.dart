import 'package:flutter/material.dart';
import 'package:rentcarapp/pages/mstmobil/mobilcari_list.dart';

class MobilCariMainPage extends StatelessWidget {
	const MobilCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return const Scaffold(
			//backgroundColor: Colors.grey[200],
			body: MobilCariPage(),
		);
	}
}
