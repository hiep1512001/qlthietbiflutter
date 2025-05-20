import 'package:bvnd115app/providers/themthietbiprovider.dart';
import 'package:bvnd115app/ui/ThemThietBi/Component/InputKhoa.dart';
import 'package:bvnd115app/ui/ThemThietBi/Component/InputLoai.dart';
import 'package:bvnd115app/ui/ThemThietBi/Component/InputTinhTrang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemThietBi extends StatelessWidget {
  const ThemThietBi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
              color: Colors.white),
          child: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.qr_code),
                onPressed: () {
                  // Xử lý khi bấm nút
                  print('Bấm scan');
                },
              ),
            ],
            bottom: null,
            backgroundColor: Colors.blue,
            title: Text(
              'Thêm thiết bị',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white, // Màu của icon
                size: 30.0, // Kích thước của icon
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      // backgroundColor: Color(0xffeeeeee),
      body: CustomContentThemThietBi(),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Chiều cao của nút
        child: CustomButtonBottom(),
      ),
    );
  }
}

class CustomContentThemThietBi extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ttbState = ref.watch(TTBProvider);
    return ttbState.isLoading
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Loading...',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          )
        : SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: Offset(0, 3), // đổ bóng xuống dưới
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Tên khoa phòng:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  InputKhoa(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Mã code thiết bị:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  InputCode(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Tên thiết bị:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  InputName(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Loại thiết bị:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  InputLoai(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Tình Trạng thiết bị:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  InputTinhTrang(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Model:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  InputModel(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Hảng sản xuất:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  InputHangSanXuat(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Nước sản xuất:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  InputNuocSanXuat(),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          );
  }
}

class InputCode extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ttbNotifier = ref.read(TTBProvider.notifier);
    final ttbState = ref.watch(TTBProvider);
    return Column(
      children: [
        TextField(
          onChanged: ttbNotifier.updateMaCodeThietBi,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
            filled: true,
            fillColor: Color(0xffe0e0e0),
            // label: Text("Họ và tên"),
            hintText: "Vui lòng mã code thiết bị",
            hintStyle: TextStyle(fontSize: 16),
            // labelText: '    Chọn ngày khám',
            suffixIcon: Icon(Icons.qr_code),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black, // Màu viền dưới khi không focus
                width: 1.0, // Độ dày của viền dưới
              ),
            ),
          ),
        ),
        if (ttbState.maCodeThietBi == "")
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Không được để trống!",
              style: TextStyle(color: Colors.red),
            ),
          )
      ],
    );
  }
}

class InputName extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ttbNotifier = ref.read(TTBProvider.notifier);
    final ttbState = ref.watch(TTBProvider);
    return Column(
      children: [
        TextField(
          onChanged: ttbNotifier.updateTenThietBi,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
            filled: true,
            fillColor: Color(0xffe0e0e0),
            // label: Text("Họ và tên"),
            hintText: "Vui lòng nhập tên thiết bị",
            hintStyle: TextStyle(fontSize: 16),
            // labelText: '    Chọn ngày khám',
            suffixIcon: Icon(Icons.computer),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black, // Màu viền dưới khi không focus
                width: 1.0, // Độ dày của viền dưới
              ),
            ),
          ),
        ),
        if (ttbState.tenThietBi == "")
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Không được để trống!",
              style: TextStyle(color: Colors.red),
            ),
          )
      ],
    );
  }
}

class InputModel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ttbNotifier = ref.read(TTBProvider.notifier);
    return Column(
      children: [
        TextField(
          onChanged: ttbNotifier.updateModel,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
            filled: true,
            fillColor: Color(0xffe0e0e0),
            // label: Text("Họ và tên"),
            hintText: "Vui lòng nhập model",
            hintStyle: TextStyle(fontSize: 16),
            // labelText: '    Chọn ngày khám',
            suffixIcon: Icon(Icons.schema),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black, // Màu viền dưới khi không focus
                width: 1.0, // Độ dày của viền dưới
              ),
            ),
          ),
        )
      ],
    );
  }
}

class InputHangSanXuat extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ttbNotifier = ref.read(TTBProvider.notifier);
    return TextField(
      onChanged: ttbNotifier.updateHangSanXuat,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
        filled: true,
        fillColor: Color(0xffe0e0e0),
        // label: Text("Họ và tên"),
        hintText: "Vui lòng nhập hảng sản xuất",
        hintStyle: TextStyle(fontSize: 16),
        // labelText: '    Chọn ngày khám',
        suffixIcon: Icon(Icons.factory),
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

class InputNuocSanXuat extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ttbNotifier = ref.read(TTBProvider.notifier);
    return TextField(
      onChanged: ttbNotifier.updateNuocSanXuat,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
        filled: true,
        fillColor: Color(0xffe0e0e0),
        // label: Text("Họ và tên"),
        hintText: "Vui lòng nhập nước sản xuất",
        hintStyle: TextStyle(fontSize: 16),
        // labelText: '    Chọn ngày khám',
        suffixIcon: Icon(Icons.flag),
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
    final ttbState = ref.watch(TTBProvider);
    final ttbNotifier = ref.read(TTBProvider.notifier);
    return Container(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        onPressed: ttbNotifier.AddData,
        // Navigator.pop(context);
        // Chuyển trang với hiệu ứng tùy chỉnh
        child: ttbState.isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Text(
                "Thêm thiết bị",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
      ),
    );
  }
}
