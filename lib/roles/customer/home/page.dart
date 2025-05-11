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
                              count: controller.card['code'] ?? '',
                              pickupTime: controller.card['pickupTime'] ?? '',
                            ),
                          AppSize.paddingMedium.h,
                          Row(
                            children: [
                              Expanded(
                                  child: MIconButton(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            RouteCons.customerHomeScan);
                                      },
                                      data: const {
                                    'title': 'Order',
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
                                    'title': 'Preorder',
                                    'image': 'assets/svg/img.png'
                                  })),
                            ],
                          ),
                          AppSize.paddingMedium.h,
                          AppTextStyles.heading2.text('mon_an_noi_bat'),
                          AppSize.paddingSmall.h,
                          (controller.items.isNotEmpty)
                              ? DishGridWithData(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  items: controller.items,
                                )
                              : const CircularProgressIndicator()
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
