import 'package:freelance_app/data/model/job_detail_model.dart';
import 'package:freelance_app/data/model/job_list_model.dart';
import 'package:freelance_app/data/model/jobs_types_model.dart';
import 'package:freelance_app/data/providers/add_job_provider.dart';
import 'package:freelance_app/data/providers/job_detail_provider.dart';
import 'package:freelance_app/data/providers/job_list_provider.dart';
import 'package:freelance_app/data/providers/job_types_provider.dart';
import 'package:freelance_app/data/providers/send_mail_provider.dart';

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
  Future<MyJobDetailModel> getJobDetail({
    required int jobId,
  });

  Future<void> applyJob({
    required String userEmail,
    required String userId,
    required int jobId,
  });
}

class HomePageRepository implements IHomePageRepository {
  final MyJobListProvider myJobListProvider;
  final MyJobTypesProvider myJobTypesProvider;
  final MyAddJobprovider myAddJobprovider;
  final MyJobDetailProvider myJobDetailProvider;
  final MySendMailProvider mySendMailProvider;

  HomePageRepository({
    required this.myJobListProvider,
    required this.myJobTypesProvider,
    required this.myAddJobprovider,
    required this.myJobDetailProvider,
    required this.mySendMailProvider,
  });

  @override
  Future<MyJobListModel> getJobList(int typeId) async {
    try {
      return await myJobListProvider.getJobList(typeId);
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
      return await myAddJobprovider.uploadJob(
          title: title,
          dsc: dsc,
          deadlineDate: deadlineDate,
          userId: userId,
          typeId: typeId);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<MyJobDetailModel> getJobDetail({
    required int jobId,
  }) async {
    try {
      return await myJobDetailProvider.getJobDetail(jobId: jobId);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<void> applyJob({
    required String userEmail,
    required String userId,
    required int jobId,
  }) async {
    try {
      await mySendMailProvider.sendMail(
          userEmail: userEmail, userId: userId, jobId: jobId);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
