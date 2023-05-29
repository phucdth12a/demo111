import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mvvm_bloc/features/auth/login/bloc/login_bloc.dart';
import 'package:mvvm_bloc/features/auth/login/service/login_service.dart';
import 'package:mvvm_bloc/product/service/auth_service.dart';
import 'package:mvvm_bloc/product/widget/project_background_widget.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            service: LoginService(
              context.read<AuthService>(),
            ),
          ),
          child: Stack(
            children: [
              const BackGround(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginAuthForm extends StatefulHookWidget {
  const _LoginAuthForm({super.key});

  @override
  State<_LoginAuthForm> createState() => __LoginAuthFormState();
}

class __LoginAuthFormState extends State<_LoginAuthForm> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
