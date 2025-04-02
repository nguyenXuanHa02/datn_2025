import 'package:flutter_svg/flutter_svg.dart';
import 'package:kichikichi/core/imports/imports.dart';
import 'package:kichikichi/core/styles/colors/app_colors.dart';

BottomNavigationBarItem bottomNavigationBarItem(int index, String title,
        {String? svg, bool? isSelected}) =>
    BottomNavigationBarItem(
        icon: Column(
          children: [
            (svg != null)
                ? SvgPicture.asset(svg,
                    colorFilter: ColorFilter.mode(
                        (isSelected ?? false)
                            ? AppColors.primary
                            : AppColors.textHint,
                        BlendMode.srcIn))
                : Icon(Icons.home,
                    color: (isSelected ?? false)
                        ? AppColors.primary
                        : AppColors.textHint),
            AppSize.paddingSmall.h,
            AppTextStyles.smallText
                .copyWith(
                    color: (isSelected ?? false)
                        ? AppColors.primary
                        : AppColors.textHint)
                .text(title),
          ],
        ),
        label: title);
