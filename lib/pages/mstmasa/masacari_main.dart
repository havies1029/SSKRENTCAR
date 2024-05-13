import 'package:flutter/material.dart';
import 'package:rentcarapp/pages/mstmasa/masacari_list.dart';

class MasaCariMainPage extends StatelessWidget {
	const MasaCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const MasaCariPage(),
		);
	}
}
