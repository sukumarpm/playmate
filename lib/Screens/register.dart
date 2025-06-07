import 'package:flutter/material.dart';
import 'package:playmate/Screens/getfavourite.dart';
import 'package:playmate/Screens/getlocation.dart';
import 'package:playmate/Screens/getpersonal.dart';
import 'package:playmate/Screens/gettermcond.dart';
import 'package:playmate/Screens/gmap.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal, // or Axis.vertical
        children: const [
          GetPersonal(),
          GMap(),
          GetFavourite(),
          GetTermsConditions(),
        ],
      ),
    );
  }
}
