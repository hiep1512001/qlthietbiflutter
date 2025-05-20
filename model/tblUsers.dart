import 'package:bvnd115app/model/btdkp.dart';

class tblUsers {
  int id;
  String username;
  String password;
  int vaitro;
  int makp;
  BTDKP? btdkp;
  tblUsers(
      {required this.id,
      required this.username,
      required this.password,
      required this.vaitro,
      required this.makp,
      this.btdkp});
  // Factory constructor - tạo một Employee từ dữ liệu dạng JSON (Map)
  // Giúp chuyển dữ liệu lấy từ API (dạng Map) thành đối tượng Employee
  factory tblUsers.fromJson(Map<String, dynamic> json) {
    return tblUsers(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      vaitro: json['vaitro'],
      makp: json['makp'],
      btdkp: json['btdkp'] != null ? BTDKP.fromJson(json['btdkp']) : null,
    );
  }
// Hàm chuyển ngược lại: từ Employee → Map (dạng JSON)
// Giúp chuẩn bị dữ liệu khi gửi lên server (POST, PUT, ...)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'vaitro': vaitro,
      'makp': makp,
    };
  }
}
