import 'package:flutter/material.dart';

class Categorieswidget extends StatefulWidget {
  final List<String> categories;
  final Function(int index)? onSelected;

  const Categorieswidget({
    super.key,
    required this.categories,
    this.onSelected,
  });

  @override
  State<Categorieswidget> createState() => _CategorieswidgetState();
}

class _CategorieswidgetState extends State<Categorieswidget> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      primary: false,
      child: Row(
        children: List.generate(widget.categories.length, (index) {
          final bool isSelected = index == _selected;
          return GestureDetector(
            onTap: () {
              setState(() => _selected = index);
              widget.onSelected?.call(index);
            },
            child: Container(
              margin: EdgeInsets.only(
                right: index == widget.categories.length - 1 ? 0 : 10,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF5B33B5) : Color(0xFFE6DAFE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.categories[index],
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Color(0xFF5B33B5),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
