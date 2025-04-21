import 'package:kichikichi/core/imports/imports.dart';

class CustomerHomeOrder extends StatefulWidget {
  const CustomerHomeOrder(this.data, {super.key});

  final Map? data;

  @override
  State<CustomerHomeOrder> createState() => _CustomerHomeOrderState();
}

class _CustomerHomeOrderState extends State<CustomerHomeOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(
          backToHome: true,
          title: "${widget.data?['table_label']}",
        ),
        body: Column(
          children: [
            Expanded(
              child: const DishGridWithData(
                // physics: NeverScrollableScrollPhysics(),
                items: [
                  {'title': 'nấm kim châm'},
                  {'title': 'sách bò'},
                  {'title': 'thịt bò nhật bản'},
                  {'title': 'nấm kim châm'},
                  {'title': 'sách bò'},
                  {'title': 'thịt bò nhật bản thịt bò nhật bản'},
                ],
              ),
            ),
            AppSize.paddingSmall.h,
            Row(
              children: [
                Expanded(
                    child: FilledButton(onPressed: () {}, child: Text("data")))
              ],
            ).paddingSymmetric(h: 16),
            AppSize.paddingSmall.h,
            Row(
              children: [
                Expanded(
                    child: FilledButton(
                        onPressed: () {}, child: const Text("Tiếp tục")))
              ],
            ).paddingSymmetric(h: 16),
            AppSize.paddingSmall.h,
          ],
        ));
  }
}
