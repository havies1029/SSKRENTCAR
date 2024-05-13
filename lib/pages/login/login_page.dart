import 'package:rentcarapp/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcarapp/repositories/user/user_repository.dart';

import 'package:rentcarapp/blocs/authentication/authentication_bloc.dart';
import 'package:rentcarapp/blocs/login/login_bloc.dart';
import 'package:rentcarapp/pages/login/login_form.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  const LoginPage({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    //debugPrint("Masuk ke Login Page");

    return MobileDesignWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: userRepository,
            );
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}
