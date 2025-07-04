import 'package:get/get.dart';
import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/roles/customer/home/order/confirm/controller.dart';
import 'package:kichikichi/roles/customer/home/order/confirm/success/page.dart';

class CustomerHomeConfirmPage extends StatelessWidget {
  const CustomerHomeConfirmPage({super.key, required this.data});

  final Map data;

  @override
  Widget build(BuildContext context) {
    final notAllowBack = data['notAllowBack'];
    final orderData = (data['orderData'] as Map<String, dynamic>);
    // clearLocal(
    //   'order',
    // );
    return GetBuilder<CustomerHomeOrderConfirmController>(
        init: CustomerHomeOrderConfirmController(context,
            oderStartData: orderData, tableData: data['table']),
        builder: (controller) {
          return BaseScaffold<CustomerHomeOrderConfirmController>(
            canPop: notAllowBack ?? true,
            (p0) => Scaffold(
              appBar: Header(
                title: data['table']['table_label'].toString() ?? 'Ban so 1',
                showBackButton: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: orderData.keys
                            .map(
                              (e) => item(orderData[e], 1),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      AppTextStyles.heading2.text('Tổng thanh toán: '),
                      AppTextStyles.heading2.text('${data["total"]} vnd')
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 450.ms)
                      .slide(begin: const Offset(0, 3), duration: 450.ms),
                  Row(
                    children: [
                      Expanded(
                        child: RoundedButton.text(
                          'Gọi món',
                          () {
                            controller.order(onSuccess: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomerHomeOrderConfirmSuccessPage(),
                                ),
                                // (route) => false,
                              );
                            }, onFail: () {
                              ScaffoldMessenger.of(context).sendMessage(
                                  'Vui lòng kiểm tra lại kết nối mạng');
                            });
                          },
                        )
                            .animate()
                            .fadeIn(duration: 450.ms)
                            .slide(begin: const Offset(0, 3), duration: 450.ms),
                      )
                    ],
                  ),
                ],
              ).padAll(16),
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
            m['image'] is List ? m['image'][0] : m['image'],
            height: 50,
            width: 50,
          ),
        ),
        AppSize.paddingSmall.w,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextStyles.bodyText.text(m['name']),
              AppTextStyles.bodyText.text(m['price'].toString()),
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
