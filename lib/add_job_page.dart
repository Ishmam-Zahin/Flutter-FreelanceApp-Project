import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/blocs/add_job_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_types_bloc.dart';
import 'package:freelance_app/bloc/blocs/user_bloc.dart';
import 'package:freelance_app/bloc/events/add_job_events.dart';
import 'package:freelance_app/bloc/events/job_types_events.dart';
import 'package:freelance_app/bloc/states/add_job_states.dart';
import 'package:freelance_app/bloc/states/job_types_states.dart';
import 'package:freelance_app/bloc/states/user_state.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key});

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _dsc;
  String? _deadlineDate;
  int? _typeId;

  void _showSnackBar(BuildContext context, String message, Color color) {
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
      appBar: AppBar(
        title: const Text(
          'HireHub',
          style: TextStyle(
            fontFamily: 'Wet',
            fontSize: 34,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Form(
              key: _formKey,
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
                    BlocBuilder<JobTypesBloc, MyJobTypesStates>(
                      builder: (context, state) {
                        if (state is JobTypesInitialState) {
                          context.read<JobTypesBloc>().add(LoadJobTypesEvent());
                        }
                        if (state is JobTypesLoadedState) {
                          final List<Map<String, dynamic>> types =
                              state.myjobTypesModel.jobTypes;
                          return DropdownButtonFormField(
                            hint: const Text(
                              'Select Catagory',
                            ),
                            items: List.generate(types.length, (count) {
                              return DropdownMenuItem(
                                value: types[count]['id'],
                                child: Text(
                                  types[count]['type_name'],
                                ),
                              );
                            }),
                            onChanged: (value) {
                              _typeId = value as int;
                            },
                            onSaved: (value) {
                              _typeId = value as int;
                            },
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'required field';
                        }
                        if (value.length <= 5) {
                          return 'field must be greater than 5 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _title = value;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Description'),
                      ),
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'required field';
                        }
                        if (value.length <= 30) {
                          return 'field must be greater than 30 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _dsc = value;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('DeadLine Date'),
                      ),
                      validator: (value) {
                        try {
                          if (value == null || value == '') {
                            return 'required field';
                          }
                          DateTime.parse(value);
                          return null;
                        } catch (e) {
                          return 'Invalid Date';
                        }
                      },
                      onSaved: (value) {
                        _deadlineDate = value;
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            BlocConsumer<AddJobBloc, MyAddJobStates>(
              listener: (context, state) {
                if (state is AddJobLoadedState) {
                  _showSnackBar(
                    context,
                    'JOB UPLOADED SUCCESSFULLY!',
                    Colors.green,
                  );
                }
                if (state is AddJobErrorState) {
                  _showSnackBar(
                    context,
                    state.error,
                    Colors.red,
                  );
                }
              },
              builder: (context, state) => ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final AuthenticateUserSate userState = context
                        .read<AuthUserBloc>()
                        .state as AuthenticateUserSate;
                    final String userId = userState.myAuthUser.userId;
                    context.read<AddJobBloc>().add(
                          UploadJobEvent(
                            title: _title!,
                            dsc: _dsc!,
                            deadlineDate: _deadlineDate!,
                            userId: userId,
                            typeId: _typeId!,
                          ),
                        );
                  }
                },
                child: const Text('POST'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
