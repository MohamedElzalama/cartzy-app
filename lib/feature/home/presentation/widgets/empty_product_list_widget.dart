import 'package:cartzy_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class EmptyProductListWidget extends StatelessWidget {
  const EmptyProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.emptyProductListImage),
        Text(
          "No products found",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xff5C5C5C),
          ),
        )
      ],
    );
  }
}
