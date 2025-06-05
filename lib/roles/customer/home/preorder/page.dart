import 'package:flutter_svg/flutter_svg.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/base_widget/formtextfield.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/core/styles/colors/app_colors.dart';
import 'package:kichikichi/roles/customer/home/preorder/controller.dart';
import 'package:kichikichi/roles/customer/home/preorder/widgets/card.dart';

class CustomerHomePreorder extends StatelessWidget {
  const CustomerHomePreorder({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold<CustomerHomePreorderController>(
      init: CustomerHomePreorderController(),
      (controller) {
        final start = Builder(builder: (context) {
          return Scaffold(
            appBar: const Header(title: 'Đặt bàn trước'),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppSize.h(8),
                          textFieldWith<CustomerHomePreorderController>('name',
                                  label: 'Tên người đặt')
                              .fadeIn(),
                          AppSize.h(8),
                          textFieldWith<CustomerHomePreorderController>('phone',
                                  keyType: TextInputType.phone,
                                  label: 'Số điện thoại')
                              .fadeIn(),
                          AppSize.h(8),
                          textFieldWith<CustomerHomePreorderController>('count',
                                  label: 'Số người')
                              .fadeIn(),
                          AppSize.h(8),
                          dateTimeSelect<CustomerHomePreorderController>(
                                  'pickupTime',
                                  willPickTime: true,
                                  label: 'Thời gian nhận bàn')
                              .fadeIn(),
                        ],
                      ),
                    ),
                  ),
                  if (controller.showing ==
                      CustomerHomePreorderControllerState.start) ...[
                    AppSize.h8,
                    RoundedButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        controller.preorder();
                      },
                      data: const {'title': 'Đặt bàn'},
                    ).fadeInSlideUp()
                  ],
                  if (controller.showing ==
                      CustomerHomePreorderControllerState.capnhat) ...[
                    AppSize.h8,
                    RoundedButton.text(
                      'Cập nhật',
                      () {
                        FocusScope.of(context).unfocus();
                        controller.saveChangePreorder();
                      },
                    ).fadeInSlideUp()
                  ]
                ],
              ).safePad(),
            ),
          );
        });
        final thanhcong = Builder(builder: (context) {
          return Scaffold(
            body: SafeArea(
                child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      AppSize.h16,
                      SvgPicture.asset(
                        'assets/svg/success.svg',
                        colorFilter: const ColorFilter.mode(
                            AppColors.success, BlendMode.srcIn),
                        width: 100,
                        height: 100,
                      ).fadeIn(fade: 600),
                      AppSize.h16,
                      const Text(
                        'Đặt bàn thành công',
                        style: AppTextStyles.heading1,
                      ),
                      CustomerPreorderCard(
                        name: controller.card['name'] ?? '',
                        phone: controller.card['phone'] ?? '',
                        code: controller.card['code'] ?? '',
                        count: controller.card['count'] ?? '',
                        pickupTime: controller.card['pickupTime'] ?? '',
                      ),
                    ],
                  ),
                ),
                RoundedButton.text('Cập nhật', () {
                  controller.capnhat();
                }),
                AppSize.h8,
                RoundedButton.text('Trở về trang chủ', () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RouteCons.start,
                    (route) => false,
                  );
                })
              ],
            ).safePad()),
          );
        });
        final chitiet = Builder(
          builder: (context) => Scaffold(
            appBar: const Header(
              title: 'Đơn đặt bàn trước',
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (controller.card.isNotEmpty)
                          CustomerPreorderCard(
                            name: controller.card['name'] ?? '',
                            phone: controller.card['phone'] ?? '',
                            code: controller.card['code'] ?? '',
                            count: controller.card['count'] ?? '',
                            pickupTime: controller.card['pickupTime'] ?? '',
                          ),
                        AppSize.paddingMedium.h,
                      ],
                    ),
                  ),
                ),
                RoundedButton.text('Hủy đặt bàn', () async {
                  final confirm = await showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Bạn có chắc chắn muốn hủy không?",
                          style: AppTextStyles.heading3,
                          textAlign: TextAlign.center,
                        ),
                        AppSize.h8,
                        RoundedButton.text(
                          'Hủy',
                          () => Navigator.pop(context, true),
                        ),
                      ],
                    ).safePad(),
                  );
                  if (confirm == true) {
                    controller.huyDatBan(
                      () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteCons.start,
                          (route) => false,
                        );
                      },
                    );
                  }
                }),
                AppSize.h8,
                RoundedButton.text('Cập nhật', () {
                  controller.capnhat();
                }),
              ],
            ).safePad(),
          ),
        );
        if (controller.showing ==
            CustomerHomePreorderControllerState.thanhcong) {
          return thanhcong;
        }
        if (controller.showing == CustomerHomePreorderControllerState.chitiet) {
          return chitiet;
        }
        return start;
      },
    );
  }
}
