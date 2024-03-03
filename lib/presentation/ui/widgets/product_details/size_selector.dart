import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  final List<String> size;
  final Function(String) onChange;

  const SizeSelector({
    super.key,
    required this.size,
    required this.onChange,
  });

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  late String _selectedSize;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.size.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.size
          .map(
            (s) => Padding(
          padding: const EdgeInsets.only(right: 4),
          child: GestureDetector(
            onTap: () {
              _selectedSize = s;
              widget.onChange(s);
              if (mounted) {
                setState(() {});
              }
            },
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey),
                color: _selectedSize == s ? AppColors.primaryColor : null,
              ),
              child: Text(
                s,
                style: TextStyle(
                  color: _selectedSize == s ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      )
          .toList(),
    );
  }
}