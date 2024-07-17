import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomDashboardPadding extends StatelessWidget {
  const AppBottomDashboardPadding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.paddingOf(context).bottom + 110.h,
    );
  }
}
