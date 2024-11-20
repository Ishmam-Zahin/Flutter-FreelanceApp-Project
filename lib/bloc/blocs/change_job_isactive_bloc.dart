import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/events/change_job_isactive_events.dart';
import 'package:freelance_app/bloc/states/change_job_isActive_states.dart';
import 'package:freelance_app/data/repository/home_page_repository.dart';

class ChangeJobIsActiveBloc
    extends Bloc<MyChangeJobIsActiveEvent, MyChangeJobIsActiveState> {
  final HomePageRepository homePageRepository;
  ChangeJobIsActiveBloc({required this.homePageRepository})
      : super(ChangeJobIsActiveInitialState()) {
    on<ChangeMyJobIsActiveEvent>((event, emitter) async {
      emit(ChangeJobIsActiveLoadingState());
      try {
        await homePageRepository.changeJobState(
            jobId: event.jobId, status: event.status);

        emit(ChangeJobIsActiveLoadedState());
      } catch (e) {
        emit(ChangeJobIsActiveErrorState(error: e.toString()));
      }
    });
  }
}
