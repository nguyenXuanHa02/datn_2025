import 'dart:convert';

import 'package:kichikichi/commons/bloc/baseController.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/roles/customer/home/order/confirm/page.dart';
import 'package:kichikichi/roles/customer/home/order/controller.dart';

class CustomerHomeOrder extends StatefulWidget {
  const CustomerHomeOrder(this.data, {super.key});

  final Map? data;

  @override
  State<CustomerHomeOrder> createState() => _CustomerHomeOrderState();
}

class _CustomerHomeOrderState extends State<CustomerHomeOrder> {
  Map<String, int> counter = {};
  Map<String, dynamic> order = {};
  int money = 0;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold<HomeOrderController>(
      init: HomeOrderController(),
      (p0) {
        return Scaffold(
            appBar: Header(
              backToHome: true,
              title: "${widget.data?['table_label']}",
            ),
            body: Column(
              children: [
                AppSize.paddingSmall.h,
                Expanded(
                  child: DishGridWithData(
                      // physics: NeverScrollableScrollPhysics(),
                      onCountChange: (item, count) {
                        if (item['id'] != null) {
                          try {
                            var gems = item;
                            gems['count'] = count.toString();
                            counter[item['id']] =
                                int.parse((item['price']).toString()) * count;
                            order[item['id']] = gems;
                            int temp = 0;
                            for (var element in counter.values) {
                              temp += element;
                            }
                            money = temp;
                            setState(() {});
                          } catch (e) {
                            print(counter);
                            print(e);
                          }
                        }
                      },
                      items: p0.items),
                ),
                AppSize.paddingSmall.h,
                RoundedButton.text(
                  "$money vnd",
                  () {},
                ).padSymmetric(h: 16).animate().fadeIn(duration: 300.ms).slide(
                      begin: const Offset(0, 2),
                      duration: 350.ms,
                    ),
                AppSize.paddingSmall.h,
                if (money > 0)
                  Builder(builder: (context) {
                    return Row(
                      children: [
                        Expanded(
                          child: RoundedButton.text(
                            'Tiếp tục',
                            () async {
                              final orderData = {
                                'table': widget.data,
                                'orderData': order,
                                'total': money
                              };
                              await saveLocal('order', jsonEncode(orderData));
                              print("saved");
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CustomerHomeConfirmPage(data: orderData),
                                ),
                                (route) => false,
                              );
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
            ));
      },
    );
  }
}
