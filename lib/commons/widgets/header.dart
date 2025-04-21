import 'package:flutter_svg/flutter_svg.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/core/styles/colors/app_colors.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton, centerTitle;
  final List<Widget>? actions;
  final bool backToHome;
  const Header({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.backToHome = false,
    this.centerTitle = false,
    this.actions,
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
          : IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
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
