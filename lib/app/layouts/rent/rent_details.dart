import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:properties/app/widgets/base_container.dart';
import 'package:properties/app/with_us.dart';
import 'package:properties/core/core.dart';
import 'package:properties/core/theme/app_colors.dart';

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

  List<String> title = [
    'Decorations &\n Renovations',
    'Photography &\n Listing',
    'Guest \n Communications',
    'Cleaning &\n Maintenance',
  ];
  List<String> images = [
    'https://s3-alpha-sig.figma.com/img/f477/4294/2841c937d8b24966c3412826595763f2?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oawp-dyDFaADsZLx9dKvWaB3MjbTbuWdTKH2GnWFrl~VxDFKborw3zV96wjilbmdJPnx4~R4wO9ya5dL~f2G5n0DZKdIZvpt9GV2IAWJxVq4CgfFHsrekkQrVTeWoc6TvlKtvr2qkzyZQ2t-9AhEpXUypNSsbfXUXIB73WzrOzICaSEJ8hsug4Nx71xHbEaZZS1guLHv~qlFNi19LloRIHSBUaavkz3TGILRpCDoUflZZCL40uR60p4db12EsnAQngDZmPm6bvTyc5h5cndza0SjwShbOC6sEgt2G0N~eLTLU7wEp6oOG-lZVnwxUj7T2mJu5A0CpQckgPOHuV0~Rg__',
    'https://s3-alpha-sig.figma.com/img/7bda/143f/e5a98a6fe7b614f448514de91a6f75c2?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=S6m2PtH5ICHxiyhq6pYhNbxQUHVUWnkaHH0K3hYoUs3Jr4AJVxs4fFZZLQd4ZyO056wVNR0aXUWqpXcHCMxLvnurLZN3cVnMv-Ud7V~oL5X7R6QSzFlXl7URGE9meZf7M89NTfFUKowtjXxoFv0NH23bEPdKFMnK7eo5xtnPwnM5~SS0ftoG3JAb4FV~21WS9N7X7ZK7NjEFuY5MpsOUU2LNRAWc4uwUy4R0lShaGqqsOkIDe23lmls34dvmhBXbPg-dWraPzCdrPAMsVh6vV7QFnRYbYjmx57i06kF7IeORq9HD6GsocO96b3RGtEGn0a3jW0w790g1q8pSHPYLCg__',
    'https://s3-alpha-sig.figma.com/img/5e7a/95c4/8a9dd8afc379f258b23cc4fc928b75c0?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=X9g~6TCf1mu4~dyXOMaQJfF3ic8ce6ezQCRRN6~w2Q-EdaJ0gqrEpVuWkJu86k9XysWA61ZuinqApq7AiU~HwZSy6Pcp5A7aUnjUbvS0Y1dhtGx7DZ1R9Te~K4CeJkHGBG0UNl1U30JiiLXyzxHovQSdnbmsLX6vClU-kgyOVruEgHm1Sgz6XfzPN3uMfeH~Nxt92TCOpg99D6ZRxhXPrDodntQDPpWZ5vneCKMf1re2p1nY24wWwEkYhF2g4-kk8c3QN9FKwCuJ-jIt-Q9JPQECEb45Uytr1Au1NaHnH-cXvKg6DPnFZJoSR~HG7-mzkuDkqmktOkaWYV7-zhUj3w__',
    'https://s3-alpha-sig.figma.com/img/248c/9403/08be956057a64cc8e78ca17e8bb7dd0d?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Jrj48c60uvOZQFA1wZZtAMlI41-m6yCRMcHgsdlQlAAglcJO3V3nwAVuMv3iFrstUns~xabHhdnbrB2sf1En7Gk4vvTQfrIamU-gy8MVcrbt3djVwb1DTWNDyBs~MyNFOlOkWg5SKMKAu-XAl6f3~KCbkzExhcFDz3xUh8CTmQ3rcaj-nLm4EHBeE8OAHPFTVKyiQtKv-rfaHbEkrRM2LjllXR0cEoFhzatk0qo3Zc91y1hzKuLKeVBHPgACQQK3cdFi00l9FNHK57Mm0o-N1jhAWfT4hynF~GXu3QtNW7tRffh7aU5cB8-kJtDRfb4yp5HeazlJrEiXJcJ2IDjBXA__',
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
      'description': '{100 conversations p/m},{10 websites},{2 GB data storage}',
      'descriptionSub': '{Chat widget},{Real time support}',
      'pri': '0',
      'icons': '0xe744',
    },
    {
      'id': '2',
      'imageUrl': '',
      'name': 'Kitchen',
      'description': '{100 conversations p/m},{10 websites},{2 GB data storage}',
      'descriptionSub': '{Chat widget},{Real time support}',
      'pri': '50',
      'icons': '0xe055',
    },
    {
      'id': '3',
      'imageUrl': '',
      'name': 'Wifi',
      'description': '{100 conversations p/m},{10 websites},{2 GB data storage}',
      'descriptionSub': '{Chat widget},{Real time support}',
      'pri': '90',
      'icons': '0xe05c',
    },
    {
      'id': '4',
      'imageUrl': '',
      'name': 'Pets allowed',
      'description': '{100 conversations p/m},{10 websites},{2 GB data storage}',
      'descriptionSub': '{Chat widget},{Real time support}',
      'pri': '160',
      'icons': '0xf04b8',
    },
    {
      'id': '5',
      'imageUrl': '',
      'name': 'Free washer - in building',
      'description': '{100 conversations p/m},{10 websites},{2 GB data storage}',
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
    await Scrollable.ensureVisible(key.currentContext!, duration: const Duration(milliseconds: 480));
  }

