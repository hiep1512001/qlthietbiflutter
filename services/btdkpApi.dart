import 'package:bvnd115app/model/btdkp.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class BTDAPI {
  static Future<List<BTDKP>> getBTDKPs() async {
    final response = await supabase.from('btdkp').select();
    final data = response as List<dynamic>;
    return data.map((e) => BTDKP.fromJson(e as Map<String, dynamic>)).toList();
  }

  static Future<BTDKP?> getBTDKPByMakp(int makp) async {
    try {
      final response =
          await supabase.from('btdkp').select('*').eq('makp', makp).single();

      if (response != null) {
        return BTDKP.fromJson(response as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
