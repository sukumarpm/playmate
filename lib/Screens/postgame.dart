import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playmate/Services/navigation_service.dart';
import 'package:playmate/Utilities/custom_form.dart';
import 'package:playmate/Utilities/mycontroller.dart';
import 'package:playmate/Utilities/utils.dart';
import 'package:intl/intl.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import 'package:fuzzy/fuzzy.dart';

class PostGame extends StatefulWidget {
  const PostGame({super.key});

  @override
  State<PostGame> createState() => _PostGameState();
}

enum SingingCharacter { Free, Paid }

class _PostGameState extends State<PostGame> {
  late double _deviceHeight;
  late double _deviceWidth;
  final _registerFormKey = GlobalKey<FormState>();
  String? _name;
  String? _phone;
  String? _passcode;
  String? _confirmpasscode;
  late int _ratingBarMode = 1;
  bool isDriver = false;
  bool isAdmin = false;
  DateTime validityDate = DateTime.now();
  TimeOfDay validityTime = TimeOfDay.now();
  late NavigationService _navigationService;
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final GetIt _getIt = GetIt.instance;
  Map<String, dynamic> registerData = {};
  final MyController c = Get.put(MyController());
  Time _time = Time(hour: 11, minute: 30, second: 20);
  bool iosStyle = false;
  List categoryImage = [
    {
      'icon': Icons.sports_cricket,
      'title': 'Cricket',
      'price': '120.00',
    },
    {
      'icon': Icons.sports_hockey,
      'title': 'Football',
      'price': '85.00',
    },
    {
      'icon': Icons.sports_tennis,
      'title': 'Tennis',
      'price': '90.00',
    },
    {
      'icon': Icons.sports_volleyball,
      'title': 'Criket',
      'price': '120.00',
    },
    {
      'icon': Icons.sports_basketball,
      'title': 'Football',
      'price': '85.00',
    },
    {
      'icon': Icons.sports_handball,
      'title': 'Tennis',
      'price': '90.00',
    },
    {
      'icon': Icons.sports_gymnastics,
      'title': 'Criket',
      'price': '120.00',
    },
    {
      'icon': Icons.sports_kabaddi,
      'title': 'Football',
      'price': '85.00',
    },
    {
      'icon': Icons.sports_golf,
      'title': 'Tennis',
      'price': '90.00',
    },
    // {
    //   'url': 'lib/assets/images/food/pexels-ella-olsson-572949-1640773.jpg',
    //   'title': 'Snacks',
    //   'price': '210.00',
    // },
    {
      'icon': Icons.sports_bar,
      'title': 'Hockey',
      'price': '210.00',
    },
  ];
  int? _expandedIndex;
  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Post a Game',
                          style: GoogleFonts.sen(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 9, 0, 0),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600)),
                        ),
                        addVerticalSpace(10),
                        Text(
                          'Invite player to join you game session',
                          style: GoogleFonts.sen(
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 9, 0, 0),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200)),
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
                                      "POST",
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
                            //_registerAccountLink(),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          onPressed: () {
            setState(() {
              _navigationService.goBack();
              // _navigationService.pushNamed("/getpersonal");
            });
          },
          child: const Icon(
            Icons.arrow_left_rounded,
            size: 60,
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
    SingingCharacter? character = SingingCharacter.Free;
    return Form(
      key: _registerFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Game',
            style: GoogleFonts.sen(
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 9, 0, 0), fontSize: 14)),
          ),
          Row(
            children: [
              SizedBox(
                                    width: _deviceWidth * .35,
                                    child: TextFormField(
                                      onSaved: (value) {
                                        setState(() {
                                          _name = value;
                                        });
                                      },
                                      cursorColor: Colors.green,
                                      onChanged:(value) {
                                         final fuse = Fuzzy(
                    categoryImage,
                    options: FuzzyOptions(
                      findAllMatches: true,
                      tokenize: true,
                      threshold: 0.5,
                    ),
                  );
                  final result = fuse.search(_name!);

                  print(
                      'A score of 0 indicates a perfect match, while a score of 1 indicates a complete mismatch.');

                  for (var r in result) {
                    print('\nScore: ${r.score}\nTitle: ${r.item}');
                  }
                  print(_name);
                                      } ,
                                      initialValue: _name,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      obscureText: false,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        return RegExp(r".{4,}").hasMatch(value!)
                                            ? null
                                            : 'Enter a valid value.';
                                      },
                                      decoration: InputDecoration(
                                        fillColor: const Color(0xffE3EBF2),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: _name,
                                        hintStyle: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12),
                                      ),
                                    ),
                                  )
                                ]),
              // SizedBox(
              //   width: _deviceWidth * .75,
              //   child: CustomFormField(
              //     onSaved: (value) {
              //       setState(() {
              //         _name = value;
              //       });
              //     },
              //     regEx: r".{3,}",
              //     hintText: 'Type to search game..',
              //     initialValue: _name,
              //     obscureText: false,
              //     height: _deviceHeight * .1,
              //     keytype: TextInputType.text,
              //   ),
              // ),
              GestureDetector(
                child: const Text('APPLY'),
                onTap: () async {
                  final fuse = Fuzzy(
                    categoryImage,
                    options: FuzzyOptions(
                      findAllMatches: true,
                      tokenize: true,
                      threshold: 0.5,
                    ),
                  );
                  final result = fuse.search(_name!);

                  print(
                      'A score of 0 indicates a perfect match, while a score of 1 indicates a complete mismatch.');

                  for (var r in result) {
                    print('\nScore: ${r.score}\nTitle: ${r.item}');
                  }
                  print(_name);
                  //setResults(searchkeyController.text);
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   'CATEGORY',
              // ),
              // addVerticalSpace(8),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  height: _deviceHeight * .1,
                  child: ListView.builder(
                      itemCount: categoryImage.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        int key = index;
                        return GestureDetector(
                          child: SizedBox(
                            width: _deviceWidth * .25,
                            child: Column(
                              children: [
                                SizedBox(
                                  // height: _deviceWidth * .25,
                                  child: Card(
                                      semanticContainer: true,
                                      color: _expandedIndex != index
                                          ? const Color.fromARGB(
                                              255, 212, 218, 212)
                                          : Colors.green,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      elevation: 5,
                                      margin: const EdgeInsets.all(10),
                                      child: Icon(
                                        categoryImage[index]['icon'],
                                        color: Colors.black,
                                      )),
                                ),
                                Text(
                                  categoryImage[index]['title'],
                                  style: TextStyle(
                                    color: _expandedIndex != index
                                        ? const Color.fromARGB(255, 1, 2, 9)
                                        : Colors.green.shade800,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            print(categoryImage[index]['title']);
                            setState(() {
                              _name = categoryImage[index]['title'];
                              _expandedIndex = index;
                            });
                            // setResults(categoryImage[index]['title']);
                          },
                        );
                      })),
            ],
          ),
          addVerticalSpace(10),
          Text(
            'Title',
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
            'Location',
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
              hintText: "Game location",
              initialValue: null,
              obscureText: true,
              height: _deviceHeight * .1,
              keytype: TextInputType.visiblePassword,
            ),
          ),
          addVerticalSpace(10),
          Text(
            'Number of Players',
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
              hintText: "Eg.1,2,3..",
              initialValue: null,
              obscureText: false,
              height: _deviceHeight * .1,
              keytype: TextInputType.emailAddress,
            ),
          ),
          addVerticalSpace(10),
          Text(
            'Expected Player' 's Skill Level',
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
              hintText: "Advanced",
              initialValue: null,
              obscureText: false,
              height: _deviceHeight * .1,
              keytype: TextInputType.text,
            ),
          ),
          addVerticalSpace(10),
          Text(
            'Game Type',
            style: GoogleFonts.sen(
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 9, 0, 0), fontSize: 14)),
          ),
          SizedBox(
            width: _deviceWidth * .9,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Free"),
                  Radio(
                      value: _ratingBarMode == 1 ? 1 : 0,
                      groupValue: 1,
                      onChanged: (onChanged) {
                        setState(() {
                          _ratingBarMode = 1;
                        });
                      }),
                  const Text("Paid"),
                  Radio(
                      value: _ratingBarMode == 0 ? 1 : 0,
                      groupValue: 1,
                      onChanged: (onChanged) {
                        setState(() {
                          _ratingBarMode = 0;
                        });
                      })
                ],
              ),
            ),
          ),
          _ratingBarMode == 0
              ? Row(
                  children: [
                    const Text('Rs.'),
                    SizedBox(
                      width: _deviceWidth * .3,
                      child: CustomFormField(
                        onSaved: (value) {
                          setState(() {
                            _confirmpasscode = value;
                          });
                        },
                        regEx: r".{6,}",
                        hintText: "per head",
                        initialValue: null,
                        obscureText: false,
                        height: _deviceHeight * .1,
                        keytype: TextInputType.number,
                      ),
                    ),
                    addHorizontalSpace(10),
                    const Text('per person'),
                  ],
                )
              : Container(),
          addVerticalSpace(10),
          Text(
            'Choose Date and Time',
            style: GoogleFonts.sen(
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 9, 0, 0), fontSize: 14)),
          ),

          Container(
            height: 120,
            width: _deviceWidth * .9,
            decoration: const BoxDecoration(color: Color(0xffE3EBF2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Date',
                            style: GoogleFonts.sen(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 12)),
                          ),
                          addHorizontalSpace(10),
                          ElevatedButton(
                            onPressed: () => _selectDate(context),
                            style: const ButtonStyle(
                              minimumSize: WidgetStatePropertyAll(Size(30, 30)),
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                  Color.fromARGB(255, 228, 234, 228)),
                            ),
                            child: const Icon(Icons.punch_clock),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Time',
                            style: GoogleFonts.sen(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 12)),
                          ),
                          addHorizontalSpace(10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                showPicker(
                                  context: context,
                                  value: _time,
                                  sunrise: const TimeOfDay(
                                      hour: 6, minute: 0), // optional
                                  sunset: const TimeOfDay(
                                      hour: 18, minute: 0), // optional
                                  duskSpanInMinutes: 6, // optional
                                  onChange: onTimeChanged,
                                  is24HrFormat: true,
                                ),
                              );
                            },
                            style: const ButtonStyle(
                              minimumSize: WidgetStatePropertyAll(Size(30, 30)),
                              backgroundColor: WidgetStatePropertyAll<Color>(
                                  Color.fromARGB(255, 228, 234, 228)),
                            ),
                            child: const Icon(Icons.punch_clock),
                          ),
                          // TextButton(
                          //     onPressed: () {
                          //       Navigator.of(context).push(
                          //         showPicker(
                          //           context: context,
                          //           value: _time,
                          //           sunrise: const TimeOfDay(
                          //               hour: 6, minute: 0), // optional
                          //           sunset: const TimeOfDay(
                          //               hour: 18, minute: 0), // optional
                          //           duskSpanInMinutes: 6, // optional
                          //           onChange: onTimeChanged,
                          //           is24HrFormat: true,
                          //         ),
                          //       );
                          //     },
                          //     child: const Icon(Icons.punch_clock)),
                        ],
                      ),
                    ]),
                Text(
                  "${DateFormat("E").format(validityDate)}, ${DateFormat("yMMMMd").format(validityDate)}  ${_time.format(context)}",
                  style: GoogleFonts.play(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 24)),
                ),
              ],
            ),
          ),
          // addHorizontalSpace(30),
          // Text(
          //   'Time',
          //   style: GoogleFonts.sen(
          //       textStyle: const TextStyle(color: Colors.black, fontSize: 14)),
          // ),
          //     addHorizontalSpace(10),
          //     ElevatedButton(
          //       onPressed: () => selectedTimeRTL(context),
          //       style: const ButtonStyle(
          //         minimumSize: WidgetStatePropertyAll(Size(30, 30)),
          //         backgroundColor: WidgetStatePropertyAll<Color>(
          //             Color.fromARGB(255, 228, 234, 228)),
          //       ),
          //       child: const Icon(Icons.timer_rounded),
          //     ),
          //   ],
          // ),
          // Text(
          //   '${validityTime.hour}:${validityTime.minute}',
          //   style: GoogleFonts.sen(
          //       textStyle: const TextStyle(
          //           color: Color.fromARGB(255, 9, 0, 0), fontSize: 14)),
          // ),
          addVerticalSpace(10),
          Text(
            'Rules and Instructions',
            style: GoogleFonts.sen(
                textStyle: const TextStyle(
                    color: Color.fromARGB(255, 9, 0, 0), fontSize: 14)),
          ),
          SizedBox(
              width: _deviceWidth * .9,
              height: _deviceHeight * .15,
              child: TextFormField(
                onSaved: (value) => (value) {
                  setState(() {
                    _name = value;
                  });
                },
                cursorColor: Colors.green,
                initialValue: null,
                style: const TextStyle(color: Colors.black),
                obscureText: false,
                expands: false,
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  return RegExp(r".{15,}").hasMatch(value!)
                      ? null
                      : 'Enter a valid value.';
                },
                decoration: InputDecoration(
                  fillColor: const Color(0xffE3EBF2),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Special Instruction',
                  hintStyle:
                      const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              )),

          addVerticalSpace(5),
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
    )
  }

  Widget _radio(int value) {
    SingingCharacter? character = SingingCharacter.Free;
    return Row(
      children: <Widget>[
        RadioListTile<SingingCharacter>(
          title: const Text('Free'),
          value: SingingCharacter.Free,
          groupValue: character,
          onChanged: (SingingCharacter? value) {
            setState(() {
              character = value;
            });
          },
        ),
        RadioListTile<SingingCharacter>(
          title: const Text('Paid'),
          value: SingingCharacter.Paid,
          groupValue: character,
          onChanged: (SingingCharacter? value) {
            setState(() {
              character = value;
            });
          },
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: validityDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != validityDate) {
      setState(() {
        validityDate = picked;
      });
    }
  }

  Future<void> selectedTimeRTL(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && picked != validityTime) {
      setState(() {
        validityTime = picked;
      });
    }
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
