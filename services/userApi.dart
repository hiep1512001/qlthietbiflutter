import 'dart:convert';
import 'package:bvnd115app/model/tblUsers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class UserAPI {
  static Future<List<tblUsers>> getUsers() async {
    final response = await supabase.from('tblUsers').select();
    final List data = jsonDecode(response as String);
    return data.map((e) => tblUsers.fromJson(e)).toList();
  }

  static Future<tblUsers?> getUserByUserName(
      String username, String password) async {
    try {
      final response = await supabase
          .from('tblUsers')
          .select('*,btdkp(makp,tenkp)')
          .eq('username', username)
          .eq('password', password)
          .maybeSingle();
      ;
      if (response != null) {
        print(response);
        return tblUsers.fromJson(response as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
