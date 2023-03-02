import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatelessWidget {
  const DropdownButtonWidget({
    super.key,
    required this.list,
    required this.value,
    required this.onChanged,
    this.icon,
  });

  final List<String> list;
  final String value;
  final void Function(String?)? onChanged;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            borderRadius: BorderRadius.circular(15),
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
            icon: icon,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          )
        : const CircularProgressIndicator.adaptive();
  }
}
