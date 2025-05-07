import 'package:bvnd115app/model/tblLoai.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class LoaiAPI {
  static Future<List<TblLoai>> getLoais() async {
    print("gọi api loai");
    final response = await supabase.from('tblLoaiThietBi').select();
    final data = response as List<dynamic>;
    return data
        .map((e) => TblLoai.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // static Future<tblUsers?> getUserByUserName(
  //     String username, String password) async {
  //   try {
  //     final response = await supabase
  //         .from('tblUsers')
  //         .select()
  //         .eq('username', username)
  //         .eq('password', password)
  //         .maybeSingle();
  //     ;
  //     if (response != null) {
  //       return tblUsers.fromJson(response as Map<String, dynamic>);
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
