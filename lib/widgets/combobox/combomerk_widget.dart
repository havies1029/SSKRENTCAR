import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:rentcarapp/models/combobox/combomerk_model.dart';
import 'package:rentcarapp/repositories/combobox/combomerk_repository.dart';

DropdownSearch<ComboMerkModel> buildFieldComboMerk({
      ComboMerkModel? initItem, 
      Function(ComboMerkModel?)? onChangedCallback,
      required Function(ComboMerkModel?) onSaveCallback,
      Function(ComboMerkModel?)? validatorCallback

  }) {
  return DropdownSearch<ComboMerkModel>(
    selectedItem: initItem,
    dropdownDecoratorProps: const DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        hintText: '...',
        labelText: 'Merk',
      ),
    ),
    asyncItems: (String filter) async {
      return ComboMerkRepository().getComboMerk(filter);
    },
    clearButtonProps: const ClearButtonProps(isVisible: true),
    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
      isFilterOnline: true,
      showSelectedItems: true,
      showSearchBox: true,
      itemBuilder: itemBuilderComboMerk,
    ),
    compareFn: (item, sItem) => item.mmerkId == sItem.mmerkId,
    itemAsString: (item) {
      return item.merkNama;
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

Widget itemBuilderComboMerk(
    BuildContext context, ComboMerkModel item, bool isSelected) {
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
      title: Text(item.merkNama),
    ),
  );
}
