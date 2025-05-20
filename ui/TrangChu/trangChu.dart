import 'package:bvnd115app/providers/loginprovider.dart';
import 'package:bvnd115app/state/stateLogin.dart';
import 'package:bvnd115app/ui/DSThietBi/dsThietBi.dart';
import 'package:bvnd115app/ui/TaiKhoan/taikhoan.dart';
import 'package:bvnd115app/ui/ThemThietBi/ThemThietBi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrangChu extends ConsumerWidget {
  const TrangChu({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screens = [CustomContentTrangChu(), Taikhoan()];
    int selectedIndex = ref.watch(selectedIndexTab);
    final user = ref.watch(loginProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
              color: Colors.white),
          child: AppBar(
            bottom: null,
            backgroundColor: Colors.white,
            title: Title(),
            centerTitle: true,
          ),
        ),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/logobvnd115.jpg')),
                  SizedBox(height: 10),
                  Text('Tài khoản: ${user.user!.username}',
                      style: TextStyle(color: Colors.white)),
                  Text('Khoa/Phòng: ${user.user!.btdkp!.tenkp}',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Trang chủ'),
              selected: selectedIndexTab == 0,
              selectedTileColor: Colors.blue.shade100,
              onTap: () => {
                ref.read(selectedIndexTab.notifier).state = 0,
                Navigator.pop(context),
              },
            ),
            ListTile(
              leading: Icon(Icons.manage_accounts),
              title: const Text('Tài khoản'),
              selected: selectedIndexTab == 1,
              selectedTileColor: Colors.blue.shade100,
              onTap: () => {
                ref.read(selectedIndexTab.notifier).state = 1,
                Navigator.pop(context),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Title extends ConsumerWidget {
  const Title({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = ref.watch(selectedIndexTab);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          'Bệnh viện nhân dân 115',
          style: TextStyle(
              color: Color(0xff0d47a1),
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        Text(
          'Trao yêu thương - trao sức khỏe',
          style: TextStyle(
              color: Color(0xff0d47a1),
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

class CustomContentTrangChu extends StatelessWidget {
  const CustomContentTrangChu({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: Color(0xffeeeeee),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            CustomBanner(),
            SizedBox(
              height: 5,
            ),
            CustomThemMoiThietBi(),
            SizedBox(
              height: 15,
            ),
            CustomDanhSachThietBi(),
            SizedBox(
              height: 15,
            ),
            CustomFooter()
          ],
        ),
      ),
    );
    ;
  }
}

class CustomBanner extends StatelessWidget {
  const CustomBanner({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Color(0xff1565c0),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        spacing: 5,
        children: [
          Text(
            'Quản lý thiết bị nội bộ',
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          Text(
            "Thiết bị trong tầm tay – Quản lý trong tầm kiểm soát",
            style: TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});
  final urlImage = 'assets/images/logobvnd115.jpg';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      color: Color(0xff37474f),
      child: Column(
        spacing: 5,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40), // Thiết lập bo tròn góc
            child: Image.asset(
              urlImage,
              width: 80,
              height: 80,
              fit: BoxFit
                  .cover, // Đảm bảo hình ảnh chiếm đủ không gian mà không bị méo
            ),
          ),
          Text(
            "BỆNH VIỆN NHÂN DÂN 115",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xff1de9b6)),
          ),
          Text(
            "Đại chỉ: 527 Sư Vạn Hạnh, phường 12, quận 10, thành phố Hồ Chí Minh",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            "Số điện thoại: 028 3865 2368 - 028 2865 4139 -028 3865 5110, Fax 028 3865 5193",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }
}

class CustomThemMoiThietBi extends ConsumerWidget {
  final urlThemThietBi = 'assets/icons/adddevice.png';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
          onPressed: () => {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return ThemThietBi();
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
                      return SlideTransition(
                          position: offsetAnimation, child: child);
                    },
                  ),
                )
              },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding:
                EdgeInsets.symmetric(vertical: 20, horizontal: 35), // Padding
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ), // Kiểu chữ
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Bo góc
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                urlThemThietBi,
                width: 50,
              ),
              Text(
                "Thêm thiết bị",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                "Thêm thiết bị mới vào hệ thống quản lý",
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }
}

class CustomDanhSachThietBi extends StatelessWidget {
  const CustomDanhSachThietBi({super.key});
  final urlDSThieBi = 'assets/icons/listdevice.png';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
          onPressed: () => {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return DSThietBi();
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
                      return SlideTransition(
                          position: offsetAnimation, child: child);
                    },
                  ),
                )
              },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding:
                EdgeInsets.symmetric(vertical: 20, horizontal: 35), // Padding
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ), // Kiểu chữ
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Bo góc
            ),
          ),
          child: Column(
            children: [
              Image.asset(
                urlDSThieBi,
                width: 50,
              ),
              Text(
                "Danh sách thiết bị",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                "Danh sách thiết bị tập trung, dễ dàng tra cứu và cập nhật",
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }
}
