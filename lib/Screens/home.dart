import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:playmate/Services/auth_service.dart';
import 'package:playmate/Services/navigation_service.dart';
import 'package:playmate/Utilities/mycontroller.dart';
import 'package:playmate/Utilities/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double _deviceHeight;
  late double _deviceWidth;
  late String userWork = '533,2th street, Kochi,Kerala';
  List categoryImage = [
    {
      'url': 'lib/assets/images/onboard/arnold-roy-x-1MZu3-cak-unsplash.jpg',
      'title': 'Cricket',
      'price': '90.00',
    },
    {
      'url': 'lib/assets/images/onboard/DVResort3.jpg',
      'title': 'Football',
      'price': '85.00',
    },
    {
      'url': 'lib/assets/images/onboard/arnold-roy-x-1MZu3-cak-unsplash.jpg',
      'title': 'Hockey',
      'price': '90.00',
    },
    {
      'url': 'lib/assets/images/onboard/DVResort3.jpg',
      'title': 'Chess',
      'price': '85.00',
    },
    {
      'url': 'lib/assets/images/onboard/DVResort3.jpg',
      'title': 'Tennis',
      'price': '85.00',
    },
  ];
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;
  late AuthService _auth;
  Map<String, dynamic> registerData = {};
  final MyController c = Get.put(MyController());
  late Map<dynamic, dynamic> userdata;

  @override
  void initState() {
    super.initState();
    _auth = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    userdata = c.profiledata;
    print('userdata @home:$userdata');
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    TextTheme textTheme = Theme.of(context).textTheme;
    ElevatedButtonThemeData ebuttonTheme =
        Theme.of(context).elevatedButtonTheme;
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // Image.asset(
                                //   'lib/assets/images/user/icones/burger menu.png',
                                //   fit: BoxFit.cover,
                                //   color: Colors.grey,
                                // ),
                                // addHorizontalSpace(25),
                                Container(
                                  width: _deviceWidth * .4,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24),
                                      bottomRight: Radius.circular(24),
                                      bottomLeft: Radius.circular(24),
                                    ),
                                    color: Colors.black,
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_sharp,
                                        color: Colors.white,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'DELIVER TO',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          userWork.isNotEmpty
                                              ? Wrap(children: <Widget>[
                                                  Text(
                                                    '${userWork.substring(1, 15)} ...',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    // textDirection: TextDirection.rtl,
                                                    // textAlign: TextAlign.justify,
                                                  ),
                                                ])
                                              : const Wrap(children: <Widget>[
                                                  Text(
                                                    '',
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    // textDirection: TextDirection.rtl,
                                                    // textAlign: TextAlign.justify,
                                                  ),
                                                ])
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  child: Icon(
                                    Icons.notifications_active,
                                    size: 35,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                  onTap: () {},
                                ),
                                addHorizontalSpace(16),
                                GestureDetector(
                                    child: const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.green,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "lib/assets/images/onboard/IMG-20171023-WA0008.jpg"),
                                    radius: 65,
                                  ),
                                )),
                                // GestureDetector(
                                //     onTap: () {
                                //       _auth.logout();
                                //       Get.snackbar('Thanks!.',
                                //           'You are logged out successfully!',
                                //           barBlur: 1,
                                //           backgroundColor: Colors.white,
                                //           margin: const EdgeInsets.all(20),
                                //           duration: const Duration(seconds: 5),
                                //           snackPosition: SnackPosition.BOTTOM);
                                //       _navigationService
                                //           .pushReplacedNamed("/login");
                                //     },
                                //     child: const Icon(
                                //       Icons.logout_rounded,
                                //       size: 36,
                                //       color: Colors.red,
                                //     )),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Welcome,${userdata['_name']}!',
                                  style: const TextStyle(
                                      color: Colors.black45, fontSize: 24),
                                ),
                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.search,
                                      size: 35,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  onTap: () async {},
                                ),
                              ],
                            ),
                          ],
                        ),
                        // const HorizontalCouponExample2(),
                        addVerticalSpace(8),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'You may like..',
                            ),
                            addVerticalSpace(8),
                            Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                height: _deviceWidth * .7,
                                child: ListView.builder(
                                    itemCount: categoryImage.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      int key = index;
                                      return GestureDetector(
                                        child: SizedBox(
                                          width: _deviceWidth * .75,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: _deviceWidth * .6,
                                                child: Card(
                                                  semanticContainer: true,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40.0),
                                                  ),
                                                  elevation: 5,
                                                  margin:
                                                      const EdgeInsets.all(10),
                                                  child: Image.asset(
                                                    categoryImage[index]['url'],
                                                    fit: BoxFit.cover,
                                                    color:
                                                        const Color(0xFF9cd936),
                                                    colorBlendMode:
                                                        BlendMode.dst,
                                                  ),
                                                  //     CachedNetworkImage(
                                                  //   imageUrl:
                                                  //       categoryImage[index]
                                                  //           ['url'],
                                                  //   imageBuilder: (context,
                                                  //           imageProvider) =>
                                                  //       Container(
                                                  //     width: 80.0,
                                                  //     height: 80.0,
                                                  //     decoration: BoxDecoration(
                                                  //       shape: BoxShape.circle,
                                                  //       image: DecorationImage(
                                                  //           image:
                                                  //               imageProvider,
                                                  //           fit: BoxFit.cover),
                                                  //     ),
                                                  //   ),
                                                  //   placeholder: (context,
                                                  //           url) =>
                                                  //       const CircularProgressIndicator(),
                                                  //   errorWidget: (context, url,
                                                  //           error) =>
                                                  //       const Icon(Icons.error),
                                                  // ),
                                                ),
                                              ),
                                              Text(
                                                  categoryImage[index]['title'])
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          print(categoryImage[index]['title']);
                                        },
                                      );
                                    })),
                          ],
                        ),
                        const Divider(
                          height: 1,
                        ),
                        addVerticalSpace(8),
                        SizedBox(
                          height: _deviceHeight,
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CustomScrollView(
                                    slivers: [
                                      const SliverToBoxAdapter(
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text('Today' 's Order'),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      for (int i = 0;
                                          i < categoryImage.length;
                                          i++)
                                        SliverPadding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 4),
                                          sliver: SliverList(
                                            delegate: SliverChildBuilderDelegate(
                                                childCount: categoryImage
                                                    .length, //extend by 1 for header
                                                (context, index) {
                                              return index == 0
                                                  ? SizedBox(
                                                      height: 350,
                                                      width: 120,
                                                      child: SizedBox(
                                                        width: 335,
                                                        height: 174,
                                                        child: Card(
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        45.0),
                                                          ),
                                                          elevation: 5,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                width: 335,
                                                                height: 180,
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          100,
                                                                      child: Image
                                                                          .asset(
                                                                        categoryImage[i]
                                                                            [
                                                                            'url'],
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                    const Text(
                                                                        'hello there')
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 16,
                                                              ),
                                                              const Column(
                                                                  children: [
                                                                    Text(
                                                                        'Title'),
                                                                    Text(
                                                                        'Subtitle')
                                                                  ])
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container();
                                            }),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 40,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 1,
                      spreadRadius: -20,
                      offset: Offset(1.0, 0.0),
                    )
                  ],
                  color: Color(0xffF6F8FA),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(10), // Image radius
                        child: Image.asset(
                            'lib/assets/images/admin/navigation bar/icone.png',
                            fit: BoxFit.contain),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(10), // Image radius
                          child: Image.asset(
                              'lib/assets/images/admin/navigation bar/barger menu.png',
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(10), // Image radius
                          child: Image.asset(
                              'lib/assets/images/user/icones/add.png',
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(10), // Image radius
                          child: Image.asset(
                              'lib/assets/images/admin/navigation bar/notification.png',
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(10), // Image radius
                          child: Image.asset(
                              'lib/assets/images/admin/navigation bar/profile.png',
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          backgroundColor: Colors.green,
          onPressed: () {
            setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: const Text(
                          'Any queries?. Contact Us',
                          style: TextStyle(fontSize: 16),
                        ),
                        content: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Colors.green.shade400)),
                            onPressed: () {},
                            child: const Text(
                              'Phone: +91 76453 65298',
                              style: TextStyle(color: Colors.black),
                            )));
                  });
            });
          },
          // isExtended: true,
          child: const Icon(
            Icons.contact_support,
            size: 55,
          ),
        ),
      ),
    );
  }
}
