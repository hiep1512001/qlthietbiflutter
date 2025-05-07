import 'package:bvnd115app/model/btdkp.dart';
import 'package:bvnd115app/model/tblLoai.dart';
import 'package:bvnd115app/model/tblThietBi.dart';
import 'package:bvnd115app/model/tblTinhTrang.dart';
import 'package:bvnd115app/providers/loginprovider.dart';
import 'package:bvnd115app/services/btdkpApi.dart';
import 'package:bvnd115app/services/loaiApi.dart';
import 'package:bvnd115app/services/thietBiApi.dart';
import 'package:bvnd115app/services/tinhTrangApi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TTBState {
  List<TblLoai>? loais;
  List<TblTinhTrang>? tinhTrangs;
  bool isLoading;
  String error;
  BTDKP? btdKp;
  TblThietBi? tblThietBi;
  String maCodeThietBi;
  String tenThietBi;
  TblLoai? selectLoai;
  TblTinhTrang? selectTinhTrang;
  String model;
  String hangSanXuat;
  String nuocSanXuat;
  int userId;
  TTBState(
      {required this.isLoading,
      required this.error,
      required this.loais,
      required this.selectLoai,
      required this.selectTinhTrang,
      required this.tinhTrangs,
      required this.btdKp,
      required this.tblThietBi,
      required this.hangSanXuat,
      required this.maCodeThietBi,
      required this.model,
      required this.nuocSanXuat,
      required this.tenThietBi,
      required this.userId});
  //hàm copp khi thay đổi
  TTBState copyWith(
      {bool? isLoading,
      List<TblLoai>? loais,
      String? error,
      TblLoai? selectLoai,
      List<TblTinhTrang>? tinhTrangs,
      TblTinhTrang? selectTinhTrang,
      BTDKP? btdKp,
      TblThietBi? tblThietBi,
      String? maCodeThietBi,
      String? tenThietBi,
      String? model,
      String? hangSanXuat,
      String? nuocSanXuat,
      int? userId}) {
    return TTBState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        loais: loais ?? this.loais,
        selectLoai: selectLoai ?? this.selectLoai,
        tinhTrangs: tinhTrangs ?? this.tinhTrangs,
        selectTinhTrang: selectTinhTrang ?? this.selectTinhTrang,
        btdKp: btdKp ?? this.btdKp,
        tblThietBi: tblThietBi ?? this.tblThietBi,
        hangSanXuat: hangSanXuat ?? this.hangSanXuat,
        maCodeThietBi: maCodeThietBi ?? this.maCodeThietBi,
        model: model ?? this.model,
        nuocSanXuat: nuocSanXuat ?? this.maCodeThietBi,
        tenThietBi: tenThietBi ?? this.tenThietBi,
        userId: userId ?? this.userId);
  }

  //hàm khởi tạo ban đầu
  factory TTBState.initial() => TTBState(
      userId: -1,
      isLoading: false,
      error: "",
      loais: null,
      selectLoai: null,
      tinhTrangs: null,
      selectTinhTrang: null,
      btdKp: null,
      tblThietBi: null,
      hangSanXuat: '',
      maCodeThietBi: '',
      model: '',
      nuocSanXuat: '',
      tenThietBi: '');
}

// Notifier: chứa logic xử lý
class TTBNotifier extends StateNotifier<TTBState> {
  final Ref ref;
  TTBNotifier(this.ref) : super(TTBState.initial());

  void updateSelectLoai(TblLoai) {
    state = state.copyWith(selectLoai: TblLoai);
  }

  void updateSelectTinhTrang(TblTinhTrang) {
    state = state.copyWith(selectTinhTrang: TblTinhTrang);
  }

  void updateMaCodeThietBi(String) {
    state = state.copyWith(maCodeThietBi: String);
  }

  void updateTenThietBi(String) {
    state = state.copyWith(tenThietBi: String);
  }

  void updateModel(String) {
    state = state.copyWith(model: String);
  }

  void updateHangSanXuat(String) {
    state = state.copyWith(hangSanXuat: String);
  }

  void updateNuocSanXuat(String) {
    state = state.copyWith(nuocSanXuat: String);
  }

  Future<void> LoadDataLoai() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );
    String loi = "";
    final user = ref.read(currentUserIdProvider);
    state = state.copyWith(userId: user!.id);
    if (state.loais == null) {
      List<TblLoai> loais = await LoaiAPI.getLoais();
      state = state.copyWith(loais: loais);
    }
    if (state.tinhTrangs == null) {
      List<TblTinhTrang> tinhTrangs = await TinhTrangAPI.gettinhTrangs();
      state = state.copyWith(tinhTrangs: tinhTrangs);
    }
    if (state.btdKp == null) {
      BTDKP? btdkp = await BTDAPI.getBTDKPByMakp(user!.makp);
      state = state.copyWith(btdKp: btdkp);
    }
    if (state.btdKp == null) {
      loi = loi + "Không lấy được dữ liệu khoa phòng! ";
      state = state.copyWith(isLoading: true, error: loi);
    }
    if (state.loais == null) {
      loi = loi + "Không lấy được dữ liệu loại thiết bị! ";
      state = state.copyWith(isLoading: true, error: loi);
    }
    if (state.tinhTrangs == null) {
      loi = loi + "Không lấy được dữ liệu tình trạng thiết bị";
      state = state.copyWith(isLoading: true, error: loi);
    }
    state = state.copyWith(isLoading: false);
  }

  Future<void> AddData() async {
    state = state.copyWith(isLoading: true);
    DateTime dateNow = DateTime.now();
    String ngaySuDung = DateFormat('yyyy-MM-dd').format(dateNow);
    int kiemtra = Ktra();
    if (kiemtra == 1) {
      TblThietBi thietBi = TblThietBi(
          byUserID: state.userId,
          hangSanXuat: state.hangSanXuat,
          loaiThietBi: state.selectLoai!.id,
          maCodeThietBi: state.maCodeThietBi,
          makp: state.btdKp!.makp,
          model: state.model,
          ngaySuDung: ngaySuDung,
          nuocSanXuat: state.nuocSanXuat,
          tenThietBi: state.tenThietBi,
          tinhTrang: state.selectTinhTrang!.id,
          id: null);
      await ThietBiAPI.addThietBi(thietBi);
      state = state.copyWith(
          hangSanXuat: "",
          selectLoai: null,
          maCodeThietBi: "",
          model: "",
          nuocSanXuat: "",
          tenThietBi: "",
          selectTinhTrang: null);
    } else {
      print("Chưa thêm");
    }
    state = state.copyWith(isLoading: false);
  }

  int Ktra() {
    int kiemtra = 1;
    if (state.btdKp == null) {
      kiemtra = -1;
    }
    if (state.maCodeThietBi == "") {
      kiemtra = -1;
    }
    if (state.tenThietBi == "") {
      kiemtra = -1;
    }
    if (state.selectLoai == null) {
      kiemtra = -1;
    }
    if (state.tinhTrangs == -1) {
      kiemtra = -1;
    }
    return kiemtra;
  }
}

final TTBProvider = StateNotifierProvider<TTBNotifier, TTBState>((ref) {
  return TTBNotifier(ref)..LoadDataLoai();
});
