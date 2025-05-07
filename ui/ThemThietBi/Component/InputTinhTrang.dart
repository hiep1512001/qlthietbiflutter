import 'package:bvnd115app/model/tblTinhTrang.dart';
import 'package:bvnd115app/providers/themthietbiprovider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputTinhTrang extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ttbState = ref.watch(TTBProvider);
    final ttbNotifier = ref.read(TTBProvider.notifier);
    List<TblTinhTrang>? tinhTrangs = ttbState.tinhTrangs;
    final TextEditingController textEditingController = TextEditingController();
    TblTinhTrang? selectedValue = ttbState.selectTinhTrang;

    return Column(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2<TblTinhTrang>(
            isExpanded: true,
            hint: Text(
              'Vui lòng chọn tình trạng thiết bị',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: tinhTrangs
                ?.map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.tinhTrang,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: ttbNotifier.updateSelectTinhTrang,
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
                return item.value!.tinhTrang
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
        if (ttbState.selectTinhTrang == null)
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
