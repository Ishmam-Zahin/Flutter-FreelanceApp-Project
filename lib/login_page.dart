import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/blocs/image_bloc.dart';
import 'package:freelance_app/bloc/blocs/user_bloc.dart';
import 'package:freelance_app/bloc/events/user_event.dart';
import 'package:freelance_app/bloc/states/user_state.dart';
import 'package:freelance_app/data/repository/auth_user_repository.dart';
import 'package:freelance_app/signup_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _showErrorSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'HireHub',
              style: TextStyle(
                fontFamily: 'Wet',
                fontSize: 34,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const Text(
              'Welcome Back!',
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _loginFormKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email address',
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Value can\'t be empty';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      prefixIcon: Icon(
                        Icons.key,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'password can\' be empty!';
                      }
                      if (value.length <= 7) {
                        return 'pasword must be at least 8 chararcters long!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<AuthUserBloc, UserState>(
                    listener: (context, state) {
                      if (state is AuthUserErrorState) {
                        _showErrorSnackBar(
                          context,
                          state.error,
                          Colors.red,
                        );
                      }
                      if (state is AuthenticateUserSate) {
                        _showErrorSnackBar(
                          context,
                          'LOG IN SUCCESSFULL!',
                          Colors.green,
                        );
                      }
                    },
                    builder: (context, state) {
                      return FilledButton(
                        onPressed: () {
                          if (_loginFormKey.currentState!.validate()) {
                            _loginFormKey.currentState!.save();
                            context
                                .read<AuthUserBloc>()
                                .add(LoginEvent(_email, _password));
                          }
                        },
                        child: state is LoadingUserSate
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'LOG IN',
                              ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Get.to(
                            () => BlocProvider(
                              create: (context) => MyImageBloc(
                                context.read<AuthUserRepository>(),
                              ),
                              child: const SignUpPage(),
                            ),
                          );
                        },
                        child: const Text('SIGN UP'),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
