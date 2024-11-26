import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/blocs/delete_job_bloc.dart';
import 'package:freelance_app/bloc/blocs/job_list_page_bloc.dart';
import 'package:freelance_app/bloc/blocs/search_item_bloc.dart';
import 'package:freelance_app/bloc/events/search_item_events.dart';
import 'package:freelance_app/bloc/states/search_item_states.dart';
import 'package:freelance_app/data/repository/home_page_repository.dart';
import 'package:freelance_app/other_profile_page.dart';
import 'package:freelance_app/profile_page.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchFormKey = GlobalKey<FormState>();
  String? _searchWord;

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
      body: BlocConsumer<SearchItemBloc, MySearchItemStates>(
        listener: (context, state) {
          if (state is SearchItemErrorState) {
            _showErrorSnackBar(context, state.error, Colors.red);
          }
        },
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _searchFormKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter the company name',
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'Value can\'t be empty';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _searchWord = value;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_searchFormKey.currentState!.validate()) {
                      _searchFormKey.currentState!.save();
                      context.read<SearchItemBloc>().add(
                            SearchItemEvent(name: _searchWord!),
                          );
                    }
                  },
                  child: const Text('Search'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Searched Items:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              state is SearchItemInitialState
                  ? const Center(child: Text('Search for companies'))
                  : Expanded(
                      child: Column(
                        children: [
                          state is SearchItemLoadingState
                              ? const Center(child: CircularProgressIndicator())
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: (state as SearchItemLoadedState)
                                        .model
                                        .items
                                        .length,
                                    itemBuilder: (context, count) {
                                      final Map<String, dynamic> company =
                                          state.model.items[count];
                                      return Card(
                                        child: ListTile(
                                          leading: Image.network(
                                            company['image_url'],
                                          ),
                                          title: Text(
                                            company['name'],
                                          ),
                                          subtitle: Text(
                                            company['address'],
                                          ),
                                          trailing: TextButton(
                                            onPressed: () {
                                              Get.to(MultiBlocProvider(
                                                providers: [
                                                  BlocProvider(
                                                    create: (context) =>
                                                        JobListPageBloc(
                                                      context.read<
                                                          HomePageRepository>(),
                                                    ),
                                                  ),
                                                ],
                                                child: OtherProfilePage(
                                                  userData: company,
                                                ),
                                              ));
                                            },
                                            child: const Text(
                                              'View Profile',
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
