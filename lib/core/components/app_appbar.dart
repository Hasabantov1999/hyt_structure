import 'package:fast_structure/core/components/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_text.dart';


class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar(
      {super.key,
      required this.title,
      this.description,
      this.backPressed,
      this.suffixWidget,
      this.titleTag});
  final String title;
  final String? description;
  final VoidCallback? backPressed;
  final Widget? suffixWidget;
  final String? titleTag;
  @override
  Widget build(BuildContext context) {
    ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    return AppBar(
      centerTitle: false,
      toolbarHeight: description == null ? 50.h : 90.h,
      forceMaterialTransparency: true,
      automaticallyImplyLeading: false,
      titleSpacing: ((parentRoute?.impliesAppBarDismissal ?? false) ||
              backPressed != null)
          ? 0
          : 28.w,
      leading: ((parentRoute?.impliesAppBarDismissal ?? false) ||
              backPressed != null)
          ? AppBackButton(
              backPressed: backPressed,
            )
          : null,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (titleTag != null)
                Hero(
                  tag: titleTag!,
                  child: AppText(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF15203D),
                      fontSize: 18,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              else
                AppText(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF15203D),
                    fontSize: 18,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (description != null)
                AppText(
                  description!,
                  maxLines: 3,
                  width: 350.w,
                  style: const TextStyle(
                    color: Color(0xFF677294),
                    fontSize: 12,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                  ),
                )
            ],
          ),
          if (suffixWidget != null) const Spacer(),
          if (suffixWidget != null)
            Padding(
              padding: EdgeInsets.only(right: 28.w),
              child: suffixWidget!,
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(
        double.infinity,
        description == null ? 50.h : 90.h,
      );
}
