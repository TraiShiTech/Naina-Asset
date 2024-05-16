import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:properties/app/widgets/base_container.dart';
import 'package:properties/app/with_us.dart';
import 'package:properties/core/core.dart';

import '../about_us/image_clider_controller.dart';

import '../footer/footer.dart';
import '../header/header_rent.dart';

class RentDetails extends ConsumerStatefulWidget {
  const RentDetails({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RentDetailsState();
}

class _RentDetailsState extends ConsumerState<RentDetails> {
  int limit = 2; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
  int index_imgPath = 0;
///////----------------------------------------------->
  late PageController _controller;
  int currentPage = 1;
///////----------------------------------------------->
  late ScrollController _baseController;

  final GlobalKey _headerKey = GlobalKey();
  ///////----------------------------------------------->

  List<String> images = [
    'https://images.unsplash.com/photo-1579656592043-a20e25a4aa4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1618220179428-22790b461013?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=654&q=80',
    'https://images.unsplash.com/photo-1551298370-9d3d53740c72?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1540932239986-30128078f3c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1540638349517-3abd5afc5847?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  ];

  List<String> limitedList_links = [];
  List<String> links = [
    'Homes',
    'Condominium',
    'Commercial Buildings',
    'Others',
  ];
///////----------------------------------------------->
  List data_place = [
    {
      'id': '1',
      'imageUrl': '',
      'name': 'Garden view',
      'description':
          '{100 conversations p/m},{10 websites},{2 GB data storage}',
      'descriptionSub': '{Chat widget},{Real time support}',
      'pri': '0',
      'icons': '0xe744',
    },
    {
      'id': '2',
      'imageUrl': '',
      'name': 'Kitchen',
      'description':
          '{100 conversations p/m},{10 websites},{2 GB data storage}',
      'descriptionSub': '{Chat widget},{Real time support}',
      'pri': '50',
      'icons': '0xe055',
    },
    {
      'id': '3',
      'imageUrl': '',
      'name': 'Wifi',
      'description':
          '{100 conversations p/m},{10 websites},{2 GB data storage}',
      'descriptionSub': '{Chat widget},{Real time support}',
      'pri': '90',
      'icons': '0xe05c',
    },
    {
      'id': '4',
      'imageUrl': '',
      'name': 'Pets allowed',
      'description':
          '{100 conversations p/m},{10 websites},{2 GB data storage}',
      'descriptionSub': '{Chat widget},{Real time support}',
      'pri': '160',
      'icons': '0xf04b8',
    },
    {
      'id': '5',
      'imageUrl': '',
      'name': 'Free washer - in building',
      'description':
          '{100 conversations p/m},{10 websites},{2 GB data storage}',
      'descriptionSub': '{Chat widget},{Real time support}',
      'pri': '160',
      'icons': '0xe063',
    },
  ];
  List type_Things = [
    {
      'type_id': '1',
      'type': 'House rules',
    },
    {
      'type_id': '2',
      'type': 'Health & safety',
    },
    {
      'type_id': '3',
      'type': 'Cancellation policy',
    },
  ];
  List data_Things = [
    for (int index = 0; index < 3; index++)
      {
        'type_id': '1',
        'imageUrl': '',
        'type': 'House rules',
        'name': 'Check-in: After 4:00 PM',
        'icons': '0xe73c',
      },
    for (int index = 0; index < 5; index++)
      {
        'type_id': '2',
        'imageUrl': '',
        'type': 'Health & safety',
        'name': 'Committed to Airbnb\'s enhanced cleaning process.',
        'icons': '0xe055',
      },
    {
      'type_id': '3',
      'imageUrl': '',
      'type': 'Cancellation policy',
      'name': 'Free cancellation before Feb 14',
      'icons': '0xf522',
    },
  ];
///////----------------------------------------------->
  @override
  void initState() {
    _baseController = ScrollController();
    _baseController.addListener(() {
      if (_baseController.offset > 500) {
        ref.read(scrollProvider.notifier).change(true);
      } else {
        ref.read(scrollProvider.notifier).change(false);
      }
    });
    _controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.25,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _baseController.dispose();
    super.dispose();
  }

///////----------------------------------------------->
  Future scrollToItem(GlobalKey key) async {
    await Scrollable.ensureVisible(key.currentContext!,
        duration: const Duration(milliseconds: 480));
  }

///////----------------------------------------------->

///////----------------------------------------------->
  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));

    final isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);
    final pad1 = isBigScreen
        ? 0.0
        : normalize(min: 576, max: 976, data: Metrics.width(context));
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 60;
    var _aspectRatio = _width / cellHeight;
    double plus = Metrics.isDesktop(context)
        ? 0
        : (0.5 *
            (1 - normalize(min: 976, max: 1440, data: Metrics.width(context))));
    _controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.25 + plus,
    );
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        width: Metrics.width(context),
        height: Metrics.height(context),
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _baseController,
              child: Column(
                children: [
                  Header_Rent(
                    headerKey: _headerKey,
                  ),
                  // Container(
                  //     color: brown.withOpacity(0.1), child: const Appbar()),
                  const SizedBox(height: 80),
                  Align(
                    alignment: Alignment.center,
                    child: 'Bordeaux Getaway'.poppins(
                      color: brown,
                      fontSize: 25 + 4 * pad,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child:
                          'Location address: 22 Moo 3 Tumbon Changpuak Amphor Muang Chiang Mai 50300'
                              .poppinscenter(
                        color: const Color(0xff896e57),
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 34),

                  BaseContainer(
                      child: Column(
                          crossAxisAlignment: Metrics.isMobile(context)
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: [
                        Container(
                          height: 350 + 100 * pad,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          decorativeItems[index_imgPath]
                                              .imgPath,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: (Metrics.isMobile(context) ||
                                            Metrics.isCompact(context) ||
                                            Metrics.isTablet(context))
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: Metrics.width(context),
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: white.withOpacity(0.3),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(0),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(0),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      for (int index = 0;
                                                          index < 7;
                                                          index++)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                index_imgPath =
                                                                    index;
                                                              });
                                                            },
                                                            child: AspectRatio(
                                                              aspectRatio:
                                                                  265 / 170,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child: Image
                                                                    .network(
                                                                  decorativeItems[
                                                                          index]
                                                                      .imgPath,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        : null),
                              ),
                              (Metrics.isMobile(context) ||
                                      Metrics.isCompact(context) ||
                                      Metrics.isTablet(context))
                                  ? SizedBox()
                                  : Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: Metrics.isMobile(
                                                    context)
                                                ? 1
                                                : Metrics.isCompact(context)
                                                    ? 1
                                                    : Metrics.isTablet(context)
                                                        ? 2
                                                        : 3,
                                            childAspectRatio: 285 / 220,
                                            crossAxisSpacing: 24,
                                            mainAxisSpacing: 0,
                                          ),
                                          shrinkWrap: true,
                                          // physics:
                                          //     const NeverScrollableScrollPhysics(),
                                          itemCount: 7,
                                          itemBuilder: (context, index) {
                                            final gridItem =
                                                decorativeItems[index];

                                            return Center(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    index_imgPath = index;
                                                  });
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) => AssetAll(),
                                                  //   ),
                                                  // );
                                                  // Navigator.pushReplacement(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) => Rent(),
                                                  //   ),
                                                  // );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 12 + 12 * pad),
                                                  decoration: BoxDecoration(
                                                    color: white,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20),
                                                      bottomLeft:
                                                          Radius.circular(20),
                                                      bottomRight:
                                                          Radius.circular(20),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.25),
                                                        offset:
                                                            const Offset(0, 4),
                                                        blurRadius: 4,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          AspectRatio(
                                                            aspectRatio:
                                                                265 / 170,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              child:
                                                                  Image.network(
                                                                gridItem
                                                                    .imgPath,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            bottom: 10,
                                                            left: 20,
                                                            child: Container(
                                                              // width: 150,
                                                              // height: 70,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: white,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          15),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          15),
                                                                ),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.25),
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            4),
                                                                    blurRadius:
                                                                        4,
                                                                  ),
                                                                ],
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4),
                                                              child: Center(
                                                                child:
                                                                    ' Guest favourite'
                                                                        .poppins(
                                                                  color:
                                                                      greenBg,
                                                                  fontSize: 15 +
                                                                      4 * pad,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
                        const SizedBox(height: 80),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 80),
                                          Align(
                                            alignment: Alignment.center,
                                            child:
                                                'Entire rental unit hosted by Ghazal'
                                                    .poppins(
                                              color: brown,
                                              fontSize: 25 + 4 * pad,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child:
                                                  'Location address: 22 Moo 3 Tumbon Changpuak Amphor Muang Chiang Mai 50300'
                                                      .poppinscenter(
                                                color: const Color(0xff896e57),
                                                fontWeight: FontWeight.bold,
                                                height: 1.5,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 324,
                                    height: 214,
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.25),
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 70,
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Color(0xffdbdbd0),
                                                      width: 2,
                                                    ),
                                                    top: BorderSide(
                                                      color: Color(0xffdbdbd0),
                                                      width: 2,
                                                    ),
                                                    left: BorderSide(
                                                      color: Color(0xffdbdbd0),
                                                      width: 2,
                                                    ),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: 'Naina Asset'.msMadi(
                                                    color: orange,
                                                    fontSize: 36,
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 96,
                                              height: 70,
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Color(0xffdbdbd0),
                                                    width: 2,
                                                  ),
                                                  top: BorderSide(
                                                    color: Color(0xffdbdbd0),
                                                    width: 2,
                                                  ),
                                                  left: BorderSide(
                                                    color: Color(0xffdbdbd0),
                                                    width: 2,
                                                  ),
                                                  right: BorderSide(
                                                    color: Color(0xffdbdbd0),
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    'FROM'.poppins(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                      letterSpacing: 1,
                                                      height: 1.25,
                                                    ),
                                                    '2024'.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                      letterSpacing: 0.5,
                                                      height: 1.25,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(
                                                        color:
                                                            Color(0xffdbdbd0),
                                                        width: 2,
                                                      ),
                                                      left: BorderSide(
                                                        color:
                                                            Color(0xffdbdbd0),
                                                        width: 2,
                                                      ),
                                                      right: BorderSide(
                                                        color:
                                                            Color(0xffdbdbd0),
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Column(
                                                        children: [
                                                          'FROM'.poppins(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                            letterSpacing: 1,
                                                            height: 1.25,
                                                          ),
                                                          '2024'.poppins(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 24,
                                                            letterSpacing: 0.5,
                                                            height: 1.25,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 34),
                              const SizedBox(height: 1),
                              const Divider(),
                              const SizedBox(height: 1),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child:
                                      'Come and stay in this superb duplex T2, in the heart of the historic center of Bordeaux. Spacious and bright, in a real Bordeaux building in exposed stone, you will enjoy all the charms of the city thanks to its ideal location. Close to many shops, bars and restaurants, you can access the apartment by tram A and C and bus routes 27 and 44. ...'
                                          .poppinscenter(
                                    color: const Color(0xff896e57),
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 34),
                              const SizedBox(height: 1),
                              const Divider(),
                              const SizedBox(height: 1),
                              Align(
                                alignment: Alignment.center,
                                child: 'What this place offers'.poppins(
                                  color: brown,
                                  fontSize: 25 + 4 * pad,
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: Metrics.isMobile(
                                                    context)
                                                ? 1
                                                : Metrics.isCompact(context)
                                                    ? 1
                                                    : Metrics.isTablet(context)
                                                        ? 2
                                                        : 2,
                                            childAspectRatio: _aspectRatio,
                                            crossAxisSpacing: 24,
                                            mainAxisSpacing: 24,
                                          ),
                                          shrinkWrap: true,
                                          // physics:
                                          //     const NeverScrollableScrollPhysics(),
                                          itemCount: data_place.length,
                                          itemBuilder: (context, index) {
                                            final gridItem =
                                                decorativeItems[index];

                                            return Container(
                                              decoration: BoxDecoration(
                                                color: white,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.25),
                                                    offset: const Offset(0, 4),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(4),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 20, 0),
                                                    child: Center(
                                                      child: Icon(IconData(
                                                          int.parse(
                                                              '${data_place[index]['icons']}'),
                                                          fontFamily:
                                                              'MaterialIcons')),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child:
                                                          '${data_place[index]['name']}'
                                                              .poppins(
                                                        color: black,
                                                        fontSize: 16 + 4 * pad,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(child: SizedBox())
                                  ],
                                ),
                              ),
                              const SizedBox(height: 34),
                              const SizedBox(height: 1),
                              const Divider(),
                              const SizedBox(height: 1),
                              Align(
                                alignment: Alignment.center,
                                child: 'What this place offers'.poppins(
                                  color: brown,
                                  fontSize: 25 + 4 * pad,
                                ),
                              ),
                            ],
                          ),
                        )
                      ])),
                  TypeThings(),
                  const SizedBox(height: 80),
                  const Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } ////---------------------------------------->

  Widget TypeThings() {
    List<String> imageUrls =
        type_Things.map((data) => data['imageUrl'].toString()).toList();
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));
    return Column(
      children: [
        const SizedBox(height: 80),
        SizedBox(
          height: 400 + 100 * pad,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (val) => setState(() => currentPage = val),
            itemCount: type_Things.length,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 36 * pad, right: 36 * pad),
                child: AnimatedScale(
                    duration: const Duration(milliseconds: 240),
                    scale: currentPage == index ? 1 : 0.75,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 36 * pad, right: 36 * pad, bottom: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: '${type_Things[index]['type']}'.poppins(
                              color: black,
                              fontSize: 25 + 4 * pad,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              color: white,
                              // border: Border.all(
                              //     color: Color.fromARGB(255, 216, 213, 213),
                              //     width: 1),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color:
                              //         const Color.fromARGB(255, 180, 175, 175)
                              //             .withOpacity(0.5),
                              //     spreadRadius: 3,
                              //     blurRadius: 4,
                              //     offset: Offset(
                              //         0, 4), // changes position of shadow
                              //   ),
                              // ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (int index3 = 0;
                                    index3 < data_Things.length;
                                    index3++)
                                  if (data_Things[index3]['type_id'] ==
                                      type_Things[index]['type_id'])
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 20, 0),
                                            child: Center(
                                              child: Icon(IconData(
                                                  int.parse(
                                                      '${data_Things[index3]['icons']}'),
                                                  fontFamily: 'MaterialIcons')),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child:
                                                  '${data_Things[index3]['name']}'
                                                      .poppins(
                                                color: black,
                                                fontSize: 14 + 4 * pad,
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
                      ],
                    )),
              );
            },
          ),
        ),
        const SizedBox(height: 34),
        ImageSliderController(
          currentPage: currentPage,
          images: imageUrls,
          prev: currentPage != 0
              ? () {
                  _controller.animateToPage(
                    currentPage - 1,
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.linear,
                  );
                }
              : null,
          next: (currentPage != type_Things.length - 1)
              ? () {
                  _controller.animateToPage(
                    currentPage + 1,
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.linear,
                  );
                }
              : null,
        ),
      ],
    );
  }
}
