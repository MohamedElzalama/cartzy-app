import 'package:cartzy_app/feature/favorite/data/model/response/favorite_model.dart';
import 'package:cartzy_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:cartzy_app/feature/favorite/presentation/widgets/empty_favorite_widget.dart';
import 'package:cartzy_app/feature/favorite/presentation/widgets/favorite_product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isLoading = false;
  late FavoriteCubit favoriteCubit;
  @override
  void initState() {
    super.initState();
    favoriteCubit = context.read<FavoriteCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
              if (state is FavoriteLoading) {
                isLoading = true;
              }
              if (state is FavoriteSuccess) {
                isLoading = false;
              }
              var favoriteList = favoriteCubit.favoriteList;
              if (favoriteList.isEmpty) {
                return const EmptyFavoriteWidget();
              }
              return Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 20,
                    childAspectRatio: 163 / 288,
                  ),
                  itemCount: favoriteList.length,
                  itemBuilder: (context, index) => Skeletonizer(
                    enabled: isLoading,
                    child: FavoriteProductItemWidget(
                      product: isLoading
                          ? FavoriteModel(
                              id: 0,
                              title: "Loading  Loading",
                              price: 0,
                              description:
                                  "Loading Loading LoadingLoadingLoading",
                              images: ["assets/image/empty_product.png"],
                            )
                          : favoriteList[index],
                      favoriteCubit: favoriteCubit,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
