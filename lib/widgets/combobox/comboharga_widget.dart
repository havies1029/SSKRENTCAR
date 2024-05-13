import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:rentcarapp/models/combobox/comboharga_model.dart';
import 'package:rentcarapp/repositories/combobox/comboharga_repository.dart';

DropdownSearch<ComboHargaModel> buildFieldComboHarga(
    {ComboHargaModel? initItem,
    Function(ComboHargaModel?)? onChangedCallback,
    required Function(ComboHargaModel?) onSaveCallback,
    Function(ComboHargaModel?)? validatorCallback}) {
  return DropdownSearch<ComboHargaModel>(
    selectedItem: initItem,
    dropdownDecoratorProps: const DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        hintText: '...',
        labelText: 'Harga Sewa',
      ),
    ),
    asyncItems: (String filter) async {
      return ComboHargaRepository().getComboHarga(filter);
    },
    clearButtonProps: const ClearButtonProps(isVisible: false),
    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
      isFilterOnline: false,
      showSelectedItems: true,
      showSearchBox: false,
      itemBuilder: itemBuilderComboHarga,
    ),
    compareFn: (item, sItem) => item.mhargaId == sItem.mhargaId,
    itemAsString: (item) {
      return item.hargaDesc;
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

Widget itemBuilderComboHarga(
    BuildContext context, ComboHargaModel item, bool isSelected) {
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
      title: Text(item.hargaDesc),
    ),
  );
}
