
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
   SizeSelector( {super.key, required this.sizes,required this.onChanged});

  final String sizes;
  Function(String )onChanged;

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  static int selectedSize = 0;
 late List<String>sizes=widget.sizes.split(',');
 @override
  void initState() {
    super.initState();
    widget.onChanged(sizes[0]);
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 4,
        ),
        itemCount:sizes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              selectedSize = index;
              widget.onChanged(sizes[selectedSize]);
              if (mounted) {
                setState(() {});
              }
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(30),
                color: selectedSize == index
                    ? AppColors.primaryColor
                    : Colors.white,
              ),
              child: Text(
                sizes[index],
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ),
          );
        },
      ),
    );
  }
}
