import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/events/send_mail_events.dart';
import 'package:freelance_app/bloc/states/send_mail_states.dart';
import 'package:freelance_app/data/repository/home_page_repository.dart';

class SendMailValidityBloc extends Bloc<MySendMailEvents, MySendMailStates> {
  final HomePageRepository homePageRepository;
  SendMailValidityBloc({required this.homePageRepository})
      : super(SendMailValidityInitialState()) {
    on<SendMailValidityCheckEvent>((event, emitter) async {
      try {
        emit(SendMailValidityLoadingState());
        emit(
          SendMailValidityLoadedState(
            isValid: await homePageRepository.applyJobValidity(
                userId: event.userId, jobId: event.jobId),
          ),
        );
      } catch (e) {
        emit(
          SendMailValidityErrorState(
            error: e.toString(),
          ),
        );
      }
    });
  }
}
