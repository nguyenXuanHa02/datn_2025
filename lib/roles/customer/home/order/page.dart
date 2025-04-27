import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/roles/customer/home/order/confirm/page.dart';

class CustomerHomeOrder extends StatefulWidget {
  const CustomerHomeOrder(this.data, {super.key});

  final Map? data;

  @override
  State<CustomerHomeOrder> createState() => _CustomerHomeOrderState();
}

class _CustomerHomeOrderState extends State<CustomerHomeOrder> {
  Map<int, int> counter = {};
  Map<int, dynamic> order = {};
  int money = 0;

  @override
  Widget build(BuildContext context) {
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
                    var gems = item;
                    gems['count'] = count;
                    counter[item['id']] = int.parse(item['price']) * count;
                    order[item['id']] = gems;
                    int temp = 0;
                    for (var element in counter.values) {
                      temp += element;
                    }
                    money = temp;
                    setState(() {});
                  }
                },
                items: [
                  {
                    'id': 1,
                    'title': 'nấm kim châm vào chim',
                    'price': '100000'
                  },
                  {'id': 2, 'title': 'sách bò', 'price': '100000'},
                  {'id': 3, 'title': 'thịt bò nhật bản', 'price': '100000'},
                  {'id': 4, 'title': 'nấm kim châm', 'price': '100000'},
                  {'id': 5, 'title': 'sách bò', 'price': '100000'},
                  {
                    'id': 6,
                    'title': 'thịt bò nhật bản thịt bò nhật bản',
                    'price': '100000'
                  },
                ],
              ),
            ),
            AppSize.paddingSmall.h,
            Row(
              children: [
                Expanded(
                    child:
                        FilledButton(onPressed: () {}, child: Text("$money")))
              ],
            ).paddingSymmetric(h: 16),
            AppSize.paddingSmall.h,
            Row(
              children: [
                Expanded(
                    child: FilledButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CustomerHomeConfirmPage(
                                data: {
                                  'table': widget.data,
                                  'orderData': order,
                                  'total': money
                                }),
                          ));
                        },
                        child: const Text("Tiếp tục")))
              ],
            ).paddingSymmetric(h: 16),
            AppSize.paddingSmall.h,
          ],
        ));
  }
}
