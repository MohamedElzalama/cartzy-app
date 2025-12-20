import 'package:flutter/material.dart';

class EmptyFavoriteWidget extends StatelessWidget {
  const EmptyFavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 30,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        Icon(
          Icons.favorite_border_outlined,
          size: 150,
          color: Colors.grey,
        ),
        Text(
          "No favorite found",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Color(0xff5C5C5C),
          ),
        )
      ],
    );
  }
}
