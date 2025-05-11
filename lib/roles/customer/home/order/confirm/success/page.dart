import 'package:flutter_svg/svg.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/core/styles/colors/app_colors.dart';
import 'package:kichikichi/roles/customer/home/order/confirm/controller.dart';
import 'package:kichikichi/roles/customer/home/order/confirm/success/webview.dart';

class CustomerHomeOrderConfirmSuccessPage extends StatelessWidget {
  const CustomerHomeOrderConfirmSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold<CustomerHomeOrderConfirmController>(showLoading: true,
        (controller) {
      print(controller.showing.name);
      final onStart = Builder(builder: (context) {
        return Column(
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
                ).animate().fadeIn(duration: 800.ms),
                AppSize.h16,
                const Text(
                  'Gọi món thành công',
                  style: AppTextStyles.heading1,
                )
                    .animate()
                    .slide(begin: const Offset(0, 3))
                    .fadeIn(duration: 600.ms),
                const Text(
                  'Đơn hàng của bạn đã được giao cho bếp chế biến',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading3,
                )
                    .animate()
                    .slide(begin: const Offset(0, 3))
                    .fadeIn(duration: 600.ms),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: (controller.oderStartData.keys)
                          .map(
                            (e) => item(controller.oderStartData[e], e),
                          )
                          .toList(),
                    ),
                  ),
                )
              ],
            )),
            RoundedButton.text('Gọi thêm món', () {
              controller.showing =
                  CustomerHomeOrderConfirmState.goiThemMonStart;
              controller.update();
            }).animate().slide(
                  begin: const Offset(2, 0),
                  duration: 350.ms,
                ),
            AppSize.h(8),
            RoundedButton.text('Thanh toán', () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RoundedButton.text('Thanh toán trực tuyến', () {
                      controller.thanhToan(onSuccess: () {}, onFail: () {});
                      Navigator.pop(context);
                    }).padAll(8).animate().slide(
                          begin: const Offset(2, 0),
                          duration: 350.ms,
                        ),
                    RoundedButton.text('Thanh toán bằng tiền mặt', () {
                      controller.thanhToan(onSuccess: () {}, onFail: () {});
                      Navigator.pop(context);
                    }).padAll(8).animate().slide(
                          begin: const Offset(2, 0),
                          duration: 350.ms,
                        ),
                  ],
                ),
              );
            }).animate().slide(
                  begin: const Offset(-2, 0),
                  end: const Offset(0, 0),
                  duration: 350.ms,
                )
          ],
        ).padAll(16);
      });
      final thanhtoanthanhcong = Builder(builder: (context) {
        return Scaffold(
          body: Column(
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
                  ).animate().fadeIn(duration: 800.ms),
                  AppSize.h16,
                  const Text(
                    'Thanh toán thành công',
                    style: AppTextStyles.heading1,
                  )
                      .animate()
                      .slide(begin: const Offset(0, 3))
                      .fadeIn(duration: 600.ms),
                  Text(
                    'Đã thanh toán thành công ${controller.paid}vnd Cảm ơn quý khách đã sử dụng dịch vụ tại kichi kichi',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading3,
                  )
                      .animate()
                      .slide(begin: const Offset(0, 3))
                      .fadeIn(duration: 600.ms),
                ],
              )),
              RoundedButton.text('Về trang chủ', () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteCons.start,
                  (route) => false,
                );
              }).animate().slide(
                    begin: const Offset(2, 0),
                    duration: 350.ms,
                  ),
            ],
          ).padAll(16),
        );
      });
      final goithemmon = Builder(
        builder: (context) {
          return Scaffold(
            appBar: Header(
              onBackPress: () {
                controller
                  ..showing = CustomerHomeOrderConfirmState.start
                  ..money = 0
                  ..orderMore = {}
                  ..update();
              },
              title: 'Hủy',
              showBackButton: true,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  AppSize.paddingSmall.h,
                  Expanded(
                    child: DishGridWithData(
                      // physics: NeverScrollableScrollPhysics(),
                      onCountChange: (item, count) {
                        if (item['id'] != null) {
                          var gems = item;
                          gems['count'] = count;
                          // controller.counter[item['id']] =
                          //     int.parse(item['price']) * count;
                          controller.orderMore[item['id']] = gems;
                          int temp = 0;
                          for (var element in controller.orderMore.values) {
                            temp += int.parse(element['price']) *
                                element['count'] as int;
                          }
                          controller.money = temp;
                          controller.update();
                        }
                      },
                      items: controller.items,
                    ),
                  ),
                  AppSize.paddingSmall.h,
                  RoundedButton.text(
                    "${controller.money} vnd",
                    () {},
                  )
                      .padSymmetric(h: 16)
                      .animate()
                      .fadeIn(duration: 300.ms)
                      .slide(
                        begin: const Offset(0, 2),
                        duration: 350.ms,
                      ),
                  AppSize.paddingSmall.h,
                  if (controller.money > 0)
                    Builder(builder: (context) {
                      return Row(
                        children: [
                          Expanded(
                            child: RoundedButton.text(
                              'Tiếp tục',
                              () {
                                controller
                                  ..showing = CustomerHomeOrderConfirmState
                                      .goiThemMonEnd
                                  ..update();
                              },
                            ),
                          )
                        ],
                      )
                          .padSymmetric(h: 16)
                          .animate()
                          .fadeIn(duration: 300.ms)
                          .slide(
                            begin: const Offset(0, 2),
                            duration: 250.ms,
                          );
                    }),
                  AppSize.paddingSmall.h,
                ],
              ),
            ),
          );
        },
      );
      final goithemmonEnd = Builder(
        builder: (context) => Scaffold(
          appBar: Header(
            onBackPress: () {
              controller
                ..showing = CustomerHomeOrderConfirmState.start
                ..money = 0
                ..orderMore = {}
                ..update();
            },
            title: 'Hủy',
            showBackButton: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: (controller.orderMore.keys)
                          .map(
                            (e) => item(controller.orderMore[e], e),
                          )
                          .toList(),
                    ),
                  ),
                ),
                RoundedButton.text(
                  'Hoàn tất gọi thêm',
                  () {
                    controller.orderMoreStart();
                  },
                ).animate().fadeIn(duration: 300.ms).slide(
                      begin: const Offset(0, 2),
                      duration: 350.ms,
                    )
              ],
            ).padAll(16),
          ),
        ),
      );
      final thanhToanThatBai = Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      AppSize.h16,
                      SvgPicture.asset(
                        'assets/svg/fail.svg',
                        colorFilter: const ColorFilter.mode(
                            AppColors.error, BlendMode.srcIn),
                        width: 100,
                        height: 100,
                      ).animate().fadeIn(duration: 800.ms),
                      AppSize.h16,
                      const Text(
                        'Thanh toán thất bại',
                        style: AppTextStyles.heading1,
                      )
                          .animate()
                          .slide(begin: const Offset(0, 3))
                          .fadeIn(duration: 600.ms),
                      const Text(
                        'Quý khách vui lòng kiểm tra kết nối và thực hiện lại giao dịch, hoặc liên hệ nhân viên để được hỗ trợ kịp thigh',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.heading3,
                      )
                          .animate()
                          .slide(begin: const Offset(0, 3))
                          .fadeIn(duration: 600.ms),
                    ],
                  ),
                ),
                RoundedButton.text('Thực hiện lại giao dịch', () {
                  controller.thanhToan(
                    onSuccess: () {},
                    onFail: () {},
                  );
                }).animate().slide(
                      begin: const Offset(2, 0),
                      duration: 350.ms,
                    ),
                AppSize.h16,
                RoundedButton.text('Liên hệ nhân viên', () {
                  controller.contactStaff();
                }).animate().slide(
                      begin: const Offset(2, 0),
                      duration: 350.ms,
                    ),
              ],
            ).padAll(16),
          );
        },
      );
      if (controller.showing ==
          CustomerHomeOrderConfirmState.thanhToanThanhCong) {
        return Scaffold(
          body: SafeArea(
            child: thanhtoanthanhcong,
          ),
        );
      }
      if (controller.showing == CustomerHomeOrderConfirmState.thanhToanStart &&
          controller.paymentUrl.isNotEmpty) {
        return Builder(builder: (context) {
          return Webview(
            url: controller.paymentUrl,
            onSuccess: (Map map) {
              controller.onPayResult(map);
            },
          );
        });
      }
      final goiNhanVienThanhCong = Builder(
        builder: (context) => Scaffold(
          body: Column(
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
                  ).animate().fadeIn(duration: 800.ms),
                  AppSize.h16,
                  const Text(
                    'Thông báo đã được gửi đi!',
                    style: AppTextStyles.heading1,
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .slide(begin: const Offset(0, 3))
                      .fadeIn(duration: 600.ms),
                  const Text(
                    'Nhân viên sẽ đến hỗ trợ quý khách trong giây lát.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading3,
                  )
                      .animate()
                      .slide(begin: const Offset(0, 3))
                      .fadeIn(duration: 600.ms),
                ],
              )),
              RoundedButton.text('Về trang chủ', () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteCons.start,
                  (route) => false,
                );
              }).animate().slide(
                    begin: const Offset(2, 0),
                    duration: 350.ms,
                  ),
            ],
          ).padAll(16),
        ),
      );
      if (controller.showing ==
          CustomerHomeOrderConfirmState.thanhToanThatBai) {
        return thanhToanThatBai;
      }
      if (controller.showing == CustomerHomeOrderConfirmState.goiThemMonStart) {
        return goithemmon;
      }
      if (controller.showing == CustomerHomeOrderConfirmState.goiThemMonEnd) {
        return goithemmonEnd;
      }
      if (controller.showing ==
          CustomerHomeOrderConfirmState.goiNhanVienThanhCong) {
        return goiNhanVienThanhCong;
      }

      return Scaffold(
        body: SafeArea(
          child: onStart,
        ),
      );
    });
  }

  Widget item(Map m, int e) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ImageViewer(
            m['image'],
            height: 50,
            width: 50,
          ),
        ),
        AppSize.paddingSmall.w,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextStyles.bodyText.text(m['title']),
              AppTextStyles.bodyText.text(m['price']),
            ],
          ),
        ),
        Center(
          child: Text('x${m['count']}'),
        )
      ],
    ).padSymmetric(v: 8).animate().fadeIn(duration: 300.ms).slide(
          begin: const Offset(-2, 0),
          end: const Offset(0, 0),
          duration: 250.ms + 90.ms * e,
        );
  }
}
