import 'package:get/get.dart';
import 'package:kichikichi/core/base_widget/formtextfield.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/roles/customer/home/preorder/controller.dart';

class CustomerHomePreorder extends StatelessWidget {
  const CustomerHomePreorder({super.key});

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusManager();
    return GetBuilder<CustomerHomePreorderController>(
        init: CustomerHomePreorderController(),
        builder: (controller) {
          return GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: Scaffold(
              appBar: const Header(title: 'Đặt bàn trước'),
              body: SafeArea(
                  child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        AppSize.h(8),
                        textFieldWith<CustomerHomePreorderController>('name',
                            label: 'Tên người đặt'),
                        AppSize.h(8),
                        textFieldWith<CustomerHomePreorderController>('phone',
                            keyType: TextInputType.phone,
                            label: 'Số điện thoại'),
                        AppSize.h(8),
                        textFieldWith<CustomerHomePreorderController>('count',
                            label: 'Số người'),
                        AppSize.h(8),
                        dateTimeSelect<CustomerHomePreorderController>(
                            'pickupTime',
                            willPickTime: true,
                            label: 'Thời gian nhận bàn'),
                      ],
                    ).padding(
                      const EdgeInsets.only(
                        left: AppSize.paddingMedium,
                        right: AppSize.paddingMedium,
                      ),
                    ),
                  ),
                  RoundedButton(
                    onTap: () {
                      controller.validate();
                    },
                    data: const {'title': 'Đặt bàn'},
                  ).padding(
                    const EdgeInsets.only(
                      left: AppSize.paddingMedium,
                      right: AppSize.paddingMedium,
                      bottom: AppSize.paddingMedium,
                    ),
                  )
                ],
              )),
            ),
          );
        });
  }
}
