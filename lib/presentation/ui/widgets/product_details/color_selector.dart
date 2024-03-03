import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  final List<Color> colors;
  final Function(Color) onChange;

  const ColorSelector({
    super.key,
    required this.colors,
    required this.onChange,
  });

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.colors.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.colors
          .map(
            (c) => Padding(
          padding: const EdgeInsets.only(right: 4),
          child: GestureDetector(
            onTap: () {
              _selectedColor = c;
              widget.onChange(c);
              if (mounted) {
                setState(() {});
              }
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor: c,
              child: _selectedColor == c
                  ? const Icon(
                Icons.done,
                color: Colors.white,
              )
                  : null,
            ),
          ),
        ),
      )
          .toList(),
    );
  }
}