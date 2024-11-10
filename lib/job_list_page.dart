import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_comment_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_detail_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_list_page_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_types_bloc.dart';
import 'package:freelance_app/bloc/blocs/post_job_comment_bloc.dart';
import 'package:freelance_app/bloc/blocs/send_mail_bloc.dart';
import 'package:freelance_app/bloc/blocs/send_mail_validity_bloc.dart';
import 'package:freelance_app/bloc/events/job_list_page_events.dart';
import 'package:freelance_app/bloc/events/job_types_events.dart';
import 'package:freelance_app/bloc/states/job_list_page_states.dart';
import 'package:freelance_app/bloc/states/job_types_states.dart';
import 'package:freelance_app/data/repository/home_page_repository.dart';
import 'package:freelance_app/job_details_page.dart';
import 'package:get/get.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<JobListPageBloc>().add(LoadJobListEvent(typeId: -1));
    context.read<JobTypesBloc>().add(LoadJobTypesEvent());
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
          actions: [
            BlocBuilder<JobTypesBloc, MyJobTypesStates>(
              builder: (context, state) {
                if (state is JobTypesLoadedState) {
                  final List<Map<String, dynamic>> types =
                      state.myjobTypesModel.jobTypes;
                  types.add({
                    'id': -1,
                    'type_name': 'All',
                  });
                  return DropdownButton(
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
                      final int id = value as int;
                      context
                          .read<JobListPageBloc>()
                          .add(LoadJobListEvent(typeId: id));
                    },
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
        body: BlocBuilder<JobListPageBloc, MyJobListPageStates>(
          builder: (context, state) {
            if (state is JobListErrorState) {
              return Center(
                child: Text(
                  state.error,
                ),
              );
            }
            if (state is JobListLoadedState) {
              final List<Map<String, dynamic>> jobs = state.myJobListModel.jobs;
              return ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, count) {
                  return SizedBox(
                    height: 190,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          () => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => JobDetailBloc(
                                  homePageRepository:
                                      context.read<HomePageRepository>(),
                                ),
                              ),
                              BlocProvider(
                                create: (context) => SendMailBloc(
                                  homePageRepository:
                                      context.read<HomePageRepository>(),
                                ),
                              ),
                              BlocProvider(
                                create: (context) => JobCommentBloc(
                                  homePageRepository:
                                      context.read<HomePageRepository>(),
                                ),
                              ),
                              BlocProvider(
                                create: (context) => PostJobCommentBloc(
                                  homePageRepository:
                                      context.read<HomePageRepository>(),
                                ),
                              ),
                              BlocProvider(
                                create: (context) => SendMailValidityBloc(
                                  homePageRepository:
                                      context.read<HomePageRepository>(),
                                ),
                              ),
                            ],
                            child: JobDetailsPage(
                              jobId: jobs[count]['id'],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                jobs[count]['user_image_url'],
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 70,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      jobs[count]['title'],
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      jobs[count]['type_name'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    Text(
                                      jobs[count]['dsc'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            if (state is JobListErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          },
        ));
  }
}
