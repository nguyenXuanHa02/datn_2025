import 'package:kichikichi/core/imports/imports.dart';

class CustomerHomeConfirmPage extends StatelessWidget {
  const CustomerHomeConfirmPage({super.key, required this.data});

  //table info, order info
  final Map data;

  @override
  Widget build(BuildContext context) {
    final prepare = (data['orderData'] as Map<int, dynamic>);
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
                children: prepare.keys
                    .map(
                      (e) => item(prepare[e]),
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
          ).paddingSymmetric(h: 16),
          Row(
            children: [
              Expanded(
                  child: FilledButton(onPressed: () {}, child: Text("Gọi món")))
            ],
          ).paddingSymmetric(h: 16),
        ],
      ),
    );
  }

  Widget item(Map m) {
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
    ).paddingSymmetric(h: 16, v: 8);
  }
}
