import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelance_app/bloc/blocs/image_bloc.dart';
import 'package:freelance_app/bloc/blocs/user_bloc.dart';
import 'package:freelance_app/bloc/events/image_events.dart';
import 'package:freelance_app/bloc/events/user_event.dart';
import 'package:freelance_app/bloc/states/image_states.dart';
import 'package:freelance_app/bloc/states/user_state.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpFormKey = GlobalKey<FormState>();
  String? _fullName;
  String? _email;
  String? _password;
  String? _phone;
  String? _address;
  XFile? _image;

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
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
                'Create your account now!',
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _signUpFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Full name/Company name',
                        prefixIcon: Icon(
                          Icons.manage_accounts,
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
                        _fullName = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                        _email = value;
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
                        _password = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Phone number',
                        prefixIcon: Icon(
                          Icons.phone,
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
                        _phone = value;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Company address',
                        prefixIcon: Icon(
                          Icons.home,
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
                        _address = value;
                      },
                    ),
                    BlocConsumer<MyImageBloc, MyImageStates>(
                      listener: (context, state) {
                        if (state is ImageLoadedState) {
                          _image = state.image;
                        }
                        if (state is ImageErrorSate) {
                          _image = null;
                          _showSnackBar(context, state.error, Colors.red);
                        }
                      },
                      builder: (context, state) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state is ImageLoadingState
                              ? const CircularProgressIndicator(
                                  color: Colors.blue,
                                )
                              : IconButton(
                                  onPressed: () {
                                    context
                                        .read<MyImageBloc>()
                                        .add(LoadImageEvent());
                                  },
                                  icon: const Icon(
                                    Icons.image,
                                    size: 34,
                                  ),
                                ),
                          state is ImageLoadedState
                              ? Image.file(
                                  File(state.image.path),
                                  width: 50,
                                  height: 50,
                                )
                              : const Text(
                                  'No Image',
                                ),
                        ],
                      ),
                    ),
                    const Text('Select an image'),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<AuthUserBloc, UserState>(
                      listener: (context, state) {
                        if (state is AuthenticateUserSate) {
                          Get.back();
                        }

                        if (state is CreateAuthUserErrorState) {
                          _showSnackBar(context, state.error, Colors.red);
                        }
                      },
                      builder: (context, state) => FilledButton(
                        onPressed: () {
                          if (_image == null) {
                            _showSnackBar(context, 'You must provide an image!',
                                Colors.red);
                            return;
                          }
                          if (_signUpFormKey.currentState!.validate()) {
                            _signUpFormKey.currentState!.save();
                            context.read<AuthUserBloc>().add(
                                  CreateUserEvent(
                                      name: _fullName!,
                                      email: _email!,
                                      password: _password!,
                                      phone: _phone!,
                                      address: _address!,
                                      image: _image!),
                                );
                          }
                        },
                        child: state is CreateLoadingUserState
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'SIGN UP',
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('LOG IN'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
