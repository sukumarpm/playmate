import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playmate/Services/auth_service.dart';
import 'package:playmate/Services/navigation_service.dart';
import 'package:playmate/Utilities/custom_form.dart';
import 'package:playmate/Utilities/mycontroller.dart';
import 'package:playmate/Utilities/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late double _deviceHeight;
  late double _deviceWidth;
  final _loginFormKey = GlobalKey<FormState>();
  String? _phone;
  String? _passcode;
  bool isDriver = false;
  bool isAdmin = false;
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;
  late AuthService _auth;
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  Map<String, dynamic> registerData = {};
  final MyController c = Get.put(MyController());

  final ButtonStyle style = TextButton.styleFrom(
    foregroundColor: Colors.greenAccent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(14)),
      side: BorderSide(
        color: Colors.blueGrey,
        width: 3,
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _auth = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [
            Color(0xFF9cd936),
            Colors.white,
            // Colors.grey,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              addVerticalSpace(20),
              Text(
                'Playmate',
                style: GoogleFonts.teko(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        letterSpacing: 7,
                        fontWeight: FontWeight.w700)),
              ),
              addVerticalSpace(40),
              Text(
                'Welcome Back! Ready to Play?',
                style: GoogleFonts.sen(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 9, 0, 0),
                        fontSize: 22,
                        fontWeight: FontWeight.w600)),
              ),
              Text(
                "No Excuses, Just Play!",
                style: GoogleFonts.sen(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 9, 0, 0),
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
              addVerticalSpace(
                _deviceHeight * .15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TextButton(
                  //   style: TextButton.styleFrom(
                  //     foregroundColor: Colors.white,
                  //   ),
                  //   onPressed: () {
                  //     Provider.of<ThemeProvider>(context, listen: false)
                  //         .toggleTheme();
                  //   },
                  //   child: Text(
                  //     'TextButton',
                  //     style: TextStyle(
                  //         color: Theme.of(context).secondaryHeaderColor),
                  //   ),
                  // ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image.asset(
                      //   'lib/assets/images/user/logo/LOGO.png',
                      //   fit: BoxFit.contain,
                      //   height: 75,
                      //   width: 75,
                      // ),
                      // _pageTitle(),
                      // SizedBox(
                      //   height: _deviceHeight * 0.04,
                      // ),
                      _loginForm(),
                      SizedBox(
                        height: _deviceHeight * 0.05,
                      ),
                      // _loginButton(),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Column(
                      //   children: [_registerAccountLink(), _supportNumber()],
                      // ),
                      // _registerAccountLink(),
                      // SizedBox(
                      //   height: _deviceHeight * 0.02,
                      // ),
                      // _supportNumber(),
                    ],
                  ),
                  GestureDetector(
                    child: SizedBox(
                      width: _deviceWidth * .8,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color(0xFF9cd936))),
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_loginFormKey.currentState!.validate()) {
                              _loginFormKey.currentState!.save();

                              if (kDebugMode) {
                                print("====== LOGIN DETAILS =====");
                                print("phone: $_phone");
                                print("address: $_passcode");
                                print("====== EVENT END =====");
                              }

                              final QuerySnapshot resulta = await _firebase
                                  .collection("customers")
                                  .where("_phone", isEqualTo: _phone)
                                  .get();

                              List<Object?> data = resulta.docs.map((e) {
                                return e.data();
                              }).toList();
                              if (kDebugMode) {
                                print('data:${data.toString()}');
                              }

                              // final List<DocumentSnapshot> documents = resulta.docs;
                              // if (documents.isNotEmpty) {
                              if (data.isNotEmpty) {
                                Map<dynamic, dynamic> userData = data[0] as Map;
                                if (kDebugMode) {
                                  print(
                                      'result - Login 1:${userData['_passcode']}');
                                }
                                if (userData['_passcode'] == _passcode) {
                                  String fakeemail = '$_phone@playmate.com';
                                  bool result =
                                      await _auth.loginUsingEmailAndPassword(
                                          fakeemail, _passcode!, "", "", "");
                                  if (result) {
                                    //get user
                                    final QuerySnapshot resulta =
                                        await _firebase
                                            .collection("admin")
                                            .where("_phone", isEqualTo: _phone)
                                            .get();

                                    List<Object?> dataadmin =
                                        resulta.docs.map((e) {
                                      return e.data();
                                    }).toList();
                                    if (kDebugMode) {
                                      print('dataadmin:$dataadmin');
                                    }
                                    if (dataadmin.isNotEmpty) {
                                      isAdmin = true;
                                      Map<dynamic, dynamic> adminData =
                                          dataadmin[0] as Map;
                                      Get.find<MyController>().isAdmin =
                                          true.obs;
                                      Get.find<MyController>().admindata =
                                          adminData;
                                    } else {
                                      isAdmin = false;
                                    }

                                    // if (kDebugMode) {
                                    //   print('dataadmin:$dataadmin');
                                    // }

                                    //get user
                                    Get.find<MyController>().profiledata =
                                        userData;
                                    // Get.snackbar('Welcome!. ', userData['name'] + '!',
                                    //     barBlur: 1,
                                    //     backgroundColor: Colors.white,
                                    //     margin: EdgeInsets.all(_deviceHeight * .1),
                                    //     duration: const Duration(seconds: 5),
                                    //     snackPosition: SnackPosition.BOTTOM);
                                    if (isAdmin) {
                                      _navigationService
                                          .pushNamed("/adminhome");
                                    } else {
                                      _navigationService.pushNamed("/home");
                                    }
                                  } else {
                                    Get.snackbar('Oops!. ',
                                        'Problem logging in now. Please retry after sometime or contact admin.',
                                        barBlur: 1,
                                        backgroundColor: Colors.white,
                                        margin:
                                            EdgeInsets.all(_deviceHeight * .1),
                                        duration: const Duration(seconds: 5),
                                        snackPosition: SnackPosition.BOTTOM);
                                  }
                                } else {
                                  Get.snackbar('Oops!. ',
                                      'Phone/Passcode is incorrect. Please retry.',
                                      barBlur: 1,
                                      backgroundColor: Colors.white,
                                      margin:
                                          EdgeInsets.all(_deviceHeight * .1),
                                      duration: const Duration(seconds: 5),
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              } else {
                                Get.snackbar('Oops!. ',
                                    'This account is not registered.',
                                    barBlur: 1,
                                    backgroundColor: Colors.white,
                                    margin: EdgeInsets.all(_deviceHeight * .1),
                                    duration: const Duration(seconds: 5),
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            } else {
                              // if (kDebugMode) {
                              //   print('result : validation error');
                              // }
                            }
                            _navigationService.pushNamed("/home");
                          }),
                    ),
                    onTap: () {
                      _navigationService.pushNamed("/gmap");
                    },
                  ),
                  _registerAccountLink(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Image.asset(
                      //   'lib/assets/images/user/logo/login screen fb,x,apple/Group 8189.png',
                      //   fit: BoxFit.contain,
                      //   height: 62,
                      //   width: 62,
                      // ),
                      // Image.network(
                      //   'http://pngimg.com/uploads/google/google_PNG19635.png',
                      //   fit: BoxFit.contain,
                      //   height: 82,
                      //   width: 82,
                      // ),
                      // Image.asset(
                      //   'lib/assets/images/user/logo/login screen fb,x,apple/Group 8187.png',
                      //   fit: BoxFit.contain,
                      //   height: 62,
                      //   width: 62,
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return SizedBox(
      height: _deviceHeight * 0.10,
      child: Text(
        'LOGIN',
        style: GoogleFonts.inter(
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 43, 3, 3), fontSize: 22)),
        // style: GoogleFonts.inter(
        //     textStyle: const TextStyle(
        //         color: Colors.white,
        //         fontWeight: FontWeight.bold,
        //         fontSize: 22)),
      ),
    );
  }

  Widget _loginForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PHONE NUMBER',
              style: GoogleFonts.sen(
                  textStyle: const TextStyle(
                      color: Color.fromARGB(255, 9, 0, 0), fontSize: 14)),
            ),
            SizedBox(
              width: _deviceWidth * .9,
              child: CustomFormField(
                onSaved: (value) {
                  setState(() {
                    _phone = value;
                  });
                },
                regEx: r"^(?:[+0]9)?[0-9]{10}$",
                hintText: "+91",
                initialValue: null,
                obscureText: false,
                height: _deviceHeight * .1,
                keytype: TextInputType.emailAddress,
              ),
            ),
            addVerticalSpace(10),
            Text(
              'PASSCODE',
              style: GoogleFonts.sen(
                  textStyle: const TextStyle(
                      color: Color.fromARGB(255, 9, 0, 0), fontSize: 14)),
            ),
            SizedBox(
              width: _deviceWidth * .9,
              child: CustomFormField(
                onSaved: (value) {
                  setState(() {
                    _passcode = value;
                  });
                },
                regEx: r".{6,}",
                hintText: "* * * * * *",
                initialValue: null,
                obscureText: true,
                height: _deviceHeight * .1,
                keytype: TextInputType.visiblePassword,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                  tristate: false,
                  fillColor: const WidgetStatePropertyAll<Color>(
                      Color.fromARGB(255, 248, 251, 244)),
                  value: isDriver,
                  side: WidgetStateBorderSide.resolveWith(
                    (states) =>
                        const BorderSide(width: 1.0, color: Colors.black54),
                  ),
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    setState(() {
                      isDriver = value!;
                    });
                  },
                ),
                const Text(
                  'Forgot PassCode',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerAccountLink() {
    return GestureDetector(
      onTap: () => {_navigationService.pushNamed("/register")},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Don\'t have an account?',
            style: TextStyle(
              color: Color(0xFF646982),
              fontSize: 16,
            ),
          ),
          addHorizontalSpace(15),
          GestureDetector(
            onTap: () {
              print('sign up');
              _navigationService.pushNamed("/register");
            },
            child: Text(
              'SIGN UP',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
