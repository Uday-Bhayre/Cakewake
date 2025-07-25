import 'package:flutter/material.dart';

class SelectListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;
  final TextStyle? selectedTextStyle;
  final TextStyle? unselectedTextStyle;

  const SelectListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.selectedColor,
    this.unselectedColor,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.selectedTextStyle,
    this.unselectedTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? (selectedColor ??
                Theme.of(context).colorScheme.primary.withOpacity(0.08))
          : (unselectedColor ?? Colors.transparent),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: isSelected
                  ? (selectedTextStyle ??
                        TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ))
                  : (unselectedTextStyle ??
                        TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w400,
                        )),
            ),
            subtitle: subtitle != null
                ? Text(
                    subtitle!,
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  )
                : null,
            trailing: isSelected
                ? Icon(
                    Icons.radio_button_checked,
                    color:
                        selectedIconColor ??
                        Theme.of(context).colorScheme.primary,
                  )
                : Icon(
                    Icons.radio_button_off,
                    color:
                        unselectedIconColor ??
                        Theme.of(context).colorScheme.outline,
                  ),
            onTap: onTap,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(context).colorScheme.onSecondary,
            indent: 0,
            endIndent: 0,
          ),
        ],
      ),
    );
  }
}
