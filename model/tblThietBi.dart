import 'package:bvnd115app/model/tblLoai.dart';
import 'package:bvnd115app/model/tblTinhTrang.dart';

class TblThietBi {
  int? id;
  String tenThietBi;
  String maCodeThietBi;
  String model;
  String hangSanXuat;
  String nuocSanXuat;
  int makp;
  int tinhTrang;
  int loaiThietBi;
  String ngaySuDung;
  int byUserID;
  TblTinhTrang? tblTinhTrang;
  TblLoai? tblLoai;
  TblThietBi({
    required this.id,
    required this.byUserID,
    required this.hangSanXuat,
    required this.loaiThietBi,
    required this.maCodeThietBi,
    required this.makp,
    required this.model,
    required this.ngaySuDung,
    required this.nuocSanXuat,
    required this.tenThietBi,
    required this.tinhTrang,
    this.tblTinhTrang,
    this.tblLoai,
  });
  // Factory constructor - tạo một Employee từ dữ liệu dạng JSON (Map)
  // Giúp chuyển dữ liệu lấy từ API (dạng Map) thành đối tượng Employee
  factory TblThietBi.fromJson(Map<String, dynamic> json) {
    return TblThietBi(
      id: json['id'],
      byUserID: json['byUserID'],
      hangSanXuat: json['hangSanXuat'],
      loaiThietBi: json['loaiThietBi'],
      makp: json['makp'],
      maCodeThietBi: json['maCodeThietBi'],
      model: json['model'],
      ngaySuDung: json['ngaySuDung'],
      nuocSanXuat: json['nuocSanXuat'],
      tenThietBi: json['tenThietBi'],
      tinhTrang: json['tinhTrang'],
      tblTinhTrang: json['tblTinhTrang'] != null
          ? TblTinhTrang.fromJson(json['tblTinhTrang'])
          : null,
      tblLoai: json['tblLoaiThietBi'] != null
          ? TblLoai.fromJson(json['tblLoaiThietBi'])
          : null,
    );
  }
// Hàm chuyển ngược lại: từ Employee → Map (dạng JSON)
// Giúp chuẩn bị dữ liệu khi gửi lên server (POST, PUT, ...)
  Map<String, dynamic> toJson() {
    return {
      'byUserID': byUserID,
      'hangSanXuat': hangSanXuat,
      'loaiThietBi': loaiThietBi,
      'makp': makp,
      'maCodeThietBi': maCodeThietBi,
      'model': model,
      'ngaySuDung': ngaySuDung,
      'nuocSanXuat': nuocSanXuat,
      'tenThietBi': tenThietBi,
      'tinhTrang': tinhTrang
    };
  }
}
