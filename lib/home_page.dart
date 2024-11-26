import 'package:flutter/material.dart';
import 'package:freelance_app/add_job_page.dart';
import 'package:freelance_app/bloc/blocs/add_job_bloc.dart';
import 'package:freelance_app/bloc/blocs/delete_job_bloc.dart';
import 'package:freelance_app/bloc/blocs/home_page_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_list_page_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_types_bloc.dart';
import 'package:freelance_app/bloc/blocs/search_item_bloc.dart';
import 'package:freelance_app/bloc/blocs/user_bloc.dart';
import 'package:freelance_app/bloc/events/home_page_events.dart';
import 'package:freelance_app/bloc/events/user_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/states/home_page_states.dart';
import 'package:freelance_app/bloc/states/search_item_states.dart';
import 'package:freelance_app/data/repository/home_page_repository.dart';
import 'package:freelance_app/job_list_page.dart';
import 'package:freelance_app/profile_page.dart';
import 'package:freelance_app/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomePageBloc, MyHomePageStates>(
          builder: (context, state) {
        if (state is ShowProfilePageState) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => JobListPageBloc(
                  context.read<HomePageRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => DeleteJobBloc(
                  context.read<HomePageRepository>(),
                ),
              )
            ],
            child: const ProfilePage(),
          );
        }
        if (state is ShowSearchPageState) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SearchItemBloc(
                  homePageRepository: context.read<HomePageRepository>(),
                ),
              ),
            ],
            child: const SearchPage(),
          );
        }
        if (state is ShowAddJobPageState) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => JobTypesBloc(
                  homePageRepository: context.read<HomePageRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => AddJobBloc(
                  homePageRepository: context.read<HomePageRepository>(),
                ),
              ),
            ],
            child: const AddJobPage(),
          );
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => JobListPageBloc(
                context.read<HomePageRepository>(),
              ),
            ),
            BlocProvider(
              create: (context) => JobTypesBloc(
                homePageRepository: context.read<HomePageRepository>(),
              ),
            ),
          ],
          child: const JobListPage(),
        );
      }),
      bottomNavigationBar: ColoredBox(
        color: const Color.fromARGB(255, 100, 181, 246),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  context.read<HomePageBloc>().add(LoadJobListPageEvent());
                },
                icon: const Icon(
                  Icons.list_alt,
                  size: 34,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<HomePageBloc>().add(LoadSearchPageEvent());
                },
                icon: const Icon(
                  Icons.search,
                  size: 34,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<HomePageBloc>().add(LoadAddJobPageEvent());
                },
                icon: const Icon(
                  Icons.add,
                  size: 34,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<HomePageBloc>().add(LoadProfilePageEvent());
                },
                icon: const Icon(
                  Icons.account_box,
                  size: 34,
                ),
              ),
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
