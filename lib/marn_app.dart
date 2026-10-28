import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marn/config/localization/cubit/localizations_cubit.dart';
import 'package:marn/core/services/session_cubit.dart';
import 'package:marn/core/utils/app_colors.dart';
import 'package:marn/core/utils/app_typography.dart';
import 'package:marn/core/services/service_locator.dart';
import 'package:marn/routing/router_generator.dart';

class MarnApp extends StatelessWidget {
  const MarnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationsCubit>.value(value: sl<LocalizationsCubit>()),
        BlocProvider<SessionCubit>.value(value: sl<SessionCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<LocalizationsCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp.router(
                routerConfig: RouterGenerator.router,
                debugShowCheckedModeBanner: false,
                title: 'Marn',
                theme: ThemeData(
                  useMaterial3: true,
                  splashFactory: InkRipple.splashFactory,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  scaffoldBackgroundColor: AppColors.brandBeige,
                  colorScheme:
                      const ColorScheme.light(
                        primary: AppColors.primary600,
                        onPrimary: AppColors.baseWhite,
                        secondary: AppColors.gray700,
                        onSecondary: AppColors.baseWhite,
                        surface: AppColors.baseWhite,
                        onSurface: AppColors.baseDark,
                        error: AppColors.error500,
                        onError: AppColors.baseWhite,
                      ).copyWith(
                        primaryContainer: AppColors.primary50,
                        onPrimaryContainer: AppColors.primary900,
                        secondaryContainer: AppColors.gray50,
                        onSecondaryContainer: AppColors.gray900,
                        tertiary: AppColors.grayNeutral200,
                        onTertiary: AppColors.baseWhite,
                        surfaceContainerHighest: AppColors.gray100,
                        outline: AppColors.gray200,
                        outlineVariant: AppColors.gray100,
                        shadow: AppColors.baseBlack,
                        surfaceTint: AppColors.primary600,
                      ),
                  appBarTheme: const AppBarTheme(
                    centerTitle: false,
                    backgroundColor: AppColors.baseWhite,
                    surfaceTintColor: AppColors.baseWhite,
                    foregroundColor: AppColors.baseDark,
                  ),
                  cardTheme: CardThemeData(
                    color: AppColors.baseWhite,
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  navigationBarTheme: NavigationBarThemeData(
                    backgroundColor: AppColors.baseWhite,
                    indicatorColor: AppColors.primary50,
                  ),
                  filledButtonTheme: FilledButtonThemeData(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary600,
                      foregroundColor: AppColors.baseWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      textStyle: AppTypography.paragraph2(),
                    ),
                  ),
                  outlinedButtonTheme: OutlinedButtonThemeData(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      side: const BorderSide(color: AppColors.primary600),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      textStyle: AppTypography.paragraph2(),
                    ),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      textStyle: AppTypography.paragraph2(),
                    ),
                  ),
                  textTheme: AppTypography.textTheme.apply(
                    bodyColor: AppColors.baseDark,
                    displayColor: AppColors.baseDark,
                  ),
                  primaryTextTheme: AppTypography.textTheme.apply(
                    bodyColor: AppColors.baseDark,
                    displayColor: AppColors.baseDark,
                  ),
                  dividerColor: AppColors.gray200,
                  iconTheme: const IconThemeData(color: AppColors.gray700),
                ),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [Locale('en'), Locale('ar')],
                locale: locale,
                builder: (context, child) {
                  final mediaQuery = MediaQuery.of(context);
                  return MediaQuery(
                    data: mediaQuery.copyWith(textScaler: TextScaler.noScaling),
                    child: child ?? const SizedBox.shrink(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
