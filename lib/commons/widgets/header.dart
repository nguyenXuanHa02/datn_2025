import 'package:flutter_svg/flutter_svg.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/core/styles/colors/app_colors.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton, centerTitle;
  final List<Widget>? actions;
  final bool backToHome;
  final Function()? onBackPress;
  const Header({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.backToHome = false,
    this.centerTitle = false,
    this.actions,
    this.onBackPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),

      leading: backToHome
          ? InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteCons.start,
                  (route) => false,
                );
              },
              child: SvgPicture.asset(
                'assets/svg/esc.svg',
                colorFilter: const ColorFilter.mode(
                    AppColors.onPrimary, BlendMode.srcIn),
              ),
            )
          : showBackButton
              ? IconButton(
                  onPressed: onBackPress ??
                      () {
                        Navigator.of(context).pop();
                      },
                  icon: const Icon(Icons.arrow_back))
              : const SizedBox.shrink(),
      centerTitle: centerTitle ?? true,
      // backgroundColor: App,
      // foregroundColor: Colors.black,
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
