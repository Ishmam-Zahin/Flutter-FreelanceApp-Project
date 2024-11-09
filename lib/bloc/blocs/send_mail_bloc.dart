import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/events/send_mail_events.dart';
import 'package:freelance_app/bloc/states/send_mail_states.dart';
import 'package:freelance_app/data/repository/home_page_repository.dart';

class SendMailBloc extends Bloc<MySendMailEvents, MySendMailStates> {
  final HomePageRepository homePageRepository;
  SendMailBloc({
    required this.homePageRepository,
  }) : super(SendMailInitialSate()) {
    on<SendMailEvent>((event, emitter) async {
      try {
        emit(SendMailLoadingState());
        await homePageRepository.applyJob(
            userEmail: event.userEmail,
            userId: event.userId,
            jobId: event.jobId);
        emit(SendMailLoadedState());
      } catch (e) {
        emit(SendMailErrorState(error: e.toString()));
      }
    });
  }
}
