import 'package:kichikichi/core/imports/imports.dart';

class BaseBanner extends StatelessWidget {
  const BaseBanner({super.key, required this.data});
  final Map data;
  @override
  Widget build(BuildContext context) {
    return AppSize.radiusSmall.roundedAll(
      SizedBox(
        height: 150,
        child: Container(
          color: Colors.green,
        ),
      ),
    );
  }
}
