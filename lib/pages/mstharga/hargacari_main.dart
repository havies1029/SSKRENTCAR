import 'package:flutter/material.dart';
import 'package:rentcarapp/pages/mstharga/hargacari_list.dart';

class HargaCariMainPage extends StatelessWidget {
	const HargaCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const HargaCariPage(),
		);
	}
}
