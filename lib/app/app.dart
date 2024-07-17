import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sentry_flutter/sentry_flutter.dart';

import '../core/components/app_cache_builder.dart';
import '../public/color_palette.dart';
import '../screens/splash/view/splash_view.dart';
import 'base_widgets/loading_widget.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      child: ValueListenableBuilder(
        valueListenable: appDirection,
        builder: (context, directions, child) {
          return AppCacheBuilder(builder: (context, cache, child) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              scaffoldMessengerKey: scaffoldMessengerKey,
              navigatorObservers: [
                SentryNavigatorObserver(),
              ],
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: ColorPalette.mainColors.blue,
                fontFamily: GoogleFonts.rubik().fontFamily,
              ),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('tr'),
                Locale("en"),
              ],
              locale: Locale(cache.systemLocale ?? "tr"),
              home: const SplashView(),
              builder: (context, child) {
                return Directionality(
                  textDirection: directions,
                  child: Stack(
                    children: [
                      child ?? const SizedBox.shrink(),
                      const AppLoadingWidget(),
                    ],
                  ),
                );
              },
            );
          });
        },
      ),
    );
  }
}
