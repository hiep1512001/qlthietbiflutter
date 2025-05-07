class TblLoai {
  int id;
  String tenLoai;
  TblLoai({
    required this.id,
    required this.tenLoai,
  });
  // Factory constructor - tạo một Employee từ dữ liệu dạng JSON (Map)
  // Giúp chuyển dữ liệu lấy từ API (dạng Map) thành đối tượng Employee
  factory TblLoai.fromJson(Map<String, dynamic> json) {
    return TblLoai(
      id: json['id'],
      tenLoai: json['tenLoai'],
    );
  }
// Hàm chuyển ngược lại: từ Employee → Map (dạng JSON)
// Giúp chuẩn bị dữ liệu khi gửi lên server (POST, PUT, ...)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tenLoai': tenLoai,
    };
  }
}
