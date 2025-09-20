import 'package:cartzy_app/feature/favorite/view_model/favorite_cubit.dart';
import 'package:cartzy_app/feature/favorite/widgets/empty_favorite_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Favorites",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ],
        ),
        BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteError) {}
            if (state is FavoriteLoading) {}
            return const EmptyFavoriteWidget();
          },
        )
      ],
    );
  }
}

        // EmptyFavoriteWidget()