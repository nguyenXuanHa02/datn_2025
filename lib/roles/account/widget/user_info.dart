import 'package:kichikichi/core/imports/imports.dart';

class AccountUserInfo extends StatelessWidget {
  const AccountUserInfo({super.key, required this.user});
  final Map<String, dynamic> user;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(64),
            child: ImageViewer(
              user['image'],
              width: 64,
              height: 64,
            ),
          ),
          AppSize.w8,
          AppTextStyles.heading2.text(user['username']),
        ],
      ).cardPad(),
    );
  }
}
