import 'package:kichikichi/core/imports/imports.dart';

class MIconButton extends StatelessWidget {
  const MIconButton({super.key, required this.onTap, required this.data});
  final Function() onTap;
  final Map data;
  @override
  Widget build(BuildContext context) {
    return AppSize.radiusSmall.roundedAll(InkWell(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue,
          ),
          child: Center(child: Text(data['title'] ?? '')),
        ),
      ),
    ));
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, required this.onTap, required this.data});
  final Function() onTap;
  final Map data;
  @override
  Widget build(BuildContext context) {
    return AppSize.radiusSmall.roundedAll(InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.blue,
        ),
        child:
            Center(child: AppTextStyles.buttonText.text(data['title'] ?? '')),
      ),
    ));
  }
}
