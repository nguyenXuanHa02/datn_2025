import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/base_widget/banner.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/core/styles/colors/app_colors.dart';
import 'package:kichikichi/roles/customer/home/controller.dart';
import 'package:kichikichi/roles/customer/home/preorder/widgets/card.dart';

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final check = Get.isRegistered<CustomerHomeController>();
    if (check == false) {
      Get.put(CustomerHomeController());
    } else {
      Get.find<CustomerHomeController>().loadCard();
    }
    return GetBuilder<CustomerHomeController>(
        init: CustomerHomeController(),
        builder: (_) {
          return BaseScaffold<CustomerHomeController>(
            (controller) {
              return Scaffold(
                backgroundColor: AppColors.background,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  leadingWidth: 200,
                  leading: SvgPicture.asset(
                    'assets/svg/kichi.svg',
                    height: 60,
                    fit: BoxFit.fitHeight,
                    colorFilter: const ColorFilter.mode(
                        AppColors.primary, BlendMode.srcIn),
                  ),
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSize.paddingSmall),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BaseBanner(
                            data: {},
                          ),
                          // AppSize.paddingMedium.h,
                          // const NotificationItem(),
                          AppSize.paddingMedium.h,
                          if (controller.card.isNotEmpty)
                            CustomerPreorderCard(
                              name: controller.card['name'] ?? '',
                              phone: controller.card['phone'] ?? '',
                              code: controller.card['code'] ?? '',
                              count: controller.card['count'] ?? '',
                              pickupTime: controller.card['pickupTime'] ?? '',
                            ),
                          AppSize.paddingSmall.h,
                          Row(
                            children: [
                              Expanded(
                                  child: MIconButton(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            RouteCons.customerHomeScan);
                                      },
                                      data: const {
                                    'title': 'Gọi món',
                                    'background': Colors.orange,
                                    'image': 'assets/svg/img_1.png'
                                  })),
                              AppSize.paddingMedium.w,
                              Expanded(
                                  child: MIconButton(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            RouteCons.customerHomePreorder);
                                      },
                                      data: const {
                                    'title': 'Đặt bàn',
                                    'image': 'assets/svg/img.png'
                                  })),
                            ],
                          ).padAll(AppSize.paddingSmall),
                          AppSize.paddingLarge.h,
                          AppSize.paddingLarge.h,
                          AppTextStyles.heading2.text('Món ăn nổi bật'),
                          AppSize.paddingSmall.h,
                          (controller.items.isNotEmpty)
                              ? DishGridWithData(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  items: controller.items,
                                )
                              : const Center(child: CircularProgressIndicator())
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
