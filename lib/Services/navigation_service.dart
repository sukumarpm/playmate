import 'package:flutter/material.dart';
import 'package:playmate/Screens/getfavourite.dart';
import 'package:playmate/Screens/getpersonal.dart';
import 'package:playmate/Screens/gettermcond.dart';
import 'package:playmate/Screens/gmap.dart';
import 'package:playmate/Screens/home.dart';
import 'package:playmate/Screens/homedriver.dart';
import 'package:playmate/Screens/login.dart';
import 'package:playmate/Screens/onboarding.dart';
import 'package:playmate/Screens/postgame.dart';
import 'package:playmate/Screens/register.dart';

class NavigationService {
  late GlobalKey<NavigatorState> _navigatorKey;

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/login": (context) => const Login(),
    "/onboard": (context) => const OnBoarding(),
    "/register": (context) => const Register(),
    "/home": (context) => const Home(),
    "/gmap": (context) => const GMap(),
    "/getfavourite": (context) => const GetFavourite(),
    "/getpersonal": (context) => const GetPersonal(),
    "/gettermsconditions": (context) => const GetTermsConditions(),
    "/homedriver": (context) => const HomeDriver(),
    "/postgame": (context) => const PostGame(),
  };

  GlobalKey<NavigatorState>? get navigatorKey {
    return _navigatorKey;
  }

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  NavigationService() {
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  void pushNamed(String routeName) {
    _navigatorKey.currentState?.pushNamed(routeName);
  }

  void pushNamedWithParm(String routeName, final String title) {
    _navigatorKey.currentState?.pushNamed(routeName, arguments: {title});
  }

  void pushReplacedNamed(String routeName) {
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack() {
    _navigatorKey.currentState?.pop();
  }
}
