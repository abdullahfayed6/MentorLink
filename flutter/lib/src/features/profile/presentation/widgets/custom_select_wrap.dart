import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class CustomSelectableWrap extends StatelessWidget {
  final List<String> items;
  final Set selectedItems;
  final Function(String) onSelected;

  const CustomSelectableWrap({
    Key? key,
    required this.items,
    required this.selectedItems,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8.h,
      spacing: 8.w,
      children: List.generate(items.length, (index) {
        final type = items[index];
        final isSelected = selectedItems.contains(type);

        return GestureDetector(
          onTap: () => onSelected(type),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.surface,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: const Color(0xFFB4C1C1)),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            child: Text(
              type,
              style: Styles.textStyle12
            ),
          ),
        );
      }),
    );
  }
}