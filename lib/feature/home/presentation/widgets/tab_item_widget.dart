import 'package:cartzy_app/feature/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget(
      {super.key, required this.category, this.isSelected = false});
  final CategoryEntity category;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xff212121) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xff212121),
          width: 1.5,
        ),
      ),
      child: Text(
        category.name,
        style: TextStyle(
          color: isSelected ? Colors.white : Color(0xff212121),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
