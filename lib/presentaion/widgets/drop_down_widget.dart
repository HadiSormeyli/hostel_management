import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/config/theme.dart';

class DropDownWidget extends StatefulWidget {
  List<String> items;
  String? selectedValue;
  String? label;

  final Function onChanged;
  final double borderRadius;
  final double borderWidth;
  final bool enabled;
  Color backgroundColor;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();

  DropDownWidget(
      {required this.items,
      required this.onChanged,
      this.label,
      this.selectedValue,
      this.backgroundColor = canvasColor,
      this.borderRadius = 0,
      this.borderWidth = 1,
      Key? key,
      this.enabled = true})
      : super(key: key) {
    selectedValue ?? items.insert(0, "همه");
  }
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String? _selectedValue;

  @override
  void initState() {
    _selectedValue = widget.selectedValue;
    _selectedValue ??= widget.items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null)
              Container(
                margin: const EdgeInsets.all(smallDistance),
                child: Text(widget.label!),
              ),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: false,
                items: widget.items
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value as String;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: 48,
                  width: 184,
                  padding: const EdgeInsets.only(
                      left: mediumDistance, right: mediumDistance),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.3), width: 1),
                    borderRadius: BorderRadius.circular(mediumDistance),
                    color: widget.backgroundColor,
                  ),
                  elevation: 0,
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                  iconSize: 14,
                  iconEnabledColor: white,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: 200,
                  padding: null,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(mediumRadius),
                    color: widget.backgroundColor,
                  ),
                  elevation: 8,
                  offset: const Offset(0, -4),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(40),
                    thickness: MaterialStateProperty.all<double>(6),
                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(
                      left: mediumDistance, right: mediumDistance),
                ),
              ),
            ),
          ],
        ));
  }
}
