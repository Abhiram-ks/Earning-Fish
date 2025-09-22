import 'package:earningfish/core/themes/app_colors.dart';
import 'package:earningfish/core/validation/validation_helper.dart';
import 'package:flutter/material.dart';

Widget buildRadioTile({
  required String title,
  bool? value,
  required Function(bool?) onChanged,
  TextEditingController? remarkController,
}) {
  return Card(
    margin: const EdgeInsets.only(bottom: 8),
    elevation: 2,
    shadowColor: AppPalette.blackColor,
    color: Color(0xFFEAF4F4),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Row(
            children: [
              Expanded(
                child: RadioListTile<bool>(
                  title: const Text('Ok'),
                  value: true,
                  activeColor: AppPalette.blackColor,
                  groupValue: value,
                  onChanged: onChanged,
                  dense: true,
                ),
              ),
              Expanded(
                child: RadioListTile<bool>(
                  title: const Text('Not ok'),
                  value: false,
                  groupValue: value,
                  activeColor: AppPalette.blackColor,
                  onChanged: onChanged,
                  dense: true,
                ),
              ),
            ],
          ),
          if (value == false)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextFormField(
                controller: remarkController,
                decoration: InputDecoration(
                  labelText: "Please Enter remark",
                  labelStyle: TextStyle(color: AppPalette.greyColor),
                  filled: true,
                  
                  fillColor: AppPalette.whiteColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppPalette.hintColor,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppPalette.blueColor,
                      width: 1,
                    ),
                  ),
                ),
                maxLines: 2,
                validator: (val) => ValidatorHelper.basicTextFiledValidation(val),
              ),
            ),
        ],
      ),
    ),
  );
}
