import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class CustomRadioButtonGroup extends StatefulWidget {
  final String title;
  final List<String> options;
  final String? initialValue;
  final ValueChanged<String> onChanged;

  const CustomRadioButtonGroup({
    super.key,
    required this.title,
    required this.options,
    this.initialValue,
    required this.onChanged,
  });

  @override
  State<CustomRadioButtonGroup> createState() => _CustomRadioButtonGroupState();
}

class _CustomRadioButtonGroupState extends State<CustomRadioButtonGroup> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          widget.title,
          style: Styles.textStyle16
        ),

        // Custom Radio Options
        ...widget.options.map(
              (option) => Row(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  radioTheme: RadioThemeData(
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {
                        return context.colorScheme.onSurface;
                      }
                      return context.colorScheme.primary;
                    }),
                    overlayColor: MaterialStateProperty.all(
                      context.colorScheme.primary.withValues(alpha: 0.1),
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                child: Radio<String>(
                  value: option,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                    widget.onChanged(value!);
                  },
                ),
              ),
              Expanded(
                child: Text(
                  option,
                  style: Styles.textStyle16,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
