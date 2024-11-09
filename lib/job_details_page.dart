import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_detail_bloc.dart';
import 'package:freelance_app/bloc/blocs/send_mail_bloc.dart';
import 'package:freelance_app/bloc/events/job_detail_events.dart';
import 'package:freelance_app/bloc/events/send_mail_events.dart';
import 'package:freelance_app/bloc/states/job_detail_states.dart';
import 'package:freelance_app/bloc/states/send_mail_states.dart';

class JobDetailsPage extends StatelessWidget {
  final int jobId;
  const JobDetailsPage({
    super.key,
    required this.jobId,
  });

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
      body: BlocConsumer<JobDetailBloc, MyJobDetailStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is JobDetailInitialState) {
            context.read<JobDetailBloc>().add(LoadJobDetailEvent(jobId: jobId));
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
                                BlocBuilder<SendMailBloc, MySendMailStates>(
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
                                          final String userId = job['user_id'];
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
