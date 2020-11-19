// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/pickers/scroll_picker.dart';

import '../interfaces/common_dialog_properties.dart';
import 'responsive_dialog.dart';

/// This is a support widget that returns an Dialog with checkboxes as a Widget.
/// It is designed to be used in the showDialog method of other fields.
class ScrollPickerDialog extends StatefulWidget
    implements ICommonDialogProperties {
  ScrollPickerDialog({
    this.title,
    this.items,
    this.initialItem,
    this.headerColor,
    this.headerTextColor,
    this.backgroundColor,
    this.buttonTextColor,
    this.maxLongSide,
    this.maxShortSide,
    this.showDivider: true,
    this.confirmText,
    this.cancelText,
  });

  // Variables
  List<String> items;
  List<String> allItems = [];
  final String initialItem;
  @override
  final String title;
  @override
  final Color headerColor;
  @override
  final Color headerTextColor;
  @override
  final Color backgroundColor;
  @override
  final Color buttonTextColor;
  @override
  final double maxLongSide;
  @override
  final double maxShortSide;
  @override
  final String confirmText;
  @override
  final String cancelText;

  final bool showDivider;

  @override
  State<ScrollPickerDialog> createState() =>
      _ScrollPickerDialogState(initialItem);
}

class _ScrollPickerDialogState extends State<ScrollPickerDialog> {
  _ScrollPickerDialogState(this.selectedItem);

  String selectedItem;

  void updateItems(String filterText) {
    if (widget.allItems.length == 0) {
      widget.allItems = widget.items;
    }
    // print(filterText);
    if (filterText != "") {
      setState(() {
        widget.items = [];
        for (var index = 0; index < widget.allItems.length; index++) {
          if (widget.allItems[index].contains(filterText)) {
            widget.items.add(widget.allItems[index]);
          }
        }
      });
    } else {
      setState(() {
        widget.items = widget.allItems;
      });
    }
    // print(widget.items);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    assert(context != null);

    return ResponsiveDialog(
      context: context,
      title: widget.title,
      headerColor: widget.headerColor,
      headerTextColor: widget.headerTextColor,
      backgroundColor: widget.backgroundColor,
      buttonTextColor: widget.buttonTextColor,
      maxLongSide: widget.maxLongSide,
      maxShortSide: widget.maxLongSide,
      confirmText: widget.confirmText,
      cancelText: widget.cancelText,
      onFiltered: updateItems,
      child: ScrollPicker(
        items: widget.items,
        initialValue: selectedItem,
        showDivider: widget.showDivider,
        onChanged: (value) => setState(() => selectedItem = value),
      ),
      okPressed: () => Navigator.of(context).pop(selectedItem),
    );
  }
}
