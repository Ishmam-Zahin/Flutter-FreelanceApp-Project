import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/events/home_page_events.dart';
import 'package:freelance_app/bloc/states/home_page_states.dart';

class HomePageBloc extends Bloc<MyHomePageEvents, MyHomePageStates> {
  HomePageBloc() : super(ShowProfilePageState()) {
    on<LoadProfilePageEvent>((event, emitter) {
      emit(ShowProfilePageState());
    });

    on<LoadJobListPageEvent>((event, emitter) {
      emit(ShowJobListPageState());
    });

    on<LoadSearchPageEvent>((event, emitter) {
      emit(ShowSearchPageState());
    });

    on<LoadAddJobPageEvent>((event, emitter) {
      emit(ShowAddJobPageState());
    });
  }
}
