import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MySendMailProvider {
  Future<void> sendMail({
    required String userEmail,
    required String userId,
    required int jobId,
  }) async {
    try {
      final Email email = Email(
        recipients: [
          userEmail,
        ],
      );
      await FlutterEmailSender.send(email);
      await Supabase.instance.client.from('job_applicant').insert({
        'user_id': userId,
        'job_id': jobId,
      });
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
