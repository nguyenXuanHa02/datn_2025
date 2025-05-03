import 'package:kichikichi/core/imports/imports.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CustomerPreorderCard extends StatelessWidget {
  final String name;

  final String phone;
  final String pickupTime;

  final String count;

  final String code;

  const CustomerPreorderCard(
      {super.key,
      required this.name,
      required this.phone,
      required this.pickupTime,
      required this.count,
      required this.code});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Mã bàn $code',
                //   style: AppTextStyles.heading2,
                // ),
                // AppSize.h8,
                Text(
                  'Người đặt $name',
                  style: AppTextStyles.heading3,
                ),
                AppSize.h8,
                Text(
                  'SDT: $phone',
                  style: AppTextStyles.heading3,
                ),
                AppSize.h8,
                Text(
                  'Thời gian: $pickupTime',
                  style: AppTextStyles.heading3,
                ),
                AppSize.h8,
                Text(
                  'Số người: $count',
                  style: AppTextStyles.heading3,
                ),
              ],
            ),
          ),
          Center(
            child: QrImageView(
              data: code,
              version: QrVersions.auto,
              size: 100.0,
            ),
          ),
        ],
      ).cardPad(),
    ).fadeIn();
  }
}
