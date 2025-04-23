import 'package:kichikichi/core/imports/imports.dart';

class DishItem extends StatefulWidget {
  const DishItem({super.key, required this.data, this.onCountChange});
  final Function(Map, int)? onCountChange;
  final Map data;

  @override
  State<DishItem> createState() => _DishItemState();
}

class _DishItemState extends State<DishItem> {
  late final bool showCountChange;
  late final bool havePrice;
  late int count;
  @override
  void initState() {
    showCountChange = (widget.onCountChange != null);
    havePrice = widget.data['price'] != null;
    if (showCountChange) count = 0;
    super.initState();
  }

  // final
  @override
  Widget build(BuildContext context) {
    return AppSize.radiusMedium.roundedAll(
      Container(
        color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 6,
              child: (havePrice && showCountChange)
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        ImageViewer(
                          widget.data['image'],
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            child: AppTextStyles.heading2
                                .text(widget.data['title'], maxLines: 2)
                                .paddingSymmetric(h: AppSize.paddingSmall))
                      ],
                    )
                  : ImageViewer(
                      widget.data['image'],
                    ),
            ),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (havePrice && showCountChange)
                    ? [
                        Flexible(
                          flex: 4,
                          child: AppTextStyles.heading2
                              .text(widget.data['price'])
                              .paddingSymmetric(
                                h: AppSize.paddingSmall,
                                v: AppSize.paddingSmall,
                              ),
                        ),
                        Flexible(
                          flex: 6,
                          child: countWidget(),
                        )
                      ]
                    : [
                        AppSize.paddingSmall.h,
                        AppTextStyles.bodyText
                            .text(widget.data['title'])
                            .paddingSymmetric(h: AppSize.paddingSmall),
                        AppSize.paddingSmall.h,
                        if (widget.data['price'] is String) ...[
                          AppTextStyles.bodyText
                              .text(widget.data['price'])
                              .paddingSymmetric(h: AppSize.paddingSmall),
                          AppSize.paddingSmall.h,
                        ]
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget countWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: IconButton(
                onPressed: () {
                  if (count < 40) {
                    setState(() {
                      count++;
                      widget.onCountChange!(widget.data, count);
                    });
                  }
                },
                icon: const Icon(Icons.add))),
        AppTextStyles.heading2.text('$count').paddingAll(4),
        Expanded(
            child: IconButton(
                onPressed: () {
                  if (count > 0) {
                    setState(() {
                      count--;
                      widget.onCountChange!(widget.data, count);
                    });
                  }
                },
                icon: const Icon(Icons.minimize_rounded)))
      ],
    );
  }
}
