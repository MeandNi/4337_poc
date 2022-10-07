import 'package:app/app/info/app_theme.dart';
import 'package:app/app/ui/page/login_page/login_binding.dart';
import 'package:app/app/ui/routes/routes.dart';
import 'package:app/app/util/injection.dart';
import 'package:app/app/util/platform_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection.init();
  if (PlatformUtil.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Soul Wallet',
      theme: appThemeData,
      getPages: Routes.routePage,
      initialBinding: LoginBinding(),
      initialRoute: Routes.loginPage,
      navigatorObservers: [FlutterSmartDialog.observer],
      scrollBehavior: const _ScrollBehavior(),
      builder: FlutterSmartDialog.init(
        builder: (_, Widget? child) => GestureDetector(
          onTap: () => SystemChannels.textInput
              .invokeMethod('TextInput.hide')
              .catchError((_) {}),
          child: child,
        ),
      ),
    );
  }
}

class _ScrollBehavior extends MaterialScrollBehavior {
  const _ScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
