import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance_app/bloc/events/job_comments_events.dart';
import 'package:freelance_app/bloc/states/job_comments_states.dart';
import 'package:freelance_app/data/repository/home_page_repository.dart';

class PostJobCommentBloc
    extends Bloc<MyJobCommentsEvents, MyJobCommentsStates> {
  final HomePageRepository homePageRepository;
  PostJobCommentBloc({required this.homePageRepository})
      : super(PostJobCommentInitialState()) {
    on<PostCommentEvent>((event, emitter) async {
      try {
        emit(PostJobCommentLoadingState());
        await homePageRepository.postComment(
            userId: event.userId, jobId: event.jobId, comTxt: event.comTxt);
        emit(PostJobCommentLoadedState());
      } catch (e) {
        emit(
          PostJobCommentErrorState(
            error: e.toString(),
          ),
        );
      }
    });
  }
}
