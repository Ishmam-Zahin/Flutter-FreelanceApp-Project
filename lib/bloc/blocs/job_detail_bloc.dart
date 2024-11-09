import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/events/job_detail_events.dart';
import 'package:freelance_app/bloc/states/job_detail_states.dart';
import 'package:freelance_app/data/repository/home_page_repository.dart';

class JobDetailBloc extends Bloc<MyJobDetailEvents, MyJobDetailStates> {
  final HomePageRepository homePageRepository;
  JobDetailBloc({required this.homePageRepository})
      : super(JobDetailInitialState()) {
    on<LoadJobDetailEvent>((event, emitter) async {
      try {
        emit(JobDetailLoadingState());
        emit(
          JobDetailLoadedState(
            job: await homePageRepository.getJobDetail(
              jobId: event.jobId,
            ),
          ),
        );
      } catch (e) {
        emit(JobDetailErrorState(error: e.toString()));
      }
    });
  }
}
