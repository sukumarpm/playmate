import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:playmate/Services/auth_service.dart';
import 'package:playmate/Services/navigation_service.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      const ContentConfig(
        title: "ERASER",
        description:
            "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        pathImage: "images/photo_eraser.png",
        backgroundColor: Color.fromARGB(255, 144, 107, 49),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "PENCIL",
        description:
            "Ye indulgence unreserved connection alteration appearance",
        pathImage: "lib/assets/images/onboard/pana.png",
        backgroundColor: Color.fromARGB(255, 82, 130, 226),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "RULER",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        pathImage: "lib/assets/images/onboard/IMG-20160221-WA0003.jpg",
        backgroundColor: Color.fromARGB(255, 216, 181, 233),
      ),
    );
  }

  void onDonePress() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyApp1()));
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: listContentConfig,
      onDonePress: onDonePress,
    );
  }
}

class MyApp1 extends StatelessWidget {
  late AuthService _auth;
  late NavigationService _navigationService;

  MyApp1({super.key}) {
    final GetIt getIt = GetIt.instance;
    _auth = getIt.get<AuthService>();
    _navigationService = getIt.get<NavigationService>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: _navigationService.navigatorKey,
      title: 'Flutter Demo',
      // theme: Provider.of<ThemeProvider>(context).themeData,
      // initialRoute: "/login",
      // initialRoute: _auth.user != null ? "/mydeliveries" : "/dropdown",
      initialRoute: _auth.user != null ? "/homedriver" : "/login",
      // initialRoute: _auth.user != null ? "/register" : "/fmlogo",
      // initialRoute: "/login",
      routes: _navigationService.routes,
    );
  }
}
