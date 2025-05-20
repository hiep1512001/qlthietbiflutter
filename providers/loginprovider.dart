import 'package:bvnd115app/model/tblUsers.dart';
import 'package:bvnd115app/services/userApi.dart';
import 'package:bvnd115app/ui/DangNhap/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  tblUsers? user;
  String userName;
  String password;
  bool isLoading;
  bool isLoggedIn;
  bool isLogOut;
  String error;
  LoginState(
      {required this.userName,
      required this.password,
      required this.isLoading,
      required this.isLoggedIn,
      required this.user,
      required this.error,
      required this.isLogOut});
  //hàm copp khi thay đổi
  LoginState copyWith(
      {String? userName,
      String? password,
      bool? isLoading,
      bool? isLoggedIn,
      tblUsers? user,
      String? error,
      bool? isLogOut}) {
    return LoginState(
        userName: userName ?? this.userName,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        error: error ?? this.error,
        user: user ?? this.user,
        isLogOut: isLogOut ?? this.isLogOut);
  }

  //hàm khởi tạo ban đầu
  factory LoginState.initial() => LoginState(
      userName: "",
      password: "",
      isLoading: false,
      isLoggedIn: false,
      error: "",
      user: null,
      isLogOut: false);
}

// Notifier: chứa logic xử lý
class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState.initial());
  void updateUsername(String value) {
    state = state.copyWith(userName: value);
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value);
  }

  Future<bool> login() async {
    state = state.copyWith(
        isLoading: true, error: null, isLoggedIn: false, user: null);
    // await Future.delayed(Duration(seconds: 2)); // Giả lập API
    tblUsers? user =
        await UserAPI.getUserByUserName(state.userName, state.password);
    if (user != null) {
      state = state.copyWith(
        user: user,
        isLoggedIn: true,
        isLoading: false,
      );
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        isLoggedIn: false,
        error: 'Sai tài khoản hoặc mật khẩu',
      );
      return false;
    }
  }

  Future<bool> logout(BuildContext context) async {
    if (state.isLogOut == true) {
      state = state.copyWith(
        isLogOut: false,
      );
    }
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xác nhận đăng xuất'),
        content: const Text('Bạn có chắc chắn muốn đăng xuất?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Huỷ'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      state = state.copyWith(isLogOut: true, userName: "", password: "");
      return true;
    } else {
      state = state.copyWith(isLogOut: false);
      return false;
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);
final currentUserIdProvider = Provider<tblUsers?>((ref) {
  return ref.watch(loginProvider).user;
});
