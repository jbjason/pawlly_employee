import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly_employee/locale/language_en.dart';
import 'package:pawlly_employee/screens/booking_module/booking_list/bookings_controller.dart';

import 'app_theme.dart';
import 'configs.dart';
import 'locale/app_localizations.dart';
import 'locale/languages.dart';
import 'screens/splash_screen.dart';
import 'utils/app_common.dart';
import 'utils/colors.dart';
import 'utils/common_base.dart';
import 'utils/constants.dart';
import 'utils/local_storage.dart';
import 'utils/one_signal_utils.dart';

Rx<BaseLanguage> locale = LanguageEn().obs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // locale.value.LanguageList = languageList();

  await GetStorage.init();
  //
  fontFamilyPrimaryGlobal = GoogleFonts.beVietnamPro(fontWeight: FontWeight.w500).fontFamily;
  // textPrimarySizeGlobal = 24;
  textPrimarySizeGlobal = 14;
  textPrimaryColorGlobal = primaryTextColor;
  fontFamilySecondaryGlobal = GoogleFonts.beVietnamPro(fontWeight: FontWeight.w400).fontFamily;
  // textSecondarySizeGlobal = 14;
  textSecondarySizeGlobal = 12;
  textSecondaryColorGlobal = secondaryTextColor;
  //
  defaultBlurRadius = 0;
  defaultRadius = 12;
  defaultSpreadRadius = 0;
  appButtonBackgroundColorGlobal = primaryColor;
  defaultAppButtonRadius = defaultRadius;
  defaultAppButtonElevation = 0;
  defaultAppButtonTextColorGlobal = Colors.white;

  await initialize(aLocaleLanguageList: languageList());

  selectedLanguageCode(getValueFromLocal(SELECTED_LANGUAGE_CODE) ?? DEFAULT_LANGUAGE);
  BaseLanguage temp = await const AppLocalizations().load(Locale(selectedLanguageCode.value));
  locale = temp.obs;
  locale.value = await const AppLocalizations().load(Locale(selectedLanguageCode.value));

  try {
    final getThemeFromLocal = getValueFromLocal(SettingsLocalConst.THEME_MODE);
    if (getThemeFromLocal is int) {
      toggleThemeMode(themeId: getThemeFromLocal);
    } else {
      toggleThemeMode(themeId: THEME_MODE_SYSTEM);
    }
  } catch (e) {
    log('getThemeFromLocal from cache E: $e');
  }

  if (kReleaseMode) {
    Firebase.initializeApp().then((value) {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    });
  }

  initOneSignal();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RestartAppWidget(
      child: Obx(
        () => GetMaterialApp(
          navigatorKey: navigatorKey,
          title: APP_NAME,
          debugShowCheckedModeBanner: false,
          supportedLocales: LanguageDataModel.languageLocales(),
          localizationsDelegates: const [
            AppLocalizations(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) => Locale(selectedLanguageCode.value),
          fallbackLocale: const Locale(DEFAULT_LANGUAGE),
          locale: Locale(selectedLanguageCode.value),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          // themeMode: ThemeMode.system,
          themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialBinding: BindingsBuilder(() {
            isDarkMode.value
                ? setStatusBarColor(scaffoldDarkColor, statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.light)
                : setStatusBarColor(context.scaffoldBackgroundColor, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.light);
            if (isLoggedIn.value) {
              log('INITIALBINDING: called');
              Get.put<BookingsController>(BookingsController());
            }
          }),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
