import 'package:get/get.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/roles/customer/home/order/confirm/controller.dart';
import 'package:kichikichi/roles/customer/home/order/confirm/success/page.dart';

class CustomerHomeConfirmPage extends StatelessWidget {
  const CustomerHomeConfirmPage({super.key, required this.data});

  // table table_label table_code
  // orderData
  // total
  final Map data;

  @override
  Widget build(BuildContext context) {
    final orderData = (data['orderData'] as Map<int, dynamic>);

    return GetBuilder<CustomerHomeOrderConfirmController>(
        init: CustomerHomeOrderConfirmController(
            oderStartData: orderData, tableData: data['table']),
        builder: (controller) {
          return Scaffold(
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
                            (e) => item(orderData[e], e),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Row(
                  children: [
                    AppTextStyles.heading2.text('Total: '),
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
                          controller.order(
                              onSuccess: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CustomerHomeOrderConfirmSuccessPage(),
                                  ),
                                );
                              },
                              onFail: () {});
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
