import 'package:bvnd115app/model/tblThietBi.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ThietBiAPI {
  static Future<List<TblThietBi>> getDSThietBiByMakp(int makp) async {
    final response = await supabase
        .from('tblThietBi')
        .select(
            '*, tblLoaiThietBi(id,tenLoai),tblTinhTrang(id,tinhTrang,color)')
        .eq('makp', makp);
    final data = response as List<dynamic>;
    return data
        .map((e) => TblThietBi.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> addThietBi(TblThietBi) async {
    try {
      final response =
          await supabase.from('tblThietBi').insert(TblThietBi.toJson());
      print('✅ Thêm thiết bị thành công: $response');
    } catch (e) {
      print('❌ Lỗi khi thêm thiết bị: $e');
    }
  }
}
