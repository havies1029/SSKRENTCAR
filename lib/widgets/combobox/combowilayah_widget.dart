import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:rentcarapp/models/combobox/combowilayah_model.dart';
import 'package:rentcarapp/repositories/combobox/combowilayah_repository.dart';

DropdownSearch<ComboWilayahModel> buildFieldComboWilayah({
    ComboWilayahModel? initItem,     
    Function(ComboWilayahModel?)? onChangedCallback,
    required Function(ComboWilayahModel?) onSaveCallback,
    Function(ComboWilayahModel?)? validatorCallback
  }) {
  return DropdownSearch<ComboWilayahModel>(    
    selectedItem: initItem,
    dropdownDecoratorProps: const DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        hintText: '...',
        labelText: 'Wilayah',
      ),
    ),
    asyncItems: (String filter) async {
      return ComboWilayahRepository().getComboWilayah();
    },    
    clearButtonProps: const ClearButtonProps(isVisible: false),
    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
      isFilterOnline: false,
      showSelectedItems: true,
      showSearchBox: false,
      itemBuilder: itemBuilderComboWilayah,
    ),
    compareFn: (item, sItem) => item.mwilayahId == sItem.mwilayahId,
    itemAsString: (item) {
      return item.wilayahNama;
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

Widget itemBuilderComboWilayah(
    BuildContext context, ComboWilayahModel item, bool isSelected) {
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
      title: Text(item.wilayahNama),
    ),
  );
}
