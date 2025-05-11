import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kichikichi/commons/widgets/dish_item.dart';
import 'package:kichikichi/core/imports/imports.dart';

class BaseGridView extends ConsumerWidget {
  const BaseGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

class DishGridWithData extends StatelessWidget {
  const DishGridWithData(
      {super.key,
      required this.items,
      this.crossCount,
      this.shrinkWrap,
      this.onItemTap,
      this.physics,
      this.onCountChange});
  final Function(Map, int)? onCountChange;

  final List<Map> items;
  final int? crossCount;
  final bool? shrinkWrap;
  final Function(Map)? onItemTap;

  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    // return Wrap(
    //   children: List.generate(
    //     items.length,
    //     (index) => InkWell(
    //       onTap: () {
    //         if (onItemTap != null) {
    //           onItemTap!(items[index]);
    //         }
    //       },
    //       child: DishItem(
    //         data: items[index],
    //         onCountChange: onCountChange,
    //       ),
    //     ).animate().fadeIn(duration: 350.ms + 50.ms * index).slide(
    //         begin: (index % 2 == 0) ? const Offset(-2, 1) : const Offset(2, 1),
    //         duration: 350.ms),
    //   ),
    // );
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      physics: physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossCount ?? 2,
          crossAxisSpacing: AppSize.paddingSmall,
          mainAxisSpacing: AppSize.paddingSmall,
          childAspectRatio: 0.8),
      shrinkWrap: shrinkWrap ?? false,
      itemBuilder: (BuildContext context, int index) => InkWell(
        onTap: () {
          if (onItemTap != null) {
            onItemTap!(items[index]);
          }
        },
        child: DishItem(
          data: items[index],
          onCountChange: onCountChange,
        ),
      ).animate().fadeIn(duration: 350.ms + 50.ms * index).slide(
          begin: (index % 2 == 0) ? const Offset(-2, 1) : const Offset(2, 1),
          duration: 350.ms),
      itemCount: items.length,
    );
  }
}
