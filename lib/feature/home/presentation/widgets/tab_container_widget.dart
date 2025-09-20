import 'package:animate_do/animate_do.dart';
import 'package:cartzy_app/feature/home/domain/entities/category_entity.dart';
import 'package:cartzy_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:cartzy_app/feature/home/presentation/widgets/tab_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabContainerWidget extends StatefulWidget {
  const TabContainerWidget({
    super.key,
    required this.categories,
  });
  final List<CategoryEntity> categories;

  @override
  State<TabContainerWidget> createState() => _TabContainerWidgetState();
}

class _TabContainerWidgetState extends State<TabContainerWidget> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocListener<HomeCubit, HomeState>(
            listener: (context, state) {},
            child: TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.zero,
              onTap: (int index) async {
                currentIndex = index;
                setState(() {});
                int? id =
                    (currentIndex == 0) ? null : widget.categories[index].id;
                await context.read<HomeCubit>().getProducts(id);
              },
              tabs: widget.categories
                  .map(
                    (source) => FadeIn(
                      duration: const Duration(milliseconds: 700),
                      child: TabItemWidget(
                        category: source,
                        isSelected:
                            widget.categories.indexOf(source) == currentIndex,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
