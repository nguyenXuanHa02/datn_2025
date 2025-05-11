import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/core/styles/colors/app_colors.dart';

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
        child: Stack(
          children: [
            if (data['image'] != null) Image.asset(data['image']),
            Center(
                child: Text(
              data['title'] ?? '',
              style:
                  AppTextStyles.heading1.copyWith(color: AppColors.onPrimary),
            )),
          ],
        ),
      ),
    ));
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, required this.onTap, required this.data});

  RoundedButton.text(String text, this.onTap, {super.key})
      : data = {'title': text};
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
