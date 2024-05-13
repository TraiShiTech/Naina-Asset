import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:properties/app/layouts/header/header_asset_all.dart';
import 'package:properties/app/widgets/base_container.dart';
import 'package:properties/app/widgets/how_it_work_card_item.dart';
import 'package:properties/core/core.dart';

import 'components/appbar/appbar.dart';
import 'layouts/about_us/image_clider_controller.dart';
import 'layouts/asset_as/asset_management.dart';
import 'layouts/footer/footer.dart';
import 'layouts/header/header_with_us.dart';

class WistUs extends ConsumerStatefulWidget {
  const WistUs({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WistUsState();
}

class _WistUsState extends ConsumerState<WistUs> {
  int limit = 2; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
///////----------------------------------------------->
  late ScrollController _baseController;

  final GlobalKey _headerKey = GlobalKey();

///////----------------------------------------------->
  late PageController _controller;
  int currentPage = 1;
///////----------------------------------------------->
  List data_Service = [
    {
      'id': '1',
      'imageUrl': '',
      'name': 'Free',
      'description':
          '{100 conversations p/m},{10 websites},{2 GB data storage}',
      'descriptionSub': '{Chat widget},{Real time support}',
      'pri': '0',
    },
    {
      'id': '2',
      'imageUrl': '',
      'name': 'Essentials',
      'description':
          '{100 conversations p/m},{10 websites},{2 GB data storage}',
      'descriptionSub': '{Chat widget},{Real time support}',
      'pri': '50',
    },
    {
      'id': '3',
      'imageUrl': '',
      'name': 'Team',
      'description':
          '{100 conversations p/m},{10 websites},{2 GB data storage}',
      'descriptionSub': '{Chat widget},{Real time support}',
      'pri': '90',
    },
    {
      'id': '4',
      'imageUrl': '',
      'name': 'Enterprise',
      'description':
          '{100 conversations p/m},{10 websites},{2 GB data storage}',
      'descriptionSub': '{Chat widget},{Real time support}',
      'pri': '160',
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
  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));

    final isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);
    final pad1 = isBigScreen
        ? 0.0
        : normalize(min: 576, max: 976, data: Metrics.width(context));
    double plus = Metrics.isDesktop(context)
        ? 0
        : (0.5 *
            (1 - normalize(min: 976, max: 1440, data: Metrics.width(context))));
    _controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.25 + plus,
    );
    ///////-------------------------------------->
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
                  Header_WithUs(headerKey: _headerKey),
                  const SizedBox(height: 80),
                  Align(
                    alignment: Alignment.center,
                    child: 'List with us'.poppins(
                      color: brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 25 + 4 * pad,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: 'Earn'.poppinscenter(
                        color: const Color(0xff896e57),
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  BaseContainer(
                      child: Column(
                          crossAxisAlignment: Metrics.isMobile(context)
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: [
                        Stack(
                          children: [
                            AspectRatio(
                                aspectRatio:
                                    // 45 / 35,
                                    Metrics.isMobile(context)
                                        ? 45 / 65
                                        : Metrics.isCompact(context)
                                            ? 45 / 65
                                            : Metrics.isTablet(context)
                                                ? 45 / 65
                                                : 45 / 15,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.25),
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                        ),
                                      ],
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 192, 189, 189),
                                          width: 1),
                                      // image: DecorationImage(
                                      //   image: AssetImage(
                                      //     'assets/property_service/11.jpg',
                                      //   ),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(height: 20),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: 'Get in touch'
                                                          .poppins(
                                                        color: greenBg,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25 + 4 * pad,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Container(
                                                    // width: 200,
                                                    height: 40,
                                                    // color: white,
                                                    padding: EdgeInsets.only(
                                                        left: 30.0 * pad,
                                                        right: 30.0 * pad),
                                                    child: Container(
                                                      color: white,
                                                      child: TextFormField(
                                                        cursorColor:
                                                            Colors.green,
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor: Colors
                                                              .grey[200]!
                                                              .withOpacity(0.5),
                                                          filled: true,
                                                          // prefixIcon:
                                                          //     const Icon(Icons.person, color: Colors.black),
                                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                          focusedBorder:
                                                              const OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(10),
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                            ),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(10),
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                            ),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Container(
                                                    // width: 200,
                                                    height: 40,
                                                    // color: white,
                                                    padding: EdgeInsets.only(
                                                        left: 30.0 * pad,
                                                        right: 30.0 * pad),
                                                    child: Container(
                                                      color: white,
                                                      child: TextFormField(
                                                        cursorColor:
                                                            Colors.green,
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor: Colors
                                                              .grey[200]!
                                                              .withOpacity(0.5),
                                                          filled: true,
                                                          // prefixIcon:
                                                          //     const Icon(Icons.person, color: Colors.black),
                                                          // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                          focusedBorder:
                                                              const OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(10),
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                            ),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topRight: Radius
                                                                  .circular(10),
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                            ),
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Expanded(
                                                    // flex: 3,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        // height: 300,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left:
                                                                    30.0 * pad,
                                                                right:
                                                                    30.0 * pad),
                                                        color: white,
                                                        child: Center(
                                                          child: TextFormField(
                                                            maxLines: 80,
                                                            // maxLength: 13,
                                                            cursorColor:
                                                                Colors.green,
                                                            decoration:
                                                                InputDecoration(
                                                              fillColor: Colors
                                                                  .grey[200]!
                                                                  .withOpacity(
                                                                      0.5),
                                                              filled: true,
                                                              // prefixIcon:
                                                              //     const Icon(Icons.person, color: Colors.black),
                                                              // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                              focusedBorder:
                                                                  const OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                borderSide:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                                  const OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                borderSide:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        height: 40,
                                                        // width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    8),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    8),
                                                          ),
                                                          color: brown,
                                                          border: Border.all(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      150,
                                                                      148,
                                                                      148),
                                                              width: 2),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: 'Submit'.poppins(
                                                          color: white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              16 + 4 * pad,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                ],
                                              ),
                                            )),
                                        Expanded(
                                          flex: 1,
                                          child: ClipPath(
                                              clipper: TrapeziumClipper(),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(20),
                                                  ),
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      'assets/property_service/11.jpg',
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )),
                                          // Container(
                                          //   decoration: BoxDecoration(
                                          //     borderRadius:
                                          //         const BorderRadius.only(
                                          //       topLeft: Radius.circular(0),
                                          //       topRight: Radius.circular(20),
                                          //       bottomLeft:
                                          //           Radius.circular(0),
                                          //       bottomRight:
                                          //           Radius.circular(20),
                                          //     ),
                                          //     image: DecorationImage(
                                          //       image: AssetImage(
                                          //         'assets/property_service/11.jpg',
                                          //       ),
                                          //       fit: BoxFit.cover,
                                          //     ),
                                          //   ),
                                          // )
                                        ),
                                      ],
                                    ))),
                          ],
                        ),
                        const SizedBox(height: 34),
                        Align(
                          alignment: Alignment.center,
                          child:
                              'Naina Asset: Professional Rental Property Manager'
                                  .poppins(
                            color: brown,
                            fontSize: 25 + 4 * pad,
                          ),
                        ),
                        'With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don\'t worry about contacting us. Because we always have good suggestions.'
                            .poppins(
                          textAlign: TextAlign.center,
                          fontSize: 14 + 4 * pad,
                          fontWeight: FontWeight.w500,
                          height: 1.75,
                        ),
                      ])),
                  const SizedBox(height: 34),
                  service(),
                  const SizedBox(height: 34),
                  BaseContainer(
                      child: Column(
                          crossAxisAlignment: Metrics.isMobile(context)
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: [
                        Align(
                          alignment: Alignment.center,
                          child:
                              'Naina Asset: Professional Rental Property Manager'
                                  .poppins(
                            color: brown,
                            fontSize: 25 + 4 * pad,
                          ),
                        ),
                        const SizedBox(height: 34),
                        'With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don\'t worry about contacting us. Because we always have good suggestions.'
                            .poppins(
                          textAlign: TextAlign.center,
                          fontSize: 14 + 4 * pad,
                          fontWeight: FontWeight.w500,
                          height: 1.75,
                        ),
                        const SizedBox(height: 34),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Metrics.isMobile(context)
                                  ? 1
                                  : Metrics.isCompact(context)
                                      ? 2
                                      : Metrics.isTablet(context)
                                          ? 3
                                          : 4,
                              childAspectRatio: 285 / 185,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 0,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              final gridItem = decorativeItems[index];

                              return Center(
                                child: InkWell(
                                  onTap: () {
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
                                    margin:
                                        EdgeInsets.only(bottom: 12 + 12 * pad),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Stack(
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 265 / 150,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  gridItem.imgPath,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              left: 20,
                                              child: Container(
                                                // width: 150,
                                                // height: 70,
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(15),
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
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Center(
                                                  child: ' Guest favourite'
                                                      .poppins(
                                                    color: greenBg,
                                                    fontSize: 15 + 4 * pad,
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
                      ])),
                  const SizedBox(height: 90),
                  const Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

////---------------------------------------->
  Widget service() {
    List<String> imageUrls =
        data_Service.map((data) => data['imageUrl'].toString()).toList();
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));
    return Column(
      children: [
        const SizedBox(height: 80),
        SizedBox(
          height: 400 + 100 * pad,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (val) => setState(() => currentPage = val),
            itemCount: data_Service.length,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              // Remove the curly braces
              String trimmedData = data_Service[index]['description']
                  .toString()
                  .substring(1,
                      data_Service[index]['description'].toString().length - 1);
              String trimmedData_sub = data_Service[index]['descriptionSub']
                  .toString()
                  .substring(
                      1,
                      data_Service[index]['descriptionSub'].toString().length -
                          1);

              // Split the string into a list
              List<String> description_List = trimmedData.split('},{');
              List<String> descriptionSub_List = trimmedData_sub.split('},{');

              return Padding(
                padding: EdgeInsets.only(left: 36 * pad, right: 36 * pad),
                child: AnimatedScale(
                    duration: const Duration(milliseconds: 240),
                    scale: currentPage == index ? 1 : 0.75,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        color:
                            (data_Service[index]['name'].toString() == 'Free')
                                ? Color.fromRGBO(86, 230, 165, 1)
                                : white,
                        border: Border.all(
                            color: Color.fromARGB(255, 216, 213, 213),
                            width: 1),
                        // gradient:
                        //     (data_Service[index]['name'].toString() == 'Free')
                        //         ? LinearGradient(
                        //             colors: [
                        //               Color.fromRGBO(86, 230, 165, 1)
                        //                   .withOpacity(0.6),
                        //               Color.fromRGBO(86, 230, 165, 1)
                        //                   .withOpacity(0.8),
                        //               Color.fromRGBO(86, 230, 165, 1),
                        //             ],
                        //             begin: Alignment.topCenter,
                        //             end: Alignment.bottomCenter,
                        //           )
                        //         : null,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 180, 175, 175)
                                .withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: data_Service[index]['name']
                                  .toString()
                                  .poppins(
                                    fontWeight: FontWeight.w500,
                                    color: greenBg,
                                    fontSize: 25 + 4 * pad,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  '\$ ${data_Service[index]['pri'].toString()}'
                                      .poppins(
                                color: greenBg,
                                fontWeight: FontWeight.w500,
                                fontSize: 25 + 4 * pad,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {},
                              child: Container(
                                height: 40,
                                // width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                  color:
                                      (data_Service[index]['name'].toString() ==
                                              'Free')
                                          ? Colors.brown
                                          : null,
                                  border: Border.all(
                                      color: Color.fromARGB(255, 150, 148, 148),
                                      width: 2),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: 'Request a demo'.poppins(
                                  color:
                                      (data_Service[index]['name'].toString() ==
                                              'Free')
                                          ? white
                                          : greenBg,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16 + 4 * pad,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          for (int index2 = 0;
                              index2 < description_List.length;
                              index2++)
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    '🟢 ${description_List[index2].toString()}'
                                        .poppins(
                                  color: greenBg,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16 + 4 * pad,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Divider(
                            color: Colors.grey,
                            height: 4.0,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          for (int index3 = 0;
                              index3 < descriptionSub_List.length;
                              index3++)
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    '+ ${descriptionSub_List[index3].toString()}'
                                        .poppins(
                                  color: greenBg,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16 + 4 * pad,
                                ),
                              ),
                            ),
                        ],
                      ),
                    )),
              );
            },
          ),
        ),
        const SizedBox(height: 34),
        ImageSliderController(
          currentPage: currentPage,
          images: imageUrls,
          title: imageUrls,
          prev: currentPage != 0
              ? () {
                  _controller.animateToPage(
                    currentPage - 1,
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.linear,
                  );
                }
              : null,
          next: (currentPage != data_Service.length - 1)
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

/////------------------------------------------->
class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width * 0.3005100, size.height * 0.0046800);
    path.moveTo(size.width * 0.3005100, size.height * -0.0033000);
    path.lineTo(size.width * 0.9997000, size.height * -0.0063800);
    path.lineTo(size.width * 0.9998700, size.height * 0.9978200);
    path.lineTo(size.width * 0.1574300, size.height * 1.0058200);

    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(TrapeziumClipper oldClipper) => false;
}
