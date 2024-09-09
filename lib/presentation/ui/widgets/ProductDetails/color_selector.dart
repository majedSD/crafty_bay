import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({super.key, required this.colors, required this.onChanged});
  final String colors;
  final Function(String)onChanged;
  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
   int selectedColor = 0;
  late List<String>colors=widget.colors.split(',');
  late List<Color>colorList=colors.map((color){
       if(color=='Red'){
         return Colors.red;
       }else if(color=='White'){
         return Colors.white;
       }else{
         return Colors.greenAccent;
       }
  }).toList();
  @override
  void initState() {
    super.initState();
    widget.onChanged(colors[0]);
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 4,
        ),
        itemCount:colorList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              selectedColor = index;
              widget.onChanged(colors[selectedColor]);
              if (mounted) {
                setState(() {});
              }
            },
            borderRadius: BorderRadius.circular(16),
            child: CircleAvatar(
              backgroundColor: colorList[index],
              radius: 16,
              child: selectedColor == index
                  ? const Icon(
                      Icons.done,
                      color: Colors.white,
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
