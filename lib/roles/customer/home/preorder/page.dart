import 'package:kichikichi/core/imports/imports.dart';

class CustomerHomePreorder extends StatelessWidget {
  const CustomerHomePreorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AppTextStyles.heading2.text('chon mon an'),
          AppSize.paddingLarge.h,
          Container(
            height: 100,
            color: Colors.green,
            child: const Center(
              child: Text("hien thi loai nuoc da chon"),
            ),
          ).paddingSymmetric(h: AppSize.paddingMedium),
          AppSize.paddingLarge.h,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const DishGridWithData(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    items: [
                      {'title': 'nấm kim châm'},
                      {'title': 'sách bò'},
                      {'title': 'thịt bò nhật bản'},
                      {'title': 'nấm kim châm'},
                      {'title': 'sách bò'},
                      {'title': 'thịt bò nhật bản thịt bò nhật bản'},
                    ],
                  ).paddingSymmetric(h: AppSize.paddingMedium)
                ],
              ),
            ),
          ),
          Column(
            children: [
              RoundedButton(
                onTap: () {},
                data: {'title': '10000'},
              ),
              AppSize.paddingSmall.h,
              RoundedButton(
                onTap: () {},
                data: {'title': 'tiep tuc'},
              )
            ],
          ).padding(
            const EdgeInsets.only(
              left: AppSize.paddingMedium,
              right: AppSize.paddingMedium,
              bottom: AppSize.paddingMedium,
            ),
          )
        ],
      )),
    );
  }
}
