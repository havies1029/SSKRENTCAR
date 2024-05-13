import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:rentcarapp/models/combobox/combomasasewa_model.dart';
import 'package:rentcarapp/repositories/combobox/combomasasewa_repository.dart';

DropdownSearch<ComboMasasewaModel> buildFieldComboMasasewa(
    {ComboMasasewaModel? initItem,
    Function(ComboMasasewaModel?)? onChangedCallback,
    required Function(ComboMasasewaModel?) onSaveCallback,
    Function(ComboMasasewaModel?)? validatorCallback}) {

  debugPrint("Create Combo ComboMasasewaModel");
  debugPrint("initItem : ${initItem.toString()}");

  return DropdownSearch<ComboMasasewaModel>(
    selectedItem: initItem,
    dropdownDecoratorProps: const DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        hintText: '...',
        labelText: 'Masa Sewa',
      ),
    ),
    asyncItems: (String filter) async {
      return ComboMasasewaRepository().getComboMasasewa();
    },
    clearButtonProps: const ClearButtonProps(isVisible: false),
    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
      isFilterOnline: false,
      showSelectedItems: true,
      showSearchBox: false,
      itemBuilder: itemBuilderComboMasasewa,
    ),
    compareFn: (item, sItem) => item.mmasaId == sItem.mmasaId,
    itemAsString: (item) {
      return item.masaNama;
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
      if (validatorCallback != null) {
        validatorCallback(value);
        if (value == null) {
          return "";
        }
      }
      return null;
    },
  );
}

Widget itemBuilderComboMasasewa(
    BuildContext context, ComboMasasewaModel item, bool isSelected) {
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
      title: Text(item.masaNama),
    ),
  );
}
