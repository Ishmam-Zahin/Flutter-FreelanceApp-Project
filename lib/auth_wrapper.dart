import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/blocs/home_page_bloc.dart';
import 'package:freelance_app/bloc/blocs/user_bloc.dart';
import 'package:freelance_app/bloc/states/user_state.dart';
import 'package:freelance_app/data/providers/add_job_provider.dart';
import 'package:freelance_app/data/providers/job_detail_provider.dart';
import 'package:freelance_app/data/providers/job_list_provider.dart';
import 'package:freelance_app/data/providers/job_types_provider.dart';
import 'package:freelance_app/data/repository/home_page_repository.dart';
import 'package:freelance_app/home_page.dart';
import 'package:freelance_app/login_page.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthUserBloc, UserState>(
      builder: (context, state) {
        if (state is AuthenticateUserSate) {
          return BlocProvider(
            create: (context) => HomePageBloc(),
            child: BlocProvider(
              create: (context) => HomePageBloc(),
              child: const HomePage(),
            ),
          );
        }

        return const LoginPage();
      },
    );
  }
}
