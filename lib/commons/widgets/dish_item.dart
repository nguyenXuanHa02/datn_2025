import 'package:flutter_svg/flutter_svg.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/core/styles/colors/app_colors.dart';

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
        color: AppColors.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  (havePrice && showCountChange)
                      ? Flexible(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ImageViewer(
                                widget.data['image'][0],
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Container(
                                    color: AppColors.card.withOpacity(0.45),
                                    child: AppTextStyles.heading2
                                        .text(
                                          widget.data['name'],
                                          maxLines: 2,
                                        )
                                        .padSymmetric(h: AppSize.paddingSmall),
                                  ))
                            ],
                          ),
                        )
                      : Expanded(
                          child: ImageViewer(widget.data['image'][0],
                              fit: BoxFit.fitWidth),
                        ),
                ],
              ),
            ),
            Flexible(
              flex: havePrice || showCountChange ? 4 : 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (havePrice && showCountChange)
                    ? [
                        Flexible(
                          flex: 4,
                          child: AppTextStyles.heading3
                              .text('${widget.data['price']} vnd')
                              .padSymmetric(
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
                            .text(widget.data['name'])
                            .padSymmetric(h: AppSize.paddingSmall),
                        AppSize.paddingSmall.h,
                        if (widget.data['price'] is String) ...[
                          AppTextStyles.bodyText
                              .text('${widget.data['price']} vnd')
                              .padSymmetric(h: AppSize.paddingSmall),
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
                icon: SvgPicture.asset('assets/svg/plus.svg'))),
        AppTextStyles.heading2.text('$count').padAll(4),
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
                icon: SvgPicture.asset('assets/svg/minus.svg')))
      ],
    );
  }
}
