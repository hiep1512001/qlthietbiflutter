import 'package:bvnd115app/model/tblUsers.dart';
import 'package:bvnd115app/services/userApi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  tblUsers? user;
  String userName;
  String password;
  bool isLoading;
  bool isLoggedIn;
  String error;
  LoginState(
      {required this.userName,
      required this.password,
      required this.isLoading,
      required this.isLoggedIn,
      required this.user,
      required this.error});
  //hàm copp khi thay đổi
  LoginState copyWith(
      {String? userName,
      String? password,
      bool? isLoading,
      bool? isLoggedIn,
      tblUsers? user,
      String? error}) {
    return LoginState(
        userName: userName ?? this.userName,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        error: error ?? this.error,
        user: user ?? this.user);
  }

  //hàm khởi tạo ban đầu
  factory LoginState.initial() => LoginState(
      userName: "",
      password: "",
      isLoading: false,
      isLoggedIn: false,
      error: "",
      user: null);
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
    state = state.copyWith(isLoading: true, error: null);
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

  void logout() {
    state = LoginState.initial();
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);
final currentUserIdProvider = Provider<tblUsers?>((ref) {
  return ref.watch(loginProvider).user;
});
