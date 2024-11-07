import 'package:freelance_app/data/model/job_list_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyJobListProvider {
  Future<MyJobListModel> getJobList() async {
    try {
      final response =
          await Supabase.instance.client.from('get_job_list').select('*');

      return MyJobListModel(jobs: response);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
