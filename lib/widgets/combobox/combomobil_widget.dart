import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:rentcarapp/models/combobox/combomobil_model.dart';
import 'package:rentcarapp/repositories/combobox/combomobil_repository.dart';
import 'package:rentcarapp/widgets/my_colors.dart';
import 'package:rentcarapp/widgets/my_text.dart';

DropdownSearch<ComboMobilModel> buildFieldComboMobil(
    {ComboMobilModel? initItem,
    Function(ComboMobilModel?)? onChangedCallback,
    required Function(ComboMobilModel?) onSaveCallback,
    Function(ComboMobilModel?)? validatorCallback}) {
  return DropdownSearch<ComboMobilModel>(
    selectedItem: initItem,
    dropdownDecoratorProps: const DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        hintText: '...',
        labelText: 'Mobil',
      ),
    ),
    asyncItems: (String filter) async {
      return ComboMobilRepository().getComboMobil(filter);
    },
    clearButtonProps: const ClearButtonProps(isVisible: false),
    popupProps: const PopupPropsMultiSelection.modalBottomSheet(
      isFilterOnline: true,
      showSelectedItems: true,
      showSearchBox: true,
      itemBuilder: itemBuilderComboMobil,
    ),
    compareFn: (item, sItem) => item.mmobilId == sItem.mmobilId,
    itemAsString: (item) {
      return "${item.platNo} - ${item.tipeNama} (${item.thnBuat})";
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

Widget itemBuilderComboMobil(
    BuildContext context, ComboMobilModel item, bool isSelected) {
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
      title: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          elevation: 2,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
              color: Colors.grey[200],
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${item.platNo} (${item.thnBuat})",
                          style: MyText.bodyLarge(context)!
                              .copyWith(color: MyColors.grey_95)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${item.tipeNama} (${item.warnaNama})",
                          style: MyText.bodyLarge(context)!
                              .copyWith(color: MyColors.grey_80)),
                    ),
                  ]))),
    ),
  );
}
