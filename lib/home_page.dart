import 'package:flutter/material.dart';
import 'package:freelance_app/bloc/blocs/user_bloc.dart';
import 'package:freelance_app/bloc/events/user_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ProfilePage(),
      bottomNavigationBar: ColoredBox(
        color: const Color.fromARGB(255, 100, 181, 246),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  context.read<AuthUserBloc>().add(LogoutEvent());
                },
                icon: const Icon(
                  Icons.logout,
                  size: 34,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
