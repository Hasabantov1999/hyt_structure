// ignore_for_file: deprecated_member_use

import 'package:fast_structure/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../gen/assets.gen.dart';
import '../../public/color_palette.dart';
import '../../public/radius_palette.dart';


class AppDropdownField extends StatefulWidget {
  const AppDropdownField(
      {Key? key,
      required this.title,
      required this.hintText,
      required this.itemList,
      required this.onChanged,
      this.selectedModel,
      this.height,
      this.width})
      : super(key: key);
  final String title;
  final String hintText;
  final List<DropdownModel> itemList;
  final Function(DropdownModel? data) onChanged;
  final DropdownModel? selectedModel;
  final double? width;
  final double? height;
  @override
  State<AppDropdownField> createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {
  @override
  void didUpdateWidget(covariant AppDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedModel != widget.selectedModel) {
      value = widget.selectedModel;
      setState(() {});
    }
    if (oldWidget.itemList != widget.itemList) {
      value = null;
      setState(() {});
    }
  }

  DropdownModel? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            color: Color(0xFF677294),
            fontSize: 14,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.w400,
            height: 0.11,
          ),
        ),
        const SizedBox(
          height: 13,
        ),
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: DropdownButtonFormField<DropdownModel>(
            value: value,
            isDense: true,
            icon: SvgPicture.asset(
              Assets.svg.dropdown,
              color: ColorPalette.grayColors.borderGray,
            ),
            hint: Text(
              widget.hintText,
              style: value == null
                  ? const TextStyle(
                      color: Color(0xFF677294),
                    )
                  : const TextStyle(
                      color: Colors.black,
                    ),
            ),
            isExpanded: true,
            items: widget.itemList.map((DropdownModel value) {
              return DropdownMenuItem<DropdownModel>(
                value: value,
                child: Text(value.text.toString().toCapitalized()),
              );
            }).toList(),
            onChanged: (newValue) {
              value = newValue;
              widget.onChanged(newValue);
              setState(() {});
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.grayColors.borderGray,
                ),
                borderRadius: RadiusPalette.radius10,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
            ),
            validator: (value) {
              if (widget.hintText.isNotEmpty) {
                return null;
              } else {
                if (value != null) {
                  return null;
                } else {
                  return 'Bu alan zorunludur';
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
/*
DropdownButtonHideUnderline(
            child: DropdownButton<DropdownModel>(
              value: value,
              isDense: true,
              hint: Text(widget.hintText),
              isExpanded: true,
              items: widget.itemList.map((DropdownModel value) {
                return DropdownMenuItem<DropdownModel>(
                  value: value,
                  child: Text(value.text.toString().toCapitalized()),
                );
              }).toList(),
              onChanged: (newValue) {
                value = newValue;
                widget.onChanged(newValue);
                setState(() {});
              },
            ),
          ),
 */

class DropdownModel {
  final dynamic value;
  final String? text;
   bool selected;
  DropdownModel({required this.value, this.text, this.selected=false});
}
