import 'package:flutter/material.dart';
import 'package:rentcarapp/pages/sewamobil/sewacari_list.dart';

class SewaCariMainPage extends StatelessWidget {
	const SewaCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const SewaCariPage(),
		);
	}
}
