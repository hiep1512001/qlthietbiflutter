class BTDKP {
  int makp;
  String tenkp;
  BTDKP({
    required this.makp,
    required this.tenkp,
  });
  // Factory constructor - tạo một Employee từ dữ liệu dạng JSON (Map)
  // Giúp chuyển dữ liệu lấy từ API (dạng Map) thành đối tượng Employee
  factory BTDKP.fromJson(Map<String, dynamic> json) {
    return BTDKP(
      makp: json['makp'],
      tenkp: json['tenkp'],
    );
  }
// Hàm chuyển ngược lại: từ Employee → Map (dạng JSON)
// Giúp chuẩn bị dữ liệu khi gửi lên server (POST, PUT, ...)
  Map<String, dynamic> toJson() {
    return {
      'makp': makp,
      'tenkp': tenkp,
    };
  }
}
