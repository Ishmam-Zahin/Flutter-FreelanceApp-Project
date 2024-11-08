import 'package:freelance_app/data/model/job_list_model.dart';
import 'package:freelance_app/data/model/jobs_types_model.dart';
import 'package:freelance_app/data/providers/add_job_provider.dart';
import 'package:freelance_app/data/providers/job_list_provider.dart';
import 'package:freelance_app/data/providers/job_types_provider.dart';

abstract class IHomePageRepository {
  Future<MyJobListModel> getJobList(int typeId);
  Future<MyjobTypesModel> getJobTypes();
  Future<void> uploadJob({
    required String title,
    required String dsc,
    required String deadlineDate,
    required String userId,
    required int typeId,
  });
}

class HomePageRepository implements IHomePageRepository {
  final MyJobListProvider myJobListProvider;
  final MyJobTypesProvider myJobTypesProvider;
  final MyAddJobprovider myAddJobprovider;

  HomePageRepository({
    required this.myJobListProvider,
    required this.myJobTypesProvider,
    required this.myAddJobprovider,
  });

  @override
  Future<MyJobListModel> getJobList(int typeId) async {
    try {
      return myJobListProvider.getJobList(typeId);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<MyjobTypesModel> getJobTypes() async {
    try {
      return myJobTypesProvider.getJobTypes();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<void> uploadJob({
    required String title,
    required String dsc,
    required String deadlineDate,
    required String userId,
    required int typeId,
  }) async {
    try {
      return myAddJobprovider.uploadJob(
          title: title,
          dsc: dsc,
          deadlineDate: deadlineDate,
          userId: userId,
          typeId: typeId);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
