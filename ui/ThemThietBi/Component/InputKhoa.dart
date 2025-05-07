import 'package:bvnd115app/providers/themthietbiprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputKhoa extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ttbState = ref.watch(TTBProvider);

    final TextEditingController textEditingController =
        TextEditingController(text: ttbState.btdKp?.tenkp);
    return TextField(
      readOnly: true,
      controller: textEditingController, // chỉ xem, không cho sửa
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
        filled: true,
        fillColor: Color(0xffe0e0e0),
        // label: Text("Họ và tên"),
        hintText: "Vui lòng nhập khoa phòng",
        hintStyle: TextStyle(fontSize: 16),
        // labelText: '    Chọn ngày khám',
        suffixIcon: Icon(Icons.meeting_room),
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
