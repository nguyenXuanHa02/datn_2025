import 'package:kichikichi/core/imports/imports.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSize.radiusSmall.roundedAll(
      SizedBox(
        height: 100,
        child: Container(
          color: Colors.green,
        ),
      ),
    );
  }
}
