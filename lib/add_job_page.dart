import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/auth_wrapper.dart';
import 'package:freelance_app/bloc/blocs/user_bloc.dart';
import 'package:freelance_app/bloc/states/user_state.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key});

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  String? _title;
  String? _dsc;
  String? _deadlineDate;
  @override
  Widget build(BuildContext context) {
    final AuthenticateUserSate x =
        context.read<AuthUserBloc>().state as AuthenticateUserSate;
    print(x.myAuthUser.userId);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Upload A New Work',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      hint: const Text('Catagory'),
                      items: List.generate(
                        6,
                        (count) {
                          return DropdownMenuItem(
                            value: count,
                            child: Text(count.toString()),
                          );
                        },
                      ),
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Description'),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('DeadLine Date'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('POST'),
            ),
          ],
        ),
      ),
    );
  }
}
