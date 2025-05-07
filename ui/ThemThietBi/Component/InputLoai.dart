import 'package:bvnd115app/model/tblLoai.dart';
import 'package:bvnd115app/providers/themthietbiprovider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputLoai extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ttbState = ref.watch(TTBProvider);
    final ttbNotifier = ref.read(TTBProvider.notifier);
    List<TblLoai>? loais = ttbState.loais;
    TblLoai? selectedValue = ttbState.selectLoai;
    final TextEditingController textEditingController = TextEditingController();
    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2<TblLoai>(
            isExpanded: true,

            hint: Text(
              'Vui lòng chọn loại thiết bị',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: loais
                ?.map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.tenLoai,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: ttbNotifier.updateSelectLoai,
            buttonStyleData: ButtonStyleData(
              height: 45,
              decoration: BoxDecoration(
                  color: Color(0xffe0e0e0),
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1))),
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(color: Colors.white),
              maxHeight: 300,
            ),
            menuItemStyleData: MenuItemStyleData(
              height: 40,
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: textEditingController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextField(
                  expands: true,
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Tìm kiếm',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return item.value!.tenLoai
                    .toString()
                    .toLowerCase()
                    .contains(searchValue.toLowerCase());
              },
            ),
            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController.clear();
              }
            },
          ),
        ),
        if (ttbState.selectLoai == null)
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
