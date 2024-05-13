import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:rentcarapp/models/combobox/combostsmobil_model.dart';
import 'package:rentcarapp/repositories/combobox/combostsmobil_repository.dart';

DropdownSearch<ComboStsmobilModel> buildFieldComboStsmobil(
  {
      ComboStsmobilModel? initItem, 
      Function(ComboStsmobilModel?)? onChangedCallback,      
      required Function(ComboStsmobilModel?) onSaveCallback,
      Function(ComboStsmobilModel?)? validatorCallback

  }) {
  return DropdownSearch<ComboStsmobilModel>(
    selectedItem: initItem,
    dropdownDecoratorProps: const DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        hintText: '...',
        labelText: 'Status Mobil',
      ),
    ),
    asyncItems: (String filter) async {
      return ComboStsmobilRepository().getComboStsmobil(filter);
    },
    clearButtonProps: const ClearButtonProps(isVisible: true),
    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
      isFilterOnline: false,
      showSelectedItems: true,
      showSearchBox: false,
      itemBuilder: itemBuilderComboStsmobil,
    ),
    compareFn: (item, sItem) => item.mstsmobilId == sItem.mstsmobilId,
    itemAsString: (item) {
      return item.statusNama;
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

Widget itemBuilderComboStsmobil(
    BuildContext context, ComboStsmobilModel item, bool isSelected) {
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
      title: Text(item.statusNama),
    ),
  );
}
