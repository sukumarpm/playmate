import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playmate/Services/navigation_service.dart';
import 'package:playmate/Utilities/custom_form.dart';
import 'package:playmate/Utilities/mycontroller.dart';
import 'package:playmate/Utilities/utils.dart';
import 'package:intl/intl.dart';

class GetPersonal extends StatefulWidget {
  const GetPersonal({super.key});

  @override
  State<GetPersonal> createState() => _GetPersonalState();
}

class _GetPersonalState extends State<GetPersonal> {
  late double _deviceHeight;
  late double _deviceWidth;
  final _registerFormKey = GlobalKey<FormState>();
  String? _name;
  String? _phone;
  String? _passcode;
  String? _confirmpasscode;
  bool isDriver = false;
  bool isAdmin = false;
  late NavigationService _navigationService;
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final GetIt _getIt = GetIt.instance;
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
    _navigationService = _getIt.get<NavigationService>();
    registerData = c.registerdata;
  }

  @override
  void dispose() {
    super.dispose();
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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          'Welcome Back! Ready to Play?',
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
                            SizedBox(
                              width: _deviceWidth * .8,
                              child: GestureDetector(
                                onTap: () {
                                  _navigationService.pushNamed("/gmap");
                                },
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: WidgetStateProperty.all<
                                                OutlinedBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0))),
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                const Color(0xFF9cd936))),
                                    child: const Text(
                                      "NEXT",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (_registerFormKey.currentState!
                                          .validate()) {
                                        _registerFormKey.currentState!.save();
                                        if (_passcode == _confirmpasscode) {
                                          print('clicked');
                                          final QuerySnapshot resulta =
                                              await _firebase
                                                  .collection("customers")
                                                  .where("_phone",
                                                      isEqualTo: _phone)
                                                  .get();
                                          final List<DocumentSnapshot>
                                              documents = resulta.docs;

                                          if (documents.isNotEmpty) {
                                            //exists
                                            // if (kDebugMode) {
                                            //   print('Exists');
                                            // }

                                            Get.snackbar('Oops!. ',
                                                'Account with this Phone number already exist! Please try with different number',
                                                barBlur: 1,
                                                backgroundColor: Colors.white,
                                                margin: EdgeInsets.all(
                                                    _deviceHeight * .1),
                                                duration:
                                                    const Duration(seconds: 5),
                                                snackPosition:
                                                    SnackPosition.BOTTOM);
                                          } else {
                                            DateTime now = DateTime.now();
                                            DateTime pickedDate = DateTime(
                                                now.year, now.month, now.day);
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            registerData['_name'] = _name;
                                            registerData['_phone'] = _phone;
                                            registerData['_passcode'] =
                                                _passcode;
                                            registerData['formattedDate'] =
                                                formattedDate;
                                            Get.find<MyController>()
                                                .registerdata = registerData;
                                            print(registerData);
                                            _navigationService
                                                .pushNamed("/gmap");
                                          }
                                        } else {
                                          Get.snackbar('Oops!.',
                                              'Passcode is not matching. Please try again',
                                              barBlur: 1,
                                              backgroundColor: Colors.white,
                                              margin: EdgeInsets.all(
                                                  _deviceHeight * .1),
                                              duration:
                                                  const Duration(seconds: 5),
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                        }
                                      }
                                    }),
                              ),
                            ),
                            _registerAccountLink(),
                            addVerticalSpace(35),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  color: Colors.green,
                                  width: _deviceWidth * .18,
                                  height: 5,
                                ),
                                Container(
                                  color: Colors.blueGrey,
                                  width: _deviceWidth * .18,
                                  height: 3,
                                ),
                                Container(
                                  color: Colors.blueGrey,
                                  width: _deviceWidth * .18,
                                  height: 3,
                                ),
                                Container(
                                  color: Colors.blueGrey,
                                  width: _deviceWidth * .18,
                                  height: 3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Form(
        key: _registerFormKey,
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
                    _name = value;
                  });
                },
                regEx: r".{3,}",
                hintText: "Full name",
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
                    _confirmpasscode = value;
                  });
                },
                regEx: r".{6,}",
                hintText: "xxxxxx",
                initialValue: null,
                obscureText: false,
                height: _deviceHeight * .1,
                keytype: TextInputType.emailAddress,
              ),
            ),
            addVerticalSpace(30),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Checkbox(
            //       tristate: false,
            //       fillColor: const WidgetStatePropertyAll<Color>(
            //           Color.fromARGB(255, 248, 251, 244)),
            //       value: isDriver,
            //       side: WidgetStateBorderSide.resolveWith(
            //         (states) =>
            //             const BorderSide(width: 1.0, color: Colors.black54),
            //       ),
            //       checkColor: Colors.white,
            //       onChanged: (bool? value) {
            //         setState(() {
            //           isDriver = value!;
            //         });
            //       },
            //     ),
            //     const Text(
            //       'Login as Admin',
            //       style: TextStyle(color: Color.fromARGB(255, 179, 236, 46)),
            //     ),
            //   ],
            // ),
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
