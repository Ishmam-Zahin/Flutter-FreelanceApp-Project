import 'package:freelance_app/data/model/job_list_model.dart';
import 'package:freelance_app/data/providers/job_list_provider.dart';

abstract class IHomePageRepository {
  Future<MyJobListModel> getJobList();
}

class HomePageRepository implements IHomePageRepository {
  final MyJobListProvider myJobListProvider;

  HomePageRepository({
    required this.myJobListProvider,
  });

  @override
  Future<MyJobListModel> getJobList() async {
    try {
      return myJobListProvider.getJobList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
