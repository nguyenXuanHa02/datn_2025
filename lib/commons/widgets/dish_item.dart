import 'package:kichikichi/core/imports/imports.dart';

class DishItem extends StatelessWidget {
  const DishItem({super.key, required this.data});

  final Map data;

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
              flex: 7,
              child: ImageViewer(
                data['image'],
              ),
            ),
            Flexible(
              flex: 3,
              child: Column(
                children: [
                  AppSize.paddingSmall.h,
                  AppTextStyles.bodyText
                      .text(data['title'])
                      .paddingSymmetric(h: AppSize.paddingSmall),
                  AppSize.paddingSmall.h,
                  if (data['price'] is String) ...[
                    AppTextStyles.bodyText
                        .text(data['price'])
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
}
