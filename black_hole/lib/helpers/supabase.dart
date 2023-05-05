import 'package:supabase/supabase.dart';

class SupaBase {
  final client = SupabaseClient(
    'https://gfmpmrqhrmzdjgxrxawo.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdmbXBtcnFocm16ZGpneHJ4YXdvIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4MTk2MTI0MiwiZXhwIjoxOTk3NTM3MjQyfQ.6sJuohNo-gI1SrcIUuq_pNp6HZymQCsbV1KnsSNE80s',
  );

  Future<Map> getUpdate() async {
    final response =
        await client.from('Update').select().order('LastestVersion');
    final result = response as List;
    return result.isEmpty
        ? {}
        : {
            'LatestVersion': response[0]['LatestVersion'],
            'LatestUrl': response[0]['LatestUrl'],
            'arm64-v8a': response[0]['arm64-v8a'],
            'armeabi-v7a': response[0]['armeabi-v7a'],
            'universal': response[0]['universal'],
          };
  }

  Future<void> updateUserDeatails(
      String? userId, String key, dynamic value) async {
    // final response =
    //     await client.from('Users').update({key: value}).match({"id": userId});
  }

  Future<void> createUser(Map data) async {
    await client.from('Users').insert(data);
  }
}
