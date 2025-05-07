import 'package:bvnd115app/providers/loginprovider.dart';
import 'package:bvnd115app/state/stateLogin.dart';
import 'package:bvnd115app/ui/TrangChu/trangChu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DangNhap extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<LoginState>(loginProvider, (prev, next) {
      if (next.isLoggedIn && prev?.isLoggedIn == false) {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return TrangChu();
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Hiệu ứng chuyển trang từ phải sang trái
                const begin = Offset(1.0, 0.0); // bắt đầu từ phải
                const end = Offset.zero; // kết thúc tại vị trí ban đầu
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            ));
      }
    });
    return Scaffold(
      // backgroundColor: Color(0xffeeeeee),
      body: CustomDanhNhap(),
      bottomNavigationBar: CustomButtonBottom(),
    );
  }
}

class CustomDanhNhap extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white, // Màu nền của container
        borderRadius: BorderRadius.circular(10), // Bo góc với bán kính 20
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              child: Image.network(
                "https://theme.hstatic.net/200000736895/1001102506/14/logo.png?v=515",
                height: 70,
              )),
          SizedBox(
            height: 40,
          ),
          Container(
            width: double.infinity,
            child: Text(
              "Tài khoản:",
              style: TextStyle(fontSize: 16),
            ),
          ),
          InputAccount(),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: Text(
              "Mật khẩu:",
              style: TextStyle(fontSize: 16),
            ),
          ),
          InputPassword(),
          SizedBox(
            height: 4,
          ),
          SizedBox(
            height: 25,
          ),
          if (loginState.error != "")
            Text(
              loginState.error,
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }
}

class InputAccount extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final loginNotifier = ref.read(loginProvider.notifier);
    return TextField(
      onChanged: loginNotifier.updateUsername,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
        filled: true,
        fillColor: Color(0xffe0e0e0),
        // label: Text("Họ và tên"),
        hintText: "Vui lòng nhập tài khoản",
        hintStyle: TextStyle(fontSize: 16),
        // labelText: '    Chọn ngày khám',

        suffixIcon: Icon(Icons.account_circle),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.black, // Màu viền dưới khi không focus
            width: 1.0, // Độ dày của viền dưới
          ),
        ),
      ),
    );
  }
}

class InputPassword extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool _obscureText = ref.watch(obscureTextPassWord);
    final loginNotifier = ref.read(loginProvider.notifier);
    // TODO: implement build
    return TextField(
      obscureText: _obscureText,
      onChanged: loginNotifier.updatePassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
        filled: true,
        fillColor: Color(0xffe0e0e0),
        // label: Text("Họ và tên"),
        hintText: "Vui lòng nhập mật khẩu",
        hintStyle: TextStyle(fontSize: 16),
        // labelText: '    Chọn ngày khám',
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            ref.read(obscureTextPassWord.notifier).state = !_obscureText;
          },
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.black, // Màu viền dưới khi không focus
            width: 1.0, // Độ dày của viền dưới
          ),
        ),
      ),
    );
  }
}

class CustomButtonBottom extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);
    return Container(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Color(0xff1565c0)),
        onPressed: () => loginNotifier.login(),
        // Navigator.pop(context);
        // Chuyển trang với hiệu ứng tùy chỉnh
        child: loginState.isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Text(
                "Đăng nhập",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
      ),
    );
  }
}
