import 'package:flutter/material.dart';
import 'package:rentcarapp/pages/mstwarna/warnacari_list.dart';

class WarnaCariMainPage extends StatelessWidget {
	const WarnaCariMainPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey[100],
			body: const WarnaCariPage(),
		);
	}
}
