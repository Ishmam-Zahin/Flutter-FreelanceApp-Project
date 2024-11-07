import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_list_page_bloc.dart';
import 'package:freelance_app/bloc/events/job_list_page_events.dart';
import 'package:freelance_app/bloc/states/job_list_page_states.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<JobListPageBloc>().add(LoadJobListEvent());
    return Scaffold(body: BlocBuilder<JobListPageBloc, MyJobListPageStates>(
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
