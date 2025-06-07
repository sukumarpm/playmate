import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:playmate/Services/auth_service.dart';
import 'package:playmate/Services/navigation_service.dart';

Future<void> registerservice() async {
  final GetIt getIT = GetIt.instance;
  // getIT.registerSingleton<AuthService>(AuthService());
  // getIT.registerSingleton<NavigationService>(NavigationService());
  getIT.registerSingleton<AuthService>(AuthService());
  getIT.registerSingleton<NavigationService>(NavigationService());
}

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}
