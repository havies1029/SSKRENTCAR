import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:rentcarapp/models/combobox/combotipe_model.dart';
import 'package:rentcarapp/repositories/combobox/combotipe_repository.dart';

DropdownSearch<ComboTipeModel> buildFieldComboTipe(
    {ComboTipeModel? initItem,
    Function(ComboTipeModel?)? onChangedCallback,
    required Function(ComboTipeModel?) onSaveCallback,
    Function(ComboTipeModel?)? validatorCallback}) {
  return DropdownSearch<ComboTipeModel>(
    selectedItem: initItem,
    dropdownDecoratorProps: const DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        hintText: '...',
        labelText: 'Tipe Mobil',
      ),
    ),
    asyncItems: (String filter) async {
      return ComboTipeRepository().getComboTipe(filter);
    },
    clearButtonProps: const ClearButtonProps(isVisible: true),
    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
      isFilterOnline: true,
      showSelectedItems: true,
      showSearchBox: true,
      itemBuilder: itemBuilderComboTipe,
    ),
    compareFn: (item, sItem) => item.mtipeId == sItem.mtipeId,
    itemAsString: (item) {
      return item.tipeNama;
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

Widget itemBuilderComboTipe(
    BuildContext context, ComboTipeModel item, bool isSelected) {
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
      title: Text(item.tipeNama),
    ),
  );
}