///////----------------------------------------------->

///////----------------------------------------------->
  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));

    final isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);
    final pad1 = isBigScreen ? 0.0 : normalize(min: 576, max: 976, data: Metrics.width(context));
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) / _crossAxisCount;
    var cellHeight = 60;
    var _aspectRatio = _width / cellHeight;
    double plus =
        Metrics.isDesktop(context) ? 0 : (0.5 * (1 - normalize(min: 976, max: 1440, data: Metrics.width(context))));
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
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: 'Bordeaux Getaway'.poppins(
                            color: black,
                            fontSize: 25 + 4 * pad,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:
                              'Location address: 22 Moo 3 Tumbon Changpuak Amphor Muang Chiang Mai 50300'.poppinscenter(
                            color: Color.fromRGBO(69, 69, 69, 1),
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 34),

                  BaseContainer(
                      child: Column(
                          crossAxisAlignment:
                              Metrics.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                          children: [
                        // Container(
                        //   height: 350 + 100 * pad,
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: Container(
                        //             decoration: BoxDecoration(
                        //               borderRadius: const BorderRadius.only(
                        //                 topLeft: Radius.circular(20),
                        //                 topRight: Radius.circular(20),
                        //                 bottomLeft: Radius.circular(20),
                        //                 bottomRight: Radius.circular(20),
                        //               ),
                        //               image: DecorationImage(
                        //                 image: NetworkImage(
                        //                   decorativeItems[index_imgPath].imgPath,
                        //                 ),
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //             child: (Metrics.isMobile(context) ||
                        //                     Metrics.isCompact(context) ||
                        //                     Metrics.isTablet(context))
                        //                 ? Column(
                        //                     mainAxisAlignment: MainAxisAlignment.end,
                        //                     children: [
                        //                       Container(
                        //                         width: Metrics.width(context),
                        //                         height: 100,
                        //                         decoration: BoxDecoration(
                        //                           color: white.withOpacity(0.3),
                        //                           borderRadius: const BorderRadius.only(
                        //                             topLeft: Radius.circular(0),
                        //                             topRight: Radius.circular(0),
                        //                             bottomLeft: Radius.circular(0),
                        //                             bottomRight: Radius.circular(0),
                        //                           ),
                        //                         ),
                        //                         padding: const EdgeInsets.all(2.0),
                        //                         child: SingleChildScrollView(
                        //                           scrollDirection: Axis.horizontal,
                        //                           child: Row(
                        //                             children: [
                        //                               for (int index = 0; index < 7; index++)
                        //                                 Padding(
                        //                                   padding: const EdgeInsets.all(8.0),
                        //                                   child: InkWell(
                        //                                     onTap: () {
                        //                                       setState(() {
                        //                                         index_imgPath = index;
                        //                                       });
                        //                                     },
                        //                                     child: AspectRatio(
                        //                                       aspectRatio: 265 / 170,
                        //                                       child: ClipRRect(
                        //                                         borderRadius: BorderRadius.circular(20),
                        //                                         child: Image.network(
                        //                                           decorativeItems[index].imgPath,
                        //                                           fit: BoxFit.cover,
                        //                                         ),
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                 ),
                        //                             ],
                        //                           ),
                        //                         ),
                        //                       )
                        //                     ],
                        //                   )
                        //                 : null),
                        //       ),
                        //       (Metrics.isMobile(context) || Metrics.isCompact(context) || Metrics.isTablet(context))
                        //           ? SizedBox()
                        //           : Expanded(
                        //               child: Container(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: GridView.builder(
                        //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //                     crossAxisCount: Metrics.isMobile(context)
                        //                         ? 1
                        //                         : Metrics.isCompact(context)
                        //                             ? 1
                        //                             : Metrics.isTablet(context)
                        //                                 ? 2
                        //                                 : 3,
                        //                     childAspectRatio: 285 / 220,
                        //                     crossAxisSpacing: 24,
                        //                     mainAxisSpacing: 0,
                        //                   ),
                        //                   shrinkWrap: true,
                        //                   // physics:
                        //                   //     const NeverScrollableScrollPhysics(),
                        //                   itemCount: 7,
                        //                   itemBuilder: (context, index) {
                        //                     final gridItem = decorativeItems[index];

                        //                     return Center(
                        //                       child: InkWell(
                        //                         onTap: () {
                        //                           setState(() {
                        //                             index_imgPath = index;
                        //                           });
                        //                           // Navigator.push(
                        //                           //   context,
                        //                           //   MaterialPageRoute(
                        //                           //     builder: (context) => AssetAll(),
                        //                           //   ),
                        //                           // );
                        //                           // Navigator.pushReplacement(
                        //                           //   context,
                        //                           //   MaterialPageRoute(
                        //                           //     builder: (context) => Rent(),
                        //                           //   ),
                        //                           // );
                        //                         },
                        //                         child: Container(
                        //                           margin: EdgeInsets.only(bottom: 12 + 12 * pad),
                        //                           decoration: BoxDecoration(
                        //                             color: white,
                        //                             borderRadius: const BorderRadius.only(
                        //                               topLeft: Radius.circular(20),
                        //                               topRight: Radius.circular(20),
                        //                               bottomLeft: Radius.circular(20),
                        //                               bottomRight: Radius.circular(20),
                        //                             ),
                        //                             boxShadow: [
                        //                               BoxShadow(
                        //                                 color: Colors.grey.withOpacity(0.25),
                        //                                 offset: const Offset(0, 4),
                        //                                 blurRadius: 4,
                        //                               ),
                        //                             ],
                        //                           ),
                        //                           child: Column(
                        //                             crossAxisAlignment: CrossAxisAlignment.stretch,
                        //                             children: [
                        //                               Stack(
                        //                                 children: [
                        //                                   AspectRatio(
                        //                                     aspectRatio: 265 / 170,
                        //                                     child: ClipRRect(
                        //                                       borderRadius: BorderRadius.circular(20),
                        //                                       child: Image.network(
                        //                                         gridItem.imgPath,
                        //                                         fit: BoxFit.cover,
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                   Positioned(
                        //                                     bottom: 10,
                        //                                     left: 20,
                        //                                     child: Container(
                        //                                       // width: 150,
                        //                                       // height: 70,
                        //                                       decoration: BoxDecoration(
                        //                                         color: white,
                        //                                         borderRadius: const BorderRadius.only(
                        //                                           topLeft: Radius.circular(15),
                        //                                           topRight: Radius.circular(15),
                        //                                           bottomLeft: Radius.circular(15),
                        //                                           bottomRight: Radius.circular(15),
                        //                                         ),
                        //                                         boxShadow: [
                        //                                           BoxShadow(
                        //                                             color: Colors.grey.withOpacity(0.25),
                        //                                             offset: const Offset(0, 4),
                        //                                             blurRadius: 4,
                        //                                           ),
                        //                                         ],
                        //                                       ),
                        //                                       padding: const EdgeInsets.all(4),
                        //                                       child: Center(
                        //                                         child: ' Guest favourite'.poppins(
                        //                                           color: greenBg,
                        //                                           fontSize: 15 + 4 * pad,
                        //                                         ),
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                 ],
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     );
                        //                   },
                        //                 ),
                        //               ),
                        //             )
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 60),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: FractionallySizedBox(
                                widthFactor: 0.85,
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                  child: AspectRatio(
                                    aspectRatio: 6 / 2,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Image.network(
                                          'https://s3-alpha-sig.figma.com/img/33e7/8912/bbfb42ca5051f5492bcbda4a216dccc6?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=hddtucuDPySfPy9TYtKRK-kcquj4x-19PrT84oV8tG84ldiFB3wtiqQdl7voK7S~vvLzbZavsvfyQXI5pg1e-9rzfMdlDcqgF17hkx59LGstr~LX2LwQfLuM-~5ZVZlmPjjMTddvMPGwIf-FMv7Cmck9GfCZuJsSUlnFqVONYngvyl85BS-it8MJwknzLeKxa10QmTsl6j9IbPr~45NsfHmntsSRJFRal6KzKRnZZVXcC8EgNXwGWMBGzsNJUoGcmilKNJATJjds0z5MsSEV285RJqMJb1eApzgURLX0HwoYxvb0HT0buqRFepSKADJmlOhRLyLXA19XqjhEuhOsew__',
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Image.network(
                                                      'https://s3-alpha-sig.figma.com/img/7e95/b547/ccb35f41cb8bca5561addab0467b9ce5?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=M46LnKoZ2MYCj98yo9muCed7i9apYw1AJakRNLfHXXOiaSInvt7v5vvWCAoFeZBlBiZazOKh3cEt~BAxUcsPqBCK6F2TU8JTtI~vOsmQ~rC4zwbStcVJIisZCOjPdZzUzYly9S0zM7HH51GCq0U6KvFj8vzFRdp8zE42o8TxqwJzRT6tENaU02WS8jhm4vDEyOdhp82II86rwtEHEvjWwTdMj62WQXFIn0gBEVfRH06ZneSvmY9r6hXiNzU2DcFZwH2F-2-o0nWY90xT6XMGOCO4dxedc0pIS4gBukZeSSPZgal1syCFLX8dBaRVfiF7bUkMJIiBEf3UZyYQFpj9KQ__',
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment.center,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Image.network(
                                                      'https://s3-alpha-sig.figma.com/img/9c03/7428/fcc8ee64fe9d947569d78c1eb2e26259?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=eMsXC2OpkDSiWH~SjNfXRhCldp~xLhqNKxUh3I7KzaFKoLgCvUIlOkZumXymm82a1hJD0tjpDqeVTC-NoP-l7Rsqkwknd5dIeaGYa9Sv04eOSPGWk8lOKiMyV1NExbcLqyIGChsfwktByxljWQ-Ui3fMsSmBg0uX1JAyOrvxYRPft1MZyAe6l-jsxC6j9zmONdpHuULu118J7Og4TeFuWVPyoWAOMD~EqNEiJviar8XqAFWykJP~xpuBbyAv5DLIi-cTTk6lBVM-jcSIALx62wuqxJR1lfhf8~rbmwH6JJLu0cVtubrffyXkXV3~xD12WVUGlxUtS1WGq6YLIJ~YnQ__',
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Image.network(
                                                      'https://s3-alpha-sig.figma.com/img/079e/23bf/4bb90ff22235b7665fc3ca85d2c34b28?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=lqvfOssU6vi4SmjXqoX2f5gYEOAvYEqIbZTjSWXBu1oOaKq0sS68p~tIs3jjGS-h-CBk9WFB~gBJO8EWsUKxMVu9jqxTS5Se4Q-TvwkFQolI2vqDbFeyfwOcCQFoxrEURnLumQMKzlRxRbOUEpSsnO4Wr7f4P9zxgm1TTfwTWY2WrTeJ96t9xU5CNGf5To2dDIvFzecUEuvgOAd0OroHQuwQ628daC7mj5OYMSobwbFGiVjVuo4adW56yMsEKLChL1fqFZ9NkwM7iILXnLOt9I~GERRbXGV0cegIJXUWcPPCkMXtHou5mOLCPeiOEU7DyXvnY5krpcebDNXcVpFafA__',
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment.center,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child:
                                                        // Container(
                                                        //     padding: EdgeInsets.all(10),
                                                        //     decoration: BoxDecoration(
                                                        //         image: DecorationImage(
                                                        //       image: NetworkImage(
                                                        //           'https://s3-alpha-sig.figma.com/img/5297/e89b/bda05c1478e165e64250f76d43531d98?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mx3lJSakSQOUoaNcb5~fok0YiVuP1R2-1TtdzWhf0gbraL4qRO-JztGB2PH3fDUJf6UNlyhQZ0E~DedPI-wyhYb0OgLrAFjLIgcMTKtd91LXdYys8OPPcRAPq-cT8AUWNpCxCRkWnGvLJjTjdf5JONOyRqLtM5oZvhCLHWvHLlWD-sS1O2HZSKagOyL8zcB5ixakywktEw19GwpAKFJfwNBiQPStpfmzjrY-VQXwsrGKlZE1gWi9Ir95i7nD75px-GhPz2NpR7fvuQoQnx-saNTnKc8RNafno~W7gYUsGREDzFjogDk-sL2NWbdAfIlBhylc~Eu9Pvd9QkLBSRuTaw__'),
                                                        //       fit: BoxFit.cover,
                                                        //       alignment: Alignment.center,
                                                        //     )),
                                                        //     child: Container(
                                                        //       decoration: BoxDecoration(
                                                        //           color: white, borderRadius: BorderRadius.circular(10)),
                                                        //       child: Row(
                                                        //         children: [
                                                        //           Icon(Icons.auto_awesome_mosaic_outlined),
                                                        //           'Show all photo'.poppins(fontWeight: FontWeight.w600)
                                                        //         ],
                                                        //       ),
                                                        //     )),
                                                        Image.network(
                                                      'https://s3-alpha-sig.figma.com/img/5297/e89b/bda05c1478e165e64250f76d43531d98?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mx3lJSakSQOUoaNcb5~fok0YiVuP1R2-1TtdzWhf0gbraL4qRO-JztGB2PH3fDUJf6UNlyhQZ0E~DedPI-wyhYb0OgLrAFjLIgcMTKtd91LXdYys8OPPcRAPq-cT8AUWNpCxCRkWnGvLJjTjdf5JONOyRqLtM5oZvhCLHWvHLlWD-sS1O2HZSKagOyL8zcB5ixakywktEw19GwpAKFJfwNBiQPStpfmzjrY-VQXwsrGKlZE1gWi9Ir95i7nD75px-GhPz2NpR7fvuQoQnx-saNTnKc8RNafno~W7gYUsGREDzFjogDk-sL2NWbdAfIlBhylc~Eu9Pvd9QkLBSRuTaw__',
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Center(
                              child: FractionallySizedBox(
                                widthFactor: 0.9,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: FractionallySizedBox(
                                          widthFactor: 0.9,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              'Entire rental unit hosted by Ghazal'.poppins(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600,
                                                  textAlign: TextAlign.start),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: '2 guests'.poppins(fontWeight: FontWeight.w500),
                                                  ),
                                                  Icon(
                                                    Icons.circle,
                                                    size: 2,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: '1 bedroom'.poppins(fontWeight: FontWeight.w500),
                                                  ),
                                                  Icon(
                                                    Icons.circle,
                                                    size: 2,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: '1 bed'.poppins(fontWeight: FontWeight.w500),
                                                  ),
                                                  Icon(
                                                    Icons.circle,
                                                    size: 2,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: '1 bath'.poppins(fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 20),
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(16.0),
                                                      child: Icon(
                                                        Icons.home_filled,
                                                        color: black,
                                                        size: 30,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          'Entire home'.poppins(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600,
                                                              textAlign: TextAlign.start),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                            child: 'You’ll have the apartment to yourself'.poppins(
                                                              color: Color.fromRGBO(107, 114, 128, 1),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(16.0),
                                                      child: Icon(
                                                        Icons.auto_awesome_outlined,
                                                        color: black,
                                                        size: 30,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          'Enhanced Clean'.poppins(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600,
                                                              textAlign: TextAlign.start),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                            child:
                                                                'This Host committed to Airbnb’s 5-step enhanced cleaning process. Show more'
                                                                    .poppins(
                                                              color: Color.fromRGBO(107, 114, 128, 1),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(16.0),
                                                      child: Icon(
                                                        Icons.door_back_door_outlined,
                                                        color: black,
                                                        size: 30,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          'Self check-in'.poppins(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600,
                                                              textAlign: TextAlign.start),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                            child: 'Check yourself in with the keypad.'.poppins(
                                                              color: Color.fromRGBO(107, 114, 128, 1),
                                                              textAlign: TextAlign.start,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 20),
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              "Come and stay in this superb duplex T2, in the heart of the historic center of Bordeaux.Spacious and bright, in a real Bordeaux building in exposed stone, you will enjoy all the charms of the city thanks to its ideal location. Close to many shops, bars and restaurants, you can access the apartment by tram A and C and bus routes 27 and 44...."
                                                  .poppins(textAlign: TextAlign.justify, fontWeight: FontWeight.w400),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: Row(
                                                  children: [
                                                    'Show more'.poppins(decoration: TextDecoration.underline),
                                                    Icon(Icons.keyboard_arrow_right)
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 20),
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 20),
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                child: 'Enhanced Clean'.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    textAlign: TextAlign.start),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.grass_sharp),
                                                          ),
                                                          'Garden view'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.wifi),
                                                          ),
                                                          'Wifi'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.adjust_sharp),
                                                          ),
                                                          'Free washer - in building'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.air),
                                                          ),
                                                          'Central air conditioning'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.kitchen_outlined),
                                                          ),
                                                          'Refrigerator'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.microwave_rounded),
                                                          ),
                                                          'Kitchen'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.wifi),
                                                          ),
                                                          'Wifi'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.pets),
                                                          ),
                                                          'Pets allowed'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.local_fire_department),
                                                          ),
                                                          'Dryer'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.pedal_bike),
                                                          ),
                                                          'Bicycles'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                    ],
                                                  ))
                                                ],
                                              ),
                                              InkWell(
                                                mouseCursor: SystemMouseCursors.click,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(vertical: 16.0),
                                                  padding: EdgeInsets.all(10.0),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(width: 1, color: black),
                                                      borderRadius: BorderRadius.circular(8)),
                                                  child: 'Show all 37 amenities'
                                                      .poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 20),
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.25),
                                                offset: const Offset(0, 4),
                                                blurRadius: 20,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    '15,000 thb'.poppins(
                                                        color: black, fontWeight: FontWeight.w600, fontSize: 20),
                                                    '/ month'.poppins(
                                                        color: black, fontWeight: FontWeight.w500, fontSize: 18),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: Colors.grey, width: 1)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            alignment: Alignment.centerLeft,
                                                            padding: EdgeInsets.all(8.0),
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                              right: BorderSide(
                                                                width: 1,
                                                                color: Colors.grey,
                                                              ),
                                                              bottom: BorderSide(
                                                                width: 1,
                                                                color: Colors.grey,
                                                              ),
                                                            )),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                'CHECK-IN'.toUpperCase().poppins(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w600,
                                                                    textAlign: TextAlign.start),
                                                                Padding(
                                                                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                                  child: '2/19/2022'.poppins(
                                                                    color: Color.fromRGBO(107, 114, 128, 1),
                                                                    textAlign: TextAlign.start,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            alignment: Alignment.centerLeft,
                                                            padding: EdgeInsets.all(8.0),
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                              bottom: BorderSide(
                                                                width: 1,
                                                                color: Colors.grey,
                                                              ),
                                                            )),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                'CHECKOUT'.toUpperCase().poppins(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.w600,
                                                                    textAlign: TextAlign.start),
                                                                Padding(
                                                                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                                  child: '2/26/2022'.poppins(
                                                                    color: Color.fromRGBO(107, 114, 128, 1),
                                                                    textAlign: TextAlign.start,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      alignment: Alignment.centerLeft,
                                                      padding: EdgeInsets.all(8.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          'GUESTS'.toUpperCase().poppins(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w600,
                                                              textAlign: TextAlign.start),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                            child: '2 guests'.poppins(
                                                                color: Color.fromRGBO(107, 114, 128, 1),
                                                                textAlign: TextAlign.start),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  width: double.infinity,
                                                  margin: EdgeInsets.symmetric(vertical: 16),
                                                  padding: EdgeInsets.all(16),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Color.fromRGBO(222, 49, 81, 1)),
                                                  child: 'Send us an inquiry'.poppins(
                                                      color: white,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16,
                                                      textAlign: TextAlign.center),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: 'You won’t be charged yet'.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(107, 114, 128, 1)),
                                              ),
                                              Container(
                                                height: 2,
                                                color: Color.fromRGBO(229, 231, 235, 1),
                                                margin: EdgeInsets.all(8.0),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    'Total'.poppins(
                                                        textAlign: TextAlign.start,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w600),
                                                    '\$701'.poppins(
                                                        textAlign: TextAlign.end,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w600),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Container(
                            //         child: Column(
                            //           children: [
                            //             const SizedBox(height: 80),
                            //             Align(
                            //               alignment: Alignment.center,
                            //               child: 'Entire rental unit hosted by Ghazal'.poppins(
                            //                 color: brown,
                            //                 fontSize: 25 + 4 * pad,
                            //               ),
                            //             ),
                            //             Padding(
                            //               padding: const EdgeInsets.all(8.0),
                            //               child: Align(
                            //                 alignment: Alignment.center,
                            //                 child:
                            //                     'Location address: 22 Moo 3 Tumbon Changpuak Amphor Muang Chiang Mai 50300'
                            //                         .poppinscenter(
                            //                   color: const Color(0xff896e57),
                            //                   fontWeight: FontWeight.bold,
                            //                   height: 1.5,
                            //                   letterSpacing: 1,
                            //                 ),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //     Container(
                            //       width: 324,
                            //       height: 214,
                            //       decoration: BoxDecoration(
                            //         color: white,
                            //         borderRadius: const BorderRadius.only(
                            //           topLeft: Radius.circular(20),
                            //           topRight: Radius.circular(20),
                            //           bottomLeft: Radius.circular(20),
                            //           bottomRight: Radius.circular(20),
                            //         ),
                            //         boxShadow: [
                            //           BoxShadow(
                            //             color: Colors.grey.withOpacity(0.25),
                            //             offset: const Offset(0, 4),
                            //             blurRadius: 4,
                            //           ),
                            //         ],
                            //       ),
                            //       padding: const EdgeInsets.all(4),
                            //       child: Column(
                            //         children: [
                            //           Row(
                            //             children: [
                            //               Expanded(
                            //                 child: Container(
                            //                   height: 70,
                            //                   decoration: const BoxDecoration(
                            //                     border: Border(
                            //                       bottom: BorderSide(
                            //                         color: Color(0xffdbdbd0),
                            //                         width: 2,
                            //                       ),
                            //                       top: BorderSide(
                            //                         color: Color(0xffdbdbd0),
                            //                         width: 2,
                            //                       ),
                            //                       left: BorderSide(
                            //                         color: Color(0xffdbdbd0),
                            //                         width: 2,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                   child: Center(
                            //                     child: 'Naina Asset'.msMadi(
                            //                       color: orange,
                            //                       fontSize: 36,
                            //                       height: 1.5,
                            //                       fontWeight: FontWeight.w600,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //               Container(
                            //                 width: 96,
                            //                 height: 70,
                            //                 decoration: const BoxDecoration(
                            //                   border: Border(
                            //                     bottom: BorderSide(
                            //                       color: Color(0xffdbdbd0),
                            //                       width: 2,
                            //                     ),
                            //                     top: BorderSide(
                            //                       color: Color(0xffdbdbd0),
                            //                       width: 2,
                            //                     ),
                            //                     left: BorderSide(
                            //                       color: Color(0xffdbdbd0),
                            //                       width: 2,
                            //                     ),
                            //                     right: BorderSide(
                            //                       color: Color(0xffdbdbd0),
                            //                       width: 2,
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 child: Center(
                            //                   child: Column(
                            //                     mainAxisAlignment: MainAxisAlignment.center,
                            //                     children: [
                            //                       'FROM'.poppins(
                            //                         color: Colors.grey,
                            //                         fontWeight: FontWeight.w600,
                            //                         fontSize: 16,
                            //                         letterSpacing: 1,
                            //                         height: 1.25,
                            //                       ),
                            //                       '2024'.poppins(
                            //                         fontWeight: FontWeight.bold,
                            //                         fontSize: 24,
                            //                         letterSpacing: 0.5,
                            //                         height: 1.25,
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //           Expanded(
                            //             child: Row(
                            //               children: [
                            //                 Expanded(
                            //                   child: Container(
                            //                     decoration: const BoxDecoration(
                            //                       border: Border(
                            //                         bottom: BorderSide(
                            //                           color: Color(0xffdbdbd0),
                            //                           width: 2,
                            //                         ),
                            //                         left: BorderSide(
                            //                           color: Color(0xffdbdbd0),
                            //                           width: 2,
                            //                         ),
                            //                         right: BorderSide(
                            //                           color: Color(0xffdbdbd0),
                            //                           width: 2,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     child: Center(
                            //                       child: Padding(
                            //                         padding: const EdgeInsets.all(10),
                            //                         child: Column(
                            //                           children: [
                            //                             'FROM'.poppins(
                            //                               color: Colors.grey,
                            //                               fontWeight: FontWeight.w600,
                            //                               fontSize: 16,
                            //                               letterSpacing: 1,
                            //                               height: 1.25,
                            //                             ),
                            //                             '2024'.poppins(
                            //                               fontWeight: FontWeight.bold,
                            //                               fontSize: 24,
                            //                               letterSpacing: 0.5,
                            //                               height: 1.25,
                            //                             ),
                            //                           ],
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(height: 34),
                            // const SizedBox(height: 1),
                            // const Divider(),
                            // const SizedBox(height: 1),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Align(
                            //     alignment: Alignment.center,
                            //     child:
                            //         'Come and stay in this superb duplex T2, in the heart of the historic center of Bordeaux. Spacious and bright, in a real Bordeaux building in exposed stone, you will enjoy all the charms of the city thanks to its ideal location. Close to many shops, bars and restaurants, you can access the apartment by tram A and C and bus routes 27 and 44. ...'
                            //             .poppinscenter(
                            //       color: const Color(0xff896e57),
                            //       fontWeight: FontWeight.bold,
                            //       height: 1.5,
                            //       letterSpacing: 1,
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: 34),
                            // const SizedBox(height: 1),
                            // const Divider(),
                            // const SizedBox(height: 1),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: 'What this place offers'.poppins(
                            //     color: brown,
                            //     fontSize: 25 + 4 * pad,
                            //   ),
                            // ),
                            // Container(
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //         flex: 2,
                            //         child: Container(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: GridView.builder(
                            //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //               crossAxisCount: Metrics.isMobile(context)
                            //                   ? 1
                            //                   : Metrics.isCompact(context)
                            //                       ? 1
                            //                       : Metrics.isTablet(context)
                            //                           ? 2
                            //                           : 2,
                            //               childAspectRatio: _aspectRatio,
                            //               crossAxisSpacing: 24,
                            //               mainAxisSpacing: 24,
                            //             ),
                            //             shrinkWrap: true,
                            //             // physics:
                            //             //     const NeverScrollableScrollPhysics(),
                            //             itemCount: data_place.length,
                            //             itemBuilder: (context, index) {
                            //               final gridItem = decorativeItems[index];

                            //               return Container(
                            //                 decoration: BoxDecoration(
                            //                   color: white,
                            //                   borderRadius: const BorderRadius.only(
                            //                     topLeft: Radius.circular(8),
                            //                     topRight: Radius.circular(8),
                            //                     bottomLeft: Radius.circular(8),
                            //                     bottomRight: Radius.circular(8),
                            //                   ),
                            //                   boxShadow: [
                            //                     BoxShadow(
                            //                       color: Colors.grey.withOpacity(0.25),
                            //                       offset: const Offset(0, 4),
                            //                       blurRadius: 4,
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 padding: const EdgeInsets.all(4),
                            //                 child: Row(
                            //                   children: [
                            //                     Padding(
                            //                       padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            //                       child: Center(
                            //                         child: Icon(IconData(int.parse('${data_place[index]['icons']}'),
                            //                             fontFamily: 'MaterialIcons')),
                            //                       ),
                            //                     ),
                            //                     Expanded(
                            //                       child: Align(
                            //                         alignment: Alignment.centerLeft,
                            //                         child: '${data_place[index]['name']}'.poppins(
                            //                           color: black,
                            //                           fontSize: 16 + 4 * pad,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               );
                            //             },
                            //           ),
                            //         ),
                            //       ),
                            //       Expanded(child: SizedBox())
                            //     ],
                            //   ),
                            // ),
                            // const SizedBox(height: 34),
                            // const SizedBox(height: 1),
                            // const Divider(),
                            // const SizedBox(height: 1),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: 'What this place offers'.poppins(
                            //     color: brown,
                            //     fontSize: 25 + 4 * pad,
                            //   ),
                            // ),
                            Center(
                              child: FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                      child: 'Things to know'.poppins(
                                          fontSize: 20, fontWeight: FontWeight.w600, textAlign: TextAlign.start),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                'House rules'.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    textAlign: TextAlign.start),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.access_time),
                                                          ),
                                                          'Check-in: After 4:00 PM'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.access_time),
                                                          ),
                                                          'Checkout:  10:00 AM'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.door_back_door_outlined),
                                                          ),
                                                          'Self check-in with lockbox'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.shopping_cart_outlined),
                                                          ),
                                                          'Not suitable for infants (under 2 years)'
                                                              .poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.smoke_free),
                                                          ),
                                                          'No smoking'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(Icons.celebration_outlined),
                                                          ),
                                                          'No parties or events'.poppins(fontSize: 12)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            'Health & safety'.poppins(
                                                fontSize: 14, fontWeight: FontWeight.w600, textAlign: TextAlign.start),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Icon(Icons.auto_awesome_outlined),
                                                      ),
                                                      Text(
                                                        "Committed to Airbnb's enhanced cleaning\n process.",
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 12,
                                                        ),
                                                        textAlign: TextAlign.justify,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Icon(Icons.clean_hands_outlined),
                                                      ),
                                                      Text(
                                                        "Airbnb's social-distancing and other\n COVID-19-related guidelines apply",
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 12,
                                                        ),
                                                        textAlign: TextAlign.justify,
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Icon(Icons.radio_button_on),
                                                      ),
                                                      'Smoke alarm'.poppins(fontSize: 12)
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Icon(Icons.credit_card),
                                                      ),
                                                      Text(
                                                        "Security Deposit - if you damage the\n home, you may be charged up to \$566",
                                                        style: GoogleFonts.poppins(
                                                          fontSize: 12,
                                                        ),
                                                        textAlign: TextAlign.justify,
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Icon(Icons.smoke_free),
                                                      ),
                                                      'No smoking'.poppins(fontSize: 12)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                'Cancellation policy'.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    textAlign: TextAlign.start),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      "Free cancellation before Feb 14"
                                                          .poppins(fontSize: 12, color: Color.fromRGBO(75, 85, 99, 1)),
                                                      Row(
                                                        children: [
                                                          'Show more'.poppins(decoration: TextDecoration.underline),
                                                          Icon(Icons.keyboard_arrow_right)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        'Show more'.poppins(decoration: TextDecoration.underline),
                                        Icon(Icons.keyboard_arrow_right)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ])),
                  // TypeThings(),
                  const SizedBox(height: 80),
                  const Footer(
                    bgcolor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } ////---------------------------------------->

  Widget TypeThings() {
    List<String> imageUrls = type_Things.map((data) => data['imageUrl'].toString()).toList();
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
                          padding: EdgeInsets.only(left: 36 * pad, right: 36 * pad, bottom: 8),
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
                                for (int index3 = 0; index3 < data_Things.length; index3++)
                                  if (data_Things[index3]['type_id'] == type_Things[index]['type_id'])
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                            child: Center(
                                              child: Icon(IconData(int.parse('${data_Things[index3]['icons']}'),
                                                  fontFamily: 'MaterialIcons')),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: '${data_Things[index3]['name']}'.poppins(
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
          title: title,
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
