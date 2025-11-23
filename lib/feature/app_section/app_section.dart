import 'package:cartzy_app/feature/cart/view/cart_screen.dart';
import 'package:cartzy_app/feature/favorite/data/repo/repository/favorite_repository_impl.dart';
import 'package:cartzy_app/feature/favorite/presentation/view/favorite_screen.dart';
import 'package:cartzy_app/feature/favorite/presentation/view_model/favorite_cubit.dart';
import 'package:cartzy_app/feature/home/domain/use_case/category_use_case.dart';
import 'package:cartzy_app/feature/home/domain/use_case/product_use_case.dart';
import 'package:cartzy_app/feature/home/presentation/view/home_screen.dart';
import 'package:cartzy_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:cartzy_app/feature/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AppSection extends StatefulWidget {
  static const String routeName = 'InitApp';
  const AppSection({super.key});

  @override
  State<AppSection> createState() => _AppSectionState();
}

class _AppSectionState extends State<AppSection> {
  List<Widget> widgetList = [
    BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        categoryUseCase: injectCategoryUseCase(),
        productUseCase: injectProductUseCase(),
      )
        ..getCategories()
        ..getProducts(null),
      child: HomeScreen(),
    ),
    CartScreen(),
    BlocProvider<FavoriteCubit>(
      create: (context) =>
          FavoriteCubit(injectFavoriteRepository())..getFavorites(),
      child: FavoriteScreen(),
    ),
    ProfileScreen(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 13,
        selectedFontSize: 14,
        selectedItemColor: const Color(0xff212121),
        unselectedItemColor: const Color(0xff5C5C5C),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Color(0xff212121),
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Color(0xff5C5C5C),
        ),
        currentIndex: index,
        onTap: (selectedIndex) {
          index = selectedIndex;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-home.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              color: index == 0 ? Color(0xff212121) : Color(0xff5C5C5C),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-cart.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              color: index == 1 ? Color(0xff212121) : Color(0xff5C5C5C),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-favourite.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              color: index == 2 ? Color(0xff212121) : Color(0xff5C5C5C),
            ),
            label: ' Favorite',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-profile.svg',
              height: 23,
              width: 23,
              fit: BoxFit.cover,
              color: index == 3 ? Color(0xff212121) : Color(0xff5C5C5C),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: widgetList[index]),
    );
  }
}
