import 'package:bvnd115app/model/tblThietBi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiTietTBState {
  TblThietBi? tblThietBi;
  bool isLoading;
  String error;
  ChiTietTBState(
      {required this.tblThietBi, required this.isLoading, required this.error});
  //hàm copp khi thay đổi
  ChiTietTBState copyWith(
      {bool? isLoading, String? error, TblThietBi? tblThietBi}) {
    return ChiTietTBState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      tblThietBi: tblThietBi ?? this.tblThietBi,
    );
  }

  //hàm khởi tạo ban đầu
  factory ChiTietTBState.initial() => ChiTietTBState(
        isLoading: false,
        error: "",
        tblThietBi: null,
      );
}

class ChiTietTBNotifier extends StateNotifier<ChiTietTBState> {
  ChiTietTBNotifier() : super(ChiTietTBState.initial());
  void updateThietBiSelect(TblThietBi) {
    state = state.copyWith(tblThietBi: TblThietBi);
    print(state.tblThietBi);
  }

  // void LoadDate() {
  //   state = state.copyWith(isLoading: false);
  // }
}

final chiTietTBProvider =
    StateNotifierProvider<ChiTietTBNotifier, ChiTietTBState>(
  (ref) => ChiTietTBNotifier(),
);
