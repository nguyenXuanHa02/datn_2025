import 'package:easy_localization/easy_localization.dart';
import 'package:kichikichi/core/base_widget/banner.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/core/styles/colors/app_colors.dart';

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.paddingSmall),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BaseBanner(
                  data: {},
                ),
                AppSize.paddingMedium.h,
                const NotificationItem(),
                AppSize.paddingMedium.h,
                Row(
                  children: [
                    Expanded(
                        child: MIconButton(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RouteCons.customerHomeScan);
                            },
                            data: {
                          'title': 'Order',
                          'background': Colors.orange
                        })),
                    AppSize.paddingMedium.w,
                    Expanded(
                        child: MIconButton(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RouteCons.customerHomePreorder);
                            },
                            data: const {'title': 'Preorder'})),
                  ],
                ),
                AppSize.paddingMedium.h,
                AppTextStyles.heading2
                    .text('mon_an_noi_bat'.tr(context: context)),
                AppSize.paddingSmall.h,
                const DishGridWithData(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  items: [
                    {'title': 'nấm kim châm'},
                    {'title': 'sách bò'},
                    {'title': 'thịt bò nhật bản'},
                    {'title': 'nấm kim châm'},
                    {'title': 'sách bò'},
                    {'title': 'thịt bò nhật bản thịt bò nhật bản'},
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
