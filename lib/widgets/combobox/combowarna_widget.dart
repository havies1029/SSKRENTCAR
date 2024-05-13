import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:rentcarapp/models/combobox/combowarna_model.dart';
import 'package:rentcarapp/repositories/combobox/combowarna_repository.dart';

DropdownSearch<ComboWarnaModel> buildFieldComboWarna(
    {ComboWarnaModel? initItem,
    Function(ComboWarnaModel?)? onChangedCallback,
    required Function(ComboWarnaModel?) onSaveCallback,
    Function(ComboWarnaModel?)? validatorCallback}) {
  return DropdownSearch<ComboWarnaModel>(
    selectedItem: initItem,
    dropdownDecoratorProps: const DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        hintText: '...',
        labelText: 'Warna',
      ),
    ),
    asyncItems: (String filter) async {
      return ComboWarnaRepository().getComboWarna(filter);
    },
    clearButtonProps: const ClearButtonProps(isVisible: true),
    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
      isFilterOnline: true,
      showSelectedItems: true,
      showSearchBox: true,
      itemBuilder: itemBuilderComboWarna,
    ),
    compareFn: (item, sItem) => item.mwarnaId == sItem.mwarnaId,
    itemAsString: (item) {
      return item.warnaNama;
    },
    onChanged: (value) {
      if (onChangedCallback != null) {
        onChangedCallback(value);
      }
    },
    onSaved: (value) {
      onSaveCallback(value);
    },
    validator: (value) {
      debugPrint("buildFieldComboWarna -> validator #10");
      if (validatorCallback != null) {
        debugPrint("buildFieldComboWarna -> validator #20");
        validatorCallback(value);
        if (value == null) {
          debugPrint("buildFieldComboWarna -> validator #30");
          return "";
        } else {
          debugPrint(value.toString());
          debugPrint("buildFieldComboWarna -> validator #40");
        }
      }
      return null;
    },
  );
}

Widget itemBuilderComboWarna(
    BuildContext context, ComboWarnaModel item, bool isSelected) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
    child: ListTile(
      selected: isSelected,
      title: Text(item.warnaNama),
    ),
  );
}
