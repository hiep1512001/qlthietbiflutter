class TblTinhTrang {
  int id;
  String tinhTrang;
  String color;
  TblTinhTrang({
    required this.id,
    required this.tinhTrang,
    required this.color,
  });
  // Factory constructor - tạo một Employee từ dữ liệu dạng JSON (Map)
  // Giúp chuyển dữ liệu lấy từ API (dạng Map) thành đối tượng Employee
  factory TblTinhTrang.fromJson(Map<String, dynamic> json) {
    return TblTinhTrang(
        id: json['id'], tinhTrang: json['tinhTrang'], color: json['color']);
  }
// Hàm chuyển ngược lại: từ Employee → Map (dạng JSON)
// Giúp chuẩn bị dữ liệu khi gửi lên server (POST, PUT, ...)
  Map<String, dynamic> toJson() {
    return {'id': id, 'tinhTrang': tinhTrang, 'color': color};
  }
}
