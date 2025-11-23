// ignore_for_file: must_be_immutable

import 'package:cartzy_app/core/constants/app_assets.dart';
import 'package:cartzy_app/feature/home/domain/entities/product_entity.dart';
import 'package:cartzy_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:cartzy_app/feature/home/presentation/widgets/empty_product_list_widget.dart';
import 'package:cartzy_app/feature/home/presentation/widgets/product_item_widget.dart';
import 'package:cartzy_app/feature/home/presentation/widgets/tab_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static const String routeName = 'HomeScreen';
  bool isLoadingProduct = false;
  bool isLoadingCategory = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text.rich(
            TextSpan(
              text: 'Hi !,\n',
              style: TextStyle(
                color: Color(0xff212121),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: 'Let’s start your shopping',
                  style: TextStyle(
                    color: Color(0xff212121),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Categories",
            style: TextStyle(
              color: Color(0xff212121),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          //! getCategories
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is CategoryFailure) {
                isLoadingCategory = false;
                return Text(state.message);
              }
              if (state is CategoryLoading) {
                isLoadingCategory = true;
              }
              if (state is CategorySuccess) {
                isLoadingCategory = false;
              }
              var categories = context.read<HomeCubit>().categories;
              return Skeletonizer(
                enabled: isLoadingCategory,
                child: TabContainerWidget(
                    categories: isLoadingCategory
                        ? AppAssets.dummyCategories
                        : categories),
              );
            },
          ),
          SizedBox(height: 16),
          //! getProducts
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is ProductFailure) {
                return Text(state.message);
              }
              if (state is ProductLoading) {
                isLoadingProduct = true;
              }
              if (state is ProductSuccess) {
                isLoadingProduct = false;
              }
              List<ProductEntity> products = context.read<HomeCubit>().products;
              if (products.isEmpty && !isLoadingProduct) {
                return EmptyProductListWidget();
              }
              return Expanded(
                child: GridView.builder(
                  key: ValueKey(products.map((p) => p.id).join('-')),
                  itemCount: isLoadingProduct ? 10 : products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 20,
                    childAspectRatio: 163 / 288,
                  ),
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                        enabled: isLoadingProduct,
                        child: ProductItemWidget(
                            product: isLoadingProduct
                                ? ProductEntity(
                                    id: 0,
                                    title: 'dymmy',
                                    slug: 'dymmy',
                                    price: 100,
                                    description: 'dymmy dymmy   dymmy',
                                    images: [AppAssets.dummyNetworkImage],
                                  )
                                : products[index]));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
