import 'package:bvnd115app/model/tblTinhTrang.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class TinhTrangAPI {
  static Future<List<TblTinhTrang>> gettinhTrangs() async {
    print("gọi api TinhTrang");
    final response = await supabase.from('tblTinhTrang').select();
    final data = response as List<dynamic>;
    return data
        .map((e) => TblTinhTrang.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
