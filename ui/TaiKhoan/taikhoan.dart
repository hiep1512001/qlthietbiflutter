import 'package:bvnd115app/providers/loginprovider.dart';
import 'package:bvnd115app/state/stateLogin.dart';
import 'package:bvnd115app/ui/DangNhap/Login.dart';
import 'package:bvnd115app/ui/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Taikhoan extends ConsumerWidget {
  // Giả lập dữ liệu người dùng - có thể thay bằng dữ liệu từ Supabase hoặc Riverpod sau này

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = ref.watch(selectedIndexTab);
    ref.listen<LoginState>(loginProvider, (prev, next) {
      if (next.isLogOut && prev?.isLogOut == false) {
        ref.read(selectedIndexTab.notifier).state = 0;
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return DangNhap();
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Hiệu ứng chuyển trang từ phải sang trái
                const begin = Offset(-1.0, 0.0); // bắt đầu từ phải
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
    return Scaffold(body: CustomContent());
  }
}

class CustomContent extends ConsumerWidget {
  const CustomContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);
    final String name = 'Tài khoản: ${user.user!.username}';
    String role = user.user!.vaitro == 1 ? "Quản trị viên" : "Người dùng";
    final String department = 'Khoa/Phòng: ${user.user!.btdkp!.tenkp}';
    final String profileImageUrl = 'assets/images/logobvnd115.jpg';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 18),
        Card(
            color: Colors.white,
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(profileImageUrl),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Chip(label: Text(role)),
                Text(department),
                const SizedBox(height: 24),
              ],
            )),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Chỉnh sửa hồ sơ'),
          onTap: () {
            // TODO: Chuyển tới chỉnh sửa
          },
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: const Text('Đổi mật khẩu'),
          onTap: () => showChangePasswordDialog(context),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Đăng xuất'),
          onTap: () => loginNotifier..logout(context),
        ),
      ],
    );
  }
}
