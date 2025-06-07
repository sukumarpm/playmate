import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playmate/Services/auth_service.dart';
import 'package:playmate/Services/navigation_service.dart';
import 'package:playmate/Utilities/custom_form.dart';
import 'package:playmate/Utilities/mycontroller.dart';
import 'package:playmate/Utilities/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetTermsConditions extends StatefulWidget {
  const GetTermsConditions({super.key});

  @override
  State<GetTermsConditions> createState() => _GetTermsConditionsState();
}

class _GetTermsConditionsState extends State<GetTermsConditions> {
  late double _deviceHeight;
  late double _deviceWidth;
  final _loginFormKey = GlobalKey<FormState>();
  String? _phone;
  String? _passcode;
  bool isDriver = false;
  bool isAdmin = false;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
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
    registerData = c.registerdata;
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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                      addVerticalSpace(30),
                      Text(
                        'Terms & Conditions',
                        style: GoogleFonts.sen(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 9, 0, 0),
                                fontSize: 20,
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
                        _deviceHeight * .05,
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // height:
                                  //     MediaQuery.of(context).size.height * .5,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Color(0xFF7F7F7F)),
                                      left:
                                          BorderSide(color: Color(0xFF7F7F7F)),
                                      right:
                                          BorderSide(color: Color(0xFF7F7F7F)),
                                      bottom:
                                          BorderSide(color: Color(0xFF7F7F7F)),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: const Column(
                                    children: <Widget>[
                                      Text(
                                          "1️⃣ Acceptance of TermsBy signing up, you agree to follow these Terms & Conditions. If you do not agree, please do not use this app.2️⃣ Who Can Use This App?✔️ You must be at least 13 years old to create an account. ✔️ You are responsible for any activity under your account. ✔️ Fake accounts, spam, or misleading information will result in a ban.3️⃣ Your Privacy & Data Usage🔹 We collect your location to show nearby game meetups. 🔹 We store your profile details (name, interests, etc.) to improve recommendations. 🔹 We do not sell your data to third parties. 🔹 You can delete your account anytime from the settings.📌 For full details, please read our Privacy Policy [🔗 Click Here].4️⃣ Meetup Rules & User Conduct✅ Always be respectful to other users. ✅ Only create real game meetups—no misleading events. ✅ Follow local laws and safety guidelines while meeting people. ✅ If a user reports misconduct, we may suspend or ban accounts.⚠️ Any inappropriate behavior (harassment, violence, fake meetups) will result in permanent removal from the platform.5️⃣ Payments & Subscriptions (If Applicable)🔹 If the app has paid features, refunds will be handled as per our Refund Policy. 🔹 Any in-app purchases must be made through official app stores (Google Play / Apple App Store). 🔹 We do not handle payments outside the app.6️⃣ Liability Disclaimer🔺 This app only connects players; we are not responsible for:Injuries, accidents, or disputes during meetups.Miscommunication between users.Lost/stolen personal belongings.🔹 Please use caution and good judgment while meeting new people.7️⃣ Account Suspension & Termination🚫 We may suspend your account if:You violate these terms.You create fake meetups or mislead users.You engage in harassment or inappropriate behavior.You can appeal a ban by contacting [Support Email].8️⃣ Updates to Terms & Conditions📌 We may update these Terms from time to time. 📌 Users will be notified of significant changes. 📌 Continuing to use the app means you accept any new terms.9️⃣ Contact & SupportFor any questions, reach out to [Support Email] or visit [Help Center Link].✅ By signing up, you agree to these Terms & Conditions and our Privacy Policy."),
                                    ],
                                  ),
                                  // PDFView(
                                  //   filePath:
                                  //       'lib/assets/images/pdf/ACK305427840310724.pdf',
                                  //   enableSwipe: true,
                                  //   swipeHorizontal: true,
                                  //   autoSpacing: false,
                                  //   pageFling: false,
                                  //   backgroundColor: Colors.black,
                                  //   onRender: (pages) {
                                  //     setState(() {
                                  //       pages = pages;
                                  //       isReady = true;
                                  //     });
                                  //   },
                                  //   onError: (error) {
                                  //     print(error.toString());
                                  //   },
                                  //   onPageError: (page, error) {
                                  //     print('$page: ${error.toString()}');
                                  //   },
                                  //   onViewCreated:
                                  //       (PDFViewController pdfViewController) {
                                  //     _controller.complete(pdfViewController);
                                  //   },
                                  //   onPageChanged: (int? page, int? total) {
                                  //     if (kDebugMode) {
                                  //       print('page change: $page/$total');
                                  //     }
                                  //   },
                                  // )
                                ),
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
                          SizedBox(
                            width: _deviceWidth * .8,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: WidgetStateProperty.all<
                                            OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0))),
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            const Color(0xFF9cd936))),
                                child: const Text(
                                  "REGISTER",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  print('registerData['
                                      'phone'
                                      ']:${registerData['_phone']}');
                                  final QuerySnapshot resulta = await _firebase
                                      .collection("customers")
                                      .where("_phone",
                                          isEqualTo: registerData['_phone']!)
                                      .get();
                                  final List<DocumentSnapshot> documents =
                                      resulta.docs;
                                  print('documents.isNotEmpty:$documents');
                                  if (documents.isNotEmpty) {
                                    //exists
                                    // if (kDebugMode) {
                                    //   print('Exists');
                                    // }

                                    Get.snackbar('Oops!. ',
                                        'Account with this Phone number already exist! Please try with different number',
                                        barBlur: 1,
                                        backgroundColor: Colors.white,
                                        margin:
                                            EdgeInsets.all(_deviceHeight * .1),
                                        duration: const Duration(seconds: 2),
                                        snackPosition: SnackPosition.BOTTOM);
                                  } else {
                                    //not exists
                                    String? result = await _auth
                                        .registerUserUsingEmailAndPassword(
                                            '${registerData['_phone']!}@playmate.com',
                                            registerData['_passcode']!,
                                            '',
                                            '',
                                            registerData['name']);
                                    if (kDebugMode) {
                                      print('uid: $result');
                                    }
                                    registerData['TandC'] = true;
                                    await _firebase
                                        .collection('customers')
                                        .doc(_phone)
                                        .set(registerData);
                                    _navigationService.pushNamed("/home");
                                  }
                                }),
                          ),
                          //_registerAccountLink(),
                          addVerticalSpace(55),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                color: Colors.green,
                                width: _deviceWidth * .18,
                                height: 5,
                              ),
                              Container(
                                color: Colors.green,
                                width: _deviceWidth * .18,
                                height: 5,
                              ),
                              Container(
                                color: Colors.green,
                                width: _deviceWidth * .18,
                                height: 5,
                              ),
                              Container(
                                color: Colors.green,
                                width: _deviceWidth * .18,
                                height: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          onPressed: () {
            setState(() {
              _navigationService.goBack();
            });
          },
          child: const Icon(
            Icons.arrow_left_rounded,
            size: 50,
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
              'NAME',
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
            addVerticalSpace(10),
            Text(
              'CONFIRM PASSCODE',
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
                  'Login as Admin',
                  style: TextStyle(color: Color.fromARGB(255, 179, 236, 46)),
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
      onTap: () => {
        // _navigationService.pushNamed("/register")
      },
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
              //_navigationService.pushNamed("/register");
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

class LinkTextSpan extends TextSpan {
  var url = Uri.parse('https://example.com');
  LinkTextSpan({super.style, String? url, String? text})
      : super(
            text: text ?? url,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrl(Uri.parse(url!));
              });
}
