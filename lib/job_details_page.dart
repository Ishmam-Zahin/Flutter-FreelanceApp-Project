import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/blocs/change_job_isactive_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_comment_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_detail_bloc.dart';
import 'package:freelance_app/bloc/blocs/post_job_comment_bloc.dart';
import 'package:freelance_app/bloc/blocs/send_mail_bloc.dart';
import 'package:freelance_app/bloc/blocs/send_mail_validity_bloc.dart';
import 'package:freelance_app/bloc/blocs/user_bloc.dart';
import 'package:freelance_app/bloc/events/change_job_isactive_events.dart';
import 'package:freelance_app/bloc/events/job_comments_events.dart';
import 'package:freelance_app/bloc/events/job_detail_events.dart';
import 'package:freelance_app/bloc/events/send_mail_events.dart';
import 'package:freelance_app/bloc/states/change_job_isActive_states.dart';
import 'package:freelance_app/bloc/states/job_comments_states.dart';
import 'package:freelance_app/bloc/states/job_detail_states.dart';
import 'package:freelance_app/bloc/states/send_mail_states.dart';
import 'package:freelance_app/bloc/states/user_state.dart';
import 'package:image_picker/image_picker.dart';

class JobDetailsPage extends StatefulWidget {
  final int jobId;

  const JobDetailsPage({
    super.key,
    required this.jobId,
  });

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  final _postCommentFormKey = GlobalKey<FormState>();
  String? _comTxt;

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
    final AuthenticateUserSate userState =
        context.read<AuthUserBloc>().state as AuthenticateUserSate;
    final String userId = userState.myAuthUser.userId;
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
      body: BlocConsumer<JobDetailBloc, MyJobDetailStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is JobDetailInitialState) {
            context
                .read<JobDetailBloc>()
                .add(LoadJobDetailEvent(jobId: widget.jobId));
          }

          if (state is JobDetailErrorState) {
            return Center(
              child: Text(
                state.error,
              ),
            );
          }

          if (state is JobDetailLoadedState) {
            final Map<String, dynamic> job = state.job.job;
            return SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  job['title'],
                                  style: const TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      job['user_image'],
                                      width: 100,
                                      height: 100,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Container(
                                        height: 80,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          job['name'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          job['address'],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Total Applicants: ',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      job['total_applicant'].toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(Icons.manage_accounts),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  job['description'],
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Builder(builder: (context) {
                                  if (userId == job['user_id']) {
                                    return BlocConsumer<ChangeJobIsActiveBloc,
                                        MyChangeJobIsActiveState>(
                                      listener: (context, state) {
                                        if (state
                                            is ChangeJobIsActiveErrorState) {
                                          _showErrorSnackBar(
                                              context, state.error, Colors.red);
                                        }
                                        if (state
                                            is ChangeJobIsActiveLoadedState) {
                                          _showErrorSnackBar(
                                              context,
                                              "Changed Successfully!",
                                              Colors.green);
                                          context.read<JobDetailBloc>().add(
                                              LoadJobDetailEvent(
                                                  jobId: widget.jobId));
                                        }
                                      },
                                      builder: (context, state) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 130,
                                            child: ListTile(
                                              title: const Text(
                                                'ON',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                              leading: Radio(
                                                value: true,
                                                groupValue: job['active'],
                                                onChanged: (value) {
                                                  context
                                                      .read<
                                                          ChangeJobIsActiveBloc>()
                                                      .add(
                                                          ChangeMyJobIsActiveEvent(
                                                              jobId:
                                                                  widget.jobId,
                                                              status: true));
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 140,
                                            child: ListTile(
                                              title: const Text(
                                                'OFF',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                              leading: Radio(
                                                value: false,
                                                groupValue: job['active'],
                                                onChanged: (value) {
                                                  context
                                                      .read<
                                                          ChangeJobIsActiveBloc>()
                                                      .add(
                                                          ChangeMyJobIsActiveEvent(
                                                              jobId:
                                                                  widget.jobId,
                                                              status: false));
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  return BlocBuilder<SendMailValidityBloc,
                                          MySendMailStates>(
                                      builder: (context, state3) {
                                    if (state3
                                        is SendMailValidityInitialState) {
                                      context.read<SendMailValidityBloc>().add(
                                            SendMailValidityCheckEvent(
                                                userId: userId,
                                                jobId: widget.jobId),
                                          );
                                    }
                                    if (state3
                                        is SendMailValidityLoadingState) {
                                      return const CircularProgressIndicator();
                                    }
                                    if (state3 is SendMailValidityLoadedState) {
                                      if (!state3.isValid) {
                                        return const Center(
                                          child: Text(
                                            'Already Applied!',
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                    return BlocBuilder<SendMailBloc,
                                        MySendMailStates>(
                                      builder: (context, state2) {
                                        if (state2 is SendMailLoadedState) {
                                          return const Center(
                                            child: Text(
                                              'Applied Successfully!',
                                              style: TextStyle(
                                                color: Colors.green,
                                              ),
                                            ),
                                          );
                                        }
                                        return Center(
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                Colors.green[400],
                                              ),
                                            ),
                                            onPressed: () {
                                              final String userEmail =
                                                  job['user_email'];

                                              final int jobId = job['id'];
                                              context.read<SendMailBloc>().add(
                                                    SendMailEvent(
                                                      userEmail: userEmail,
                                                      userId: userId,
                                                      jobId: jobId,
                                                    ),
                                                  );
                                            },
                                            child: const Text('Apply Now'),
                                          ),
                                        );
                                      },
                                    );
                                  });
                                }),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Uploaded Date: ${job['upload_date']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Uploaded Date: ${job['deadline_date']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Center(
                          child: Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      )),
                      Card(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Form(
                                      key: _postCommentFormKey,
                                      child: Expanded(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            hintText: 'Enter your comment',
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                          onSaved: (value) {
                                            _comTxt = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    BlocConsumer<PostJobCommentBloc,
                                        MyJobCommentsStates>(
                                      listener: (context, state) {
                                        if (state
                                            is PostJobCommentLoadedState) {
                                          _showErrorSnackBar(
                                              context,
                                              'Comment posted successfully!',
                                              Colors.green);
                                        }

                                        if (state is PostJobCommentErrorState) {
                                          _showErrorSnackBar(
                                              context, state.error, Colors.red);
                                        }
                                      },
                                      builder: (context, state) {
                                        return ElevatedButton(
                                          onPressed: () {
                                            if (_postCommentFormKey
                                                .currentState!
                                                .validate()) {
                                              _postCommentFormKey.currentState!
                                                  .save();
                                              final AuthenticateUserSate
                                                  userState = context
                                                          .read<AuthUserBloc>()
                                                          .state
                                                      as AuthenticateUserSate;
                                              final String userId =
                                                  userState.myAuthUser.userId;

                                              context
                                                  .read<PostJobCommentBloc>()
                                                  .add(
                                                    PostCommentEvent(
                                                        userId: userId,
                                                        jobId: widget.jobId,
                                                        comTxt: _comTxt!),
                                                  );
                                            }
                                          },
                                          child: state
                                                  is PostJobCommentLoadingState
                                              ? const CircularProgressIndicator()
                                              : const Text('POST'),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                              BlocConsumer<JobCommentBloc, MyJobCommentsStates>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    if (state is JobCommentsErrorState) {
                                      return Text(state.error);
                                    }
                                    if (state is JobCommentsInitialState) {
                                      context.read<JobCommentBloc>().add(
                                          LoadCommentsEvent(
                                              jobId: widget.jobId));
                                    }
                                    if (state is JobCommentsLoadedState) {
                                      final comments = state.comments.comments;
                                      return SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          children: List.generate(
                                            comments.length,
                                            (count) {
                                              return SizedBox(
                                                width: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.network(
                                                      comments[count]
                                                          ['user_image'],
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            comments[count]
                                                                ['user_name'],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            comments[count]
                                                                ['com_time'],
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            comments[count]
                                                                ['com_text'],
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                    return const CircularProgressIndicator();
                                  })
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
