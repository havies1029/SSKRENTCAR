import 'package:flutter/material.dart';
import 'package:rentcarapp/pages/msttipe/tipecari_list.dart';

class TipeCariMainPage extends StatelessWidget {
	const TipeCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const TipeCariPage(),
		);
	}
}
