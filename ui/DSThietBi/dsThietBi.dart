import 'package:bvnd115app/providers/chitietthietbiprovider.dart';
import 'package:bvnd115app/providers/dsthietbiprovider.dart';
import 'package:bvnd115app/ui/DSThietBi/chitietthietbi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DSThietBi extends StatelessWidget {
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
              bottom: null,
              backgroundColor: Colors.blue,
              title: Text(
                'Danh sách thiết bị',
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
        body: CustomContent());
  }
}

class CustomContent extends ConsumerWidget {
  Color getColorFromName(String? name) {
    switch (name) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      // thêm các màu bạn dùng
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dsThietBiState = ref.watch(dsThietBiProvider);
    final devices = dsThietBiState.listThietBi;
    final chiTietTBNotifier = ref.read(chiTietTBProvider.notifier);
    return dsThietBiState.isLoading
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
        : ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              final device = devices[index];
              return Card(
                color: Colors.white,
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: Icon(Icons.devices_other,
                      color: getColorFromName(device.tblTinhTrang?.color)),
                  title: Text(device.tenThietBi.toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle:
                      // Text('Mã code: ${device.maCodeThietBi}\n${device.model}'),
                      Text(
                          'Mã code: ${device.maCodeThietBi}\nKhoa phòng: ${dsThietBiState.btdkp!.tenkp}'),
                  trailing: Text(
                    device.tblTinhTrang!.tinhTrang,
                    style: TextStyle(
                      color: getColorFromName(device.tblTinhTrang?.color),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  isThreeLine: true,
                  onTap: () => {
                    chiTietTBNotifier.updateThietBiSelect(device),
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return ChiTietThietBi();
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          // Hiệu ứng chuyển trang từ phải sang trái
                          const begin = Offset(1.0, 0.0); // bắt đầu từ phải
                          const end =
                              Offset.zero; // kết thúc tại vị trí ban đầu
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
                ),
              );
            },
          );
  }
}
