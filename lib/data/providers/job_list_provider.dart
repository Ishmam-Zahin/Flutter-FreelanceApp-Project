import 'package:freelance_app/data/model/job_list_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyJobListProvider {
  Future<MyJobListModel> getJobList(int typeId) async {
    try {
      final List<Map<String, dynamic>> response;
      if (typeId == -1) {
        response =
            await Supabase.instance.client.from('get_job_list').select('*');
      } else {
        response = await Supabase.instance.client
            .from('get_job_list')
            .select('*')
            .eq('type_id', typeId);
      }

      return MyJobListModel(jobs: response);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
