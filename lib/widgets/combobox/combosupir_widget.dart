import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:rentcarapp/models/combobox/combosupir_model.dart';
import 'package:rentcarapp/repositories/combobox/combosupir_repository.dart';

DropdownSearch<ComboSupirModel> buildFieldComboSupir({
  required String labelText,
	ComboSupirModel? initItem,
	Function(ComboSupirModel?)? onChangedCallback,
	required Function(ComboSupirModel?) onSaveCallback,
	Function(ComboSupirModel?)? validatorCallback
	}) {
  return DropdownSearch<ComboSupirModel>(
		selectedItem: initItem,
		dropdownDecoratorProps: DropDownDecoratorProps(
			dropdownSearchDecoration: InputDecoration(
				hintText: '...',
				labelText: labelText,        
			),
		),
			asyncItems: (filter) async {
				return ComboSupirRepository().getComboSupir();
			},
			clearButtonProps: const ClearButtonProps(isVisible: false),
			popupProps: const PopupPropsMultiSelection.modalBottomSheet(
				isFilterOnline: false,
				showSelectedItems: true,
				showSearchBox: false,
				itemBuilder: itemBuilderComboSupir,
			),
			compareFn: (item, sItem) => item.mstaffId == sItem.mstaffId,
			itemAsString: (item) {
				return item.staffNama;
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

Widget itemBuilderComboSupir(
	BuildContext context, ComboSupirModel item, bool isSelected) {
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
			title: Text(item.staffNama),
		),
	);
}
