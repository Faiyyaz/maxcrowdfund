import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxcrowdfund/screens/splash_screen.dart';
import 'package:maxcrowdfund/service/locator.dart';
import 'package:maxcrowdfund/service/navigation_service.dart';
import 'package:maxcrowdfund/utilities/ui_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    setupLocator();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaxCrowd Fund',
      theme: ThemeData.light().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cursorColor: kBlackColor,
      ),
      home: SplashScreen(),
      navigatorKey: _navigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    return null;
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}
