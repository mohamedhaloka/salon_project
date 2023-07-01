import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salon_app/firebase_options.dart';
import 'package:salon_app/modules/auth/auth__screens/login_screen.dart';
import 'package:salon_app/services/notification_service.dart';
import 'package:salon_app/shared/componants/app_constane.dart';
import 'package:salon_app/shared/componants/di.dart';
import 'package:salon_app/shared/componants/language_type.dart';
import 'package:salon_app/shared/local_data_source/locale_data_source.dart';
import 'package:salon_app/shared/remote_data_source/remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules/chose_place/choose_place.dart';
import 'modules/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'salon-app',
  );
  await initAppModule();

  await AppPreferences.init();

  DioHelper();
  Widget widget;

  bool? onBoarding = AppPreferences.getData('onBoarding');
  await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: HexColor('#FFFFFF').withOpacity(0.1),
  ));

  token = await AppPreferences.getData('token');
  print(token);

  if (onBoarding != null) {
    if (token != null) {
      widget = const ChosePlace();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(EasyLocalization(
    saveLocale: true,
    supportedLocales: const [arabicLocal, englishLocal],
    path: assetPathLocation,
    fallbackLocale: const Locale("ar", "SA"),
    child: Phoenix(
        child: MyApp(
      startWidget: widget,
    )),
  ));
}

class MyApp extends StatefulWidget {
  final Widget startWidget;
  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState(startWidget);
}

class _MyAppState extends State<MyApp> {
  Widget startWidget;

  _MyAppState(this.startWidget);

  final AppPreferences _appPreferences = instance<AppPreferences>();
  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  void initState() {
    NotificationsService.instance.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (BuildContext context, Widget? child) {
      return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        home: startWidget,
        theme: ThemeData(platform: TargetPlatform.iOS, fontFamily: 'Cairo'),
      );
    });
  }
}
