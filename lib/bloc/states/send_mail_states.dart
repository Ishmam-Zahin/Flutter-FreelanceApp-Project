class MySendMailStates {}

class SendMailInitialSate extends MySendMailStates {}

class SendMailLoadingState extends MySendMailStates {}

class SendMailLoadedState extends MySendMailStates {}

class SendMailErrorState extends MySendMailStates {
  final String error;
  SendMailErrorState({required this.error});
}
