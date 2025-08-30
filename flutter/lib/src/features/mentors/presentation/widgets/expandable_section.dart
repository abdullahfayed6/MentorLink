import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_colors.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class ExpandableSection extends StatefulWidget {
  final String title;
  final List<String> children;

  const ExpandableSection({
    super.key,
    required this.title,
    this.children = const [],
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  // Track selected checkboxes (if any)
  late List<bool> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.generate(widget.children.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        iconColor: context.colorScheme.onSurface,
        collapsedIconColor: context.colorScheme.onSurface,
        title: Text(
          widget.title,
          style:Styles.textStyle16.copyWith(color: context.colorScheme.onSurface)
        ),
        children: widget.children.isNotEmpty
            ? List.generate(widget.children.length, (index) {
          return CheckboxListTile(

            value: _selected[index],
            onChanged: (value) {
              setState(() {
                _selected[index] = value ?? false;
              });
            },
            checkColor: context.colorScheme.onSurface,
            activeColor: context.colorScheme.primary,
            side: BorderSide(color: AppColors.primaryVariant), 
            checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(4.r)),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              widget.children[index],
              style: Styles.textStyle14.copyWith(color: context.colorScheme.onSurface)
            ),
          );
        })
            : [const SizedBox.shrink()],
      ),
    );
  }
}