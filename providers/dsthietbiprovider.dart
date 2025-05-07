import 'package:bvnd115app/model/btdkp.dart';
import 'package:bvnd115app/model/tblThietBi.dart';
import 'package:bvnd115app/model/tblUsers.dart';
import 'package:bvnd115app/providers/loginprovider.dart';
import 'package:bvnd115app/services/btdkpApi.dart';
import 'package:bvnd115app/services/thietBiApi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DSThietBiState {
  List<TblThietBi> listThietBi;
  bool isLoading;
  String error;
  BTDKP? btdkp;
  DSThietBiState(
      {required this.listThietBi,
      required this.isLoading,
      required this.error,
      required this.btdkp});
  //hàm copp khi thay đổi
  DSThietBiState copyWith(
      {bool? isLoading,
      List<TblThietBi>? listThietBi,
      String? error,
      BTDKP? btdkp}) {
    return DSThietBiState(
        btdkp: btdkp ?? this.btdkp,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        listThietBi: listThietBi ?? this.listThietBi);
  }

  //hàm khởi tạo ban đầu
  factory DSThietBiState.initial() =>
      DSThietBiState(isLoading: false, error: "", listThietBi: [], btdkp: null);
}

// Notifier: chứa logic xử lý
class DSThietBiNotifier extends StateNotifier<DSThietBiState> {
  DSThietBiNotifier(this.ref) : super(DSThietBiState.initial());
  final Ref ref;
  Future<void> LoadData() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );
    final user = ref.read(currentUserIdProvider);
    if (state.btdkp == null) {
      BTDKP? btdkp = await BTDAPI.getBTDKPByMakp(user!.makp);
      state = state.copyWith(btdkp: btdkp);
    }
    List<TblThietBi> listThietBi =
        await ThietBiAPI.getDSThietBiByMakp(user!.makp);
    if (listThietBi.length != 0) {
      state = state.copyWith(isLoading: false, listThietBi: listThietBi);
    } else {
      state = state.copyWith(isLoading: false);
    }
  }
}

final dsThietBiProvider =
    StateNotifierProvider<DSThietBiNotifier, DSThietBiState>(
  (ref) => DSThietBiNotifier(ref)..LoadData(),
);
final currentUserIdProvider = Provider<tblUsers?>((ref) {
  return ref.watch(loginProvider).user;
});
