import 'package:flutter/material.dart';
import 'package:rentcarapp/pages/mstwilayah/wilayahcari_list.dart';

class WilayahCariMainPage extends StatelessWidget {
	const WilayahCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const WilayahCariPage(),
		);
	}
}
