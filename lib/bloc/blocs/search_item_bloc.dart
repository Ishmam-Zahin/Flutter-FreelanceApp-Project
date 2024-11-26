import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/events/search_item_events.dart';
import 'package:freelance_app/bloc/states/search_item_states.dart';
import 'package:freelance_app/data/repository/home_page_repository.dart';

class SearchItemBloc extends Bloc<MySearchItemEvents, MySearchItemStates> {
  final HomePageRepository homePageRepository;
  SearchItemBloc({required this.homePageRepository})
      : super(SearchItemInitialState()) {
    on<SearchItemEvent>((event, emitter) async {
      emit(SearchItemLoadingState());
      try {
        emit(
          SearchItemLoadedState(
            model: await homePageRepository.searchItem(name: event.name),
          ),
        );
      } catch (e) {
        emit(
          SearchItemErrorState(
            error: e.toString(),
          ),
        );
      }
    });
  }
}
