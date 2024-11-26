import 'package:flutter/material.dart';
import 'package:freelance_app/bloc/blocs/change_job_isactive_bloc.dart';
import 'package:freelance_app/bloc/blocs/delete_job_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_comment_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_detail_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_list_page_bloc.dart';
import 'package:freelance_app/bloc/blocs/post_job_comment_bloc.dart';
import 'package:freelance_app/bloc/blocs/send_mail_bloc.dart';
import 'package:freelance_app/bloc/blocs/send_mail_validity_bloc.dart';
import 'package:freelance_app/bloc/blocs/user_bloc.dart';
import 'package:freelance_app/bloc/events/delete_job_events.dart';
import 'package:freelance_app/bloc/events/job_list_page_events.dart';
import 'package:freelance_app/bloc/events/user_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/states/delete_job_states.dart';
import 'package:freelance_app/bloc/states/job_list_page_states.dart';
import 'package:freelance_app/bloc/states/user_state.dart';
import 'package:freelance_app/data/repository/home_page_repository.dart';
import 'package:freelance_app/job_details_page.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, Map<String, dynamic>? userData});

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
    context
        .read<JobListPageBloc>()
        .add(LoadJobListEvent(typeId: -1, userId: userId));
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
        child: BlocBuilder<AuthUserBloc, UserState>(builder: (context, state) {
          final user = state as AuthenticateUserSate;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(user.myAuthUser.imageUrl),
                            radius: 60,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            user.myAuthUser.userName,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 3,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Account Informations :',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.email_outlined,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        user.myAuthUser.mail,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        user.myAuthUser.phone,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 3,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.black,
                                ),
                                padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                context.read<AuthUserBloc>().add(LogoutEvent());
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'LOGOUT',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.login_rounded,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'My Jobs:',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<JobListPageBloc, MyJobListPageStates>(
                  builder: (context, state) {
                    if (state is JobListLoadingState) {
                      return const CircularProgressIndicator();
                    }
                    if (State is JobListErrorState) {
                      return const Text('Unexpected Error!');
                    }
                    state = state as JobListLoadedState;
                    return Column(
                      children: List.generate(
                        state.myJobListModel.jobs.length,
                        (count) {
                          state = state as JobListLoadedState;
                          return SizedBox(
                            width: double.infinity,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) => JobDetailBloc(
                                          homePageRepository: context
                                              .read<HomePageRepository>(),
                                        ),
                                      ),
                                      BlocProvider(
                                        create: (context) => SendMailBloc(
                                          homePageRepository: context
                                              .read<HomePageRepository>(),
                                        ),
                                      ),
                                      BlocProvider(
                                        create: (context) => JobCommentBloc(
                                          homePageRepository: context
                                              .read<HomePageRepository>(),
                                        ),
                                      ),
                                      BlocProvider(
                                        create: (context) => PostJobCommentBloc(
                                          homePageRepository: context
                                              .read<HomePageRepository>(),
                                        ),
                                      ),
                                      BlocProvider(
                                        create: (context) =>
                                            SendMailValidityBloc(
                                          homePageRepository: context
                                              .read<HomePageRepository>(),
                                        ),
                                      ),
                                      BlocProvider(
                                        create: (context) =>
                                            ChangeJobIsActiveBloc(
                                          homePageRepository: context
                                              .read<HomePageRepository>(),
                                        ),
                                      )
                                    ],
                                    child: JobDetailsPage(
                                      jobId: (state as JobListLoadedState)
                                          .myJobListModel
                                          .jobs[count]['id'],
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (state as JobListLoadedState)
                                                  .myJobListModel
                                                  .jobs[count]['title'],
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 21,
                                              ),
                                            ),
                                            Text(
                                              (state as JobListLoadedState)
                                                  .myJobListModel
                                                  .jobs[count]['type_name'],
                                            ),
                                            Text(
                                              'Deadline Date: ${(state as JobListLoadedState).myJobListModel.jobs[count]['deadline_date']}',
                                            ),
                                          ],
                                        ),
                                      ),
                                      BlocConsumer<DeleteJobBloc,
                                          MyDeleteJobStates>(
                                        listener: (context, state2) {
                                          if (state2 is DeleteJobErrorSate) {
                                            _showErrorSnackBar(
                                                context,
                                                'Failed to delete!',
                                                Colors.red);
                                          }
                                          if (state2 is DeleteJobLoadedState) {
                                            _showErrorSnackBar(
                                                context,
                                                'Job Deleted Successfully!',
                                                Colors.green);
                                            context.read<JobListPageBloc>().add(
                                                LoadJobListEvent(
                                                    typeId: -1,
                                                    userId: userId));
                                          }
                                        },
                                        builder: (context, state2) {
                                          int jobId =
                                              (state as JobListLoadedState)
                                                  .myJobListModel
                                                  .jobs[count]['id'];
                                          return ElevatedButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                  Colors.red,
                                                ),
                                                iconColor:
                                                    WidgetStatePropertyAll(
                                                        Colors.white)),
                                            onPressed: () {
                                              final bloc =
                                                  context.read<DeleteJobBloc>();
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Delete Confirmation'),
                                                    content: const Text(
                                                        'Are you sure?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          bloc.add(
                                                              DeleteJobEvent(
                                                                  jobId:
                                                                      jobId));
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                          'YES',
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                          'NO',
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: const Icon(
                                                Icons.delete_forever),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
