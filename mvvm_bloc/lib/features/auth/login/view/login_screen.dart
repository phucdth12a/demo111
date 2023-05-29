import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kartal/kartal.dart';
import 'package:mvvm_bloc/features/auth/login/bloc/login_bloc.dart';
import 'package:mvvm_bloc/features/auth/login/bloc/login_event.dart';
import 'package:mvvm_bloc/features/auth/login/service/login_service.dart';
import 'package:mvvm_bloc/gen/assets.gen.dart';
import 'package:mvvm_bloc/gen/colors.gen.dart';
import 'package:mvvm_bloc/product/constants/project_padding.dart';
import 'package:mvvm_bloc/product/navigator/app_router.gr.dart';
import 'package:mvvm_bloc/product/service/auth_service.dart';
import 'package:mvvm_bloc/product/widget/project_background_widget.dart';
import 'package:mvvm_bloc/product/widget/project_elevated_button.dart';
import 'package:mvvm_bloc/product/widget/project_text_field.dart';
import 'package:mvvm_bloc/product/widget/question_do_button.dart';
import 'package:mvvm_bloc/product/widget/small_text_button.dart';

import '../bloc/login_state.dart';

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
              Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Flexible(
                    child: LoginAuthForm(
                      context: context,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginAuthForm extends StatefulHookWidget {
  const LoginAuthForm({super.key, required this.context});

  final BuildContext context;

  @override
  State<LoginAuthForm> createState() => _LoginAuthFormState();
}

class _LoginAuthFormState extends State<LoginAuthForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Center(
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.message),
              ),
            );
          } else if (state is LoginComplete) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login Success'),
              ),
            );
          } else if (state is NavigateToRegisterState) {
            AutoRouter.of(context).push(const RegisterScreen());
          }
        },
        builder: (context, state) {
          return Opacity(
            opacity: state is LoginLoadingState ? 0.4 : 1,
            child: IgnorePointer(
              ignoring: state is LoginLoadingState,
              child: Card(
                elevation: 7,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: context.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: _loginForm(
                    emailController,
                    passwordController,
                    context,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Form _loginForm(TextEditingController emailController,
      TextEditingController passwordController, BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProjectTextFormField(
            hintText: "auth.email".tr(),
            controller: emailController,
          ),
          ProjectTextFormField(
            hintText: "auth.password".tr(),
            controller: passwordController,
          ),
          _iForgotMyPassword(),
          ProjectElevantedButton(
            name: "auth.login".tr(),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                context.read<LoginBloc>().add(
                      SignInEvent(
                          email: emailController.text,
                          password: passwordController.text),
                    );
              }
            },
          ),
          _signInMethods(),
          QuestionDoButton(
            question: ' ${"auth.not_registered_yet".tr()}? ',
            doText: "${"auth.register".tr()}!",
            onTap: () {
              context.read<LoginBloc>().add(NavigateToRegisterEvent());
            },
          ),
        ],
      ),
    );
  }

  Padding _signInMethods() {
    return Padding(
      padding: ProjectPadding.primaryPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Assets.icons.facebookBrands.svg(
            height: 35,
            colorFilter: const ColorFilter.mode(
              ColorName.facebookColor,
              BlendMode.srcIn,
            ),
          ),
          Assets.icons.googleBrands.svg(
            height: 35,
            colorFilter: const ColorFilter.mode(
              ColorName.googleColor,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }

  Align _iForgotMyPassword() {
    return Align(
      alignment: Alignment.topRight,
      child: SmallTextButton(
        text: 'I forgot my password',
        onTap: () {},
      ),
    );
  }
}
