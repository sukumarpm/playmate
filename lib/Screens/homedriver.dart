import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:playmate/Screens/gettermcond.dart';
import 'package:playmate/Screens/home.dart';
import 'package:playmate/Screens/mydrawer.dart';
import 'package:playmate/Screens/postgame.dart';
import 'package:playmate/Services/navigation_service.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeDriver extends StatefulWidget {
  const HomeDriver({super.key});

  @override
  State<HomeDriver> createState() => _HomeDriverState();
}

class _HomeDriverState extends State<HomeDriver> with TickerProviderStateMixin {
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;
  late AnimationController controller;
  late AnimationController _controller;
  late bool _isVisible = true;
  late Widget _child;
  late Widget _child1;

  String imageurl = 'lib/assets/images/onboard/IMG-20160221-WA0003.jpg';
  int _tabIndex = 1;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  late PageController pageController;
  late ScrollController controller1;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
    controller = BottomSheet.createAnimationController(this);
    // Animation duration for displaying the BottomSheet
    controller.duration = const Duration(seconds: 1);
    // Animation duration for retracting the BottomSheet
    controller.reverseDuration = const Duration(seconds: 1);
    // Set animation curve duration for the BottomSheet
    controller.drive(CurveTween(curve: Curves.easeIn));
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 15000),
    );
    _child = const CircleAvatar(
      radius: 35,
      backgroundColor: Colors.black,
      child: Icon(
        Icons.arrow_circle_down,
        size: 70,
        shadows: [BoxShadow(color: Colors.black)],
        color: Colors.red,
      ),
    );
    _child1 = const CircleAvatar(
      radius: 70,
      backgroundColor: Colors.green,
      child: CircleAvatar(
        backgroundImage: AssetImage("lib/assets/Images/1653200096.jpg"),
        radius: 65,
      ),
    );
    pageController = PageController(initialPage: _tabIndex);
    controller1 = ScrollController();
    // if (kDebugMode) {
    //   print('profiledata:${c.profiledata}');
    // }
    controller1.addListener(() {
      // if (kDebugMode) {
      //   print(_isVisible);
      // }
      setState(() {
        _isVisible =
            controller1.position.userScrollDirection == ScrollDirection.forward;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       Text(
      //         'இலங்கை வானொலி',
      //         style: TextStyle(color: Colors.white),
      //       ),
      //       // Icon(Icons.share, color: Color.fromARGB(255, 22, 0, 0)),
      //     ],
      //   ),
      //   iconTheme: const IconThemeData(
      //     size: 32, //change size on your need
      //     color: Colors.black, //change color on your need
      //   ),
      //   backgroundColor: Colors.lightBlue,
      //   actions: const [
      //     Icon(Icons.share, color: Color.fromARGB(255, 22, 0, 0)),
      //   ],
      // ),
      drawer: const MyDrawer(),
      body: PageView(
        controller: pageController,
        onPageChanged: (v) {
          tabIndex = v;
        },
        children: const [
          // const Imageup(),
          PostGame(),
          Home(),
          GetTermsConditions(),
          //const Imageup(),
        ],
      ),
      extendBody: true,
      // floatingActionButton: (c.isAdmin.isTrue)
      //     ? FloatingActionButton(
      //         onPressed: () => const Payment(),
      //         tooltip: 'Shopping Bag',
      //         child: const Icon(Icons.add),
      //       )
      //     : null,
      // bottomNavigationBar: BottomAppBar(
      //   padding: const EdgeInsets.symmetric(horizontal: 10),
      //   height: 60,
      //   color: Colors.cyan.shade400,
      //   shape: const CircularNotchedRectangle(),
      //   notchMargin: 5,
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       IconButton(
      //         icon: const Icon(
      //           Icons.menu,
      //           color: Colors.black,
      //         ),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: const Icon(
      //           Icons.search,
      //           color: Colors.black,
      //         ),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: const Icon(
      //           Icons.print,
      //           color: Colors.black,
      //         ),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: const Icon(
      //           Icons.people,
      //           color: Colors.black,
      //         ),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      // )
      bottomNavigationBar: Offstage(
        offstage: !_isVisible,
        child: CircleNavBar(
          activeIcons: const [
            Icon(Icons.person, size: 30, color: Colors.white),
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.chat_bubble_outline, size: 30, color: Colors.white),
          ],
          inactiveIcons: [
            // const Text(
            //   "Profile",
            //   style:
            //       TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            // ),
            Column(
              children: [
                const Icon(
                  Icons.person_2,
                  color: Colors.grey,
                ),
                Text(
                  'Profile',
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12)),
                ),
              ],
            ),
            Column(
              children: [
                const Icon(
                  Icons.home_filled,
                  color: Colors.grey,
                ),
                Text(
                  'Home',
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12)),
                ),
              ],
            ),
            Column(
              children: [
                const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.grey,
                ),
                Text(
                  'Message',
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12)),
                ),
              ],
            ),
          ],
          color: Colors.white,
          circleColor: Colors.white,
          height: 75,
          circleWidth: 60,
          activeIndex: tabIndex,
          onTap: (index) {
            tabIndex = index;
            pageController.jumpToPage(tabIndex);
          },
          // tabCurve: ,
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          cornerRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
          shadowColor: Colors.deepPurple,
          circleShadowColor: Colors.deepPurple,
          elevation: 10,
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // colors: [
            //   Color.fromARGB(255, 1, 8, 0),
            //   Color.fromARGB(255, 56, 50, 49),
            //   Color.fromARGB(255, 237, 249, 5)
            // ],
            // colors: [
            //   Color.fromARGB(255, 27, 3, 135),
            //   Color.fromARGB(255, 94, 83, 81),
            //   Color.fromARGB(255, 15, 12, 174)
            colors: [
              Color.fromARGB(255, 3, 4, 11),
              Color.fromARGB(255, 139, 177, 127),
              // Color.fromARGB(255, 38, 16, 13),
              // Color.fromARGB(255, 193, 193, 240)
            ],
          ),
          circleGradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF9cd936), Color.fromARGB(255, 116, 155, 87)],
          ),
        ),
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: FloatingActionButton(
      //   // isExtended: true,
      //   backgroundColor: Colors.green,
      //   onPressed: () {
      //     setState(() {
      //       showDialog(
      //           context: context,
      //           builder: (BuildContext context) {
      //             return AlertDialog(
      //                 title: const Text(
      //                   'Any queries?. Contact Us',
      //                   style: TextStyle(fontSize: 16),
      //                 ),
      //                 content: ElevatedButton(
      //                     style: ButtonStyle(
      //                         backgroundColor: WidgetStateProperty.all<Color>(
      //                             Colors.green.shade400)),
      //                     onPressed: () {},
      //                     child: const Text(
      //                       'Phone: +91 76453 65298',
      //                       style: TextStyle(color: Colors.black),
      //                     )));
      //           });
      //     });
      //   },
      //   // isExtended: true,
      //   child: const Icon(
      //     Icons.contact_support,
      //     size: 55,
      //   ),
      // ),
    );
  }

  Widget buildUpgradeButton() => TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.greenAccent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            side: BorderSide(
              color: Color.fromARGB(255, 229, 240, 246),
              width: 1,
            ),
          ),
        ),
        onPressed: () {
          _navigationService.pushNamed("/login");
        },
        child: const Text(
          'இன்றைய நிகழ்ச்சிகள்',
          style: TextStyle(fontSize: 22),
        ),
      );
}
