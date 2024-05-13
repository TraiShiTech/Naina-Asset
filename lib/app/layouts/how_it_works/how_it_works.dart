import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:properties/core/core.dart';

import '../../../core/utils/metrics.dart';
import '../../rent_all.dart';
import '../../widgets/base_container.dart';
import '../../widgets/how_it_work_card_item.dart';
import '../header/header_left.dart';

class HowItWorks extends StatefulWidget {
  const HowItWorks({super.key});

  @override
  State<HowItWorks> createState() => _HowItWorksState();
}

class _HowItWorksState extends State<HowItWorks> {
  int limit = 2; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
  ///////////--------------------------------------------->
  List<String> limitedList_links = [];
  List<String> links = [
    'Homes',
    'Condominium',
    'Commercial Buildings',
    'Others',
  ];
  List<List<bool>> isHover = [];

  @override
  void initState() {
    super.initState();

    // read_isHover();
    read_links_limit();
  }

  Future<void> read_isHover() async {
    setState(() {
      isHover = List.generate(
        links.length,
        (index) => List<bool>.filled(links.length, false),
      );
    });
  }

  Future<Null> read_links_limit() async {
    setState(() {
      endIndex = offset + limit;
      limitedList_links = limitedList_links +
          links.sublist(
              offset, // Start index
              (endIndex <= links.length) ? endIndex : links.length // End index
              );
    });
    read_isHover();
  }

  Next_links_limit() {
    setState(() {
      offset = offset + limit;
    });
    read_links_limit();
  }

  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));

    final isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);
    final pad1 = isBigScreen ? 0.0 : normalize(min: 576, max: 976, data: Metrics.width(context));

    List<Image> icons_links = [
      // Icon(Icons.home),
      // Icon(Icons.offline_share),
      // Icon(Icons.home_work),
      // Icon(Icons.search),
      Image.asset(
        'images/0a2957b866583552c2a99e30ae16a983.png',
        width: Metrics.isMobile(context) ? 30 : 40,
        height: Metrics.isMobile(context) ? 30 : 40,
      ),
      Image.asset(
        'images/429021569a7eea5b675f332d01cb14c3.png',
        width: Metrics.isMobile(context) ? 30 : 40,
        height: Metrics.isMobile(context) ? 30 : 40,
      ),
      Image.asset(
        'images/3f1e9ce98091d9b06574ed58aeff6056.png',
        width: Metrics.isMobile(context) ? 30 : 40,
        height: Metrics.isMobile(context) ? 30 : 40,
      ),
      Image.asset(
        'images/c2572995202a9d2831d9a57c325fe511.png',
        width: Metrics.isMobile(context) ? 30 : 40,
        height: Metrics.isMobile(context) ? 30 : 40,
      ),
    ];

    return BaseContainer(
      child: Column(
        // crossAxisAlignment: Metrics.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 80),
          // Align(
          //   alignment: Alignment.center,
          //   child:
          //       'All properties are handpicked, curated and managed by us! Become worry-free by choosing us today!'
          //           .poppinscenter(
          //     color: const Color(0xff896e57),
          //     fontWeight: FontWeight.bold,
          //     height: 1.5,
          //     letterSpacing: 1,
          //   ),
          // ),

          isBigScreen == Metrics.isTablet(context)
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    title1(
                      text: ' All properties are ',
                      fw: FontWeight.w300,
                    ),
                    title1(
                      text: ' handpicked, curated and managed ',
                      fw: FontWeight.bold,
                    ),
                    title1(
                      text: 'by us! Become worry-free by choosing us today!',
                      fw: FontWeight.w300,
                    ),
                  ],
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    title1(
                      text: ' All properties are ',
                      fw: FontWeight.w300,
                    ),
                    title1(
                      text: ' handpicked, curated and managed ',
                      fw: FontWeight.bold,
                    ),
                    title1(
                      text: 'by us! Become worry-free by choosing us today!',
                      fw: FontWeight.w300,
                    ),
                  ],
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                text: const TextSpan(
                  text: 'Let us help you find your perfect ',
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 2,
                    color: Color.fromRGBO(90, 90, 90, 1),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'long term stay rents ',
                      style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 2,
                        color: Color.fromRGBO(90, 90, 90, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'in Chiang Mai, Thailand',
                      style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 2,
                        color: Color.fromRGBO(90, 90, 90, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: FractionallySizedBox(
              widthFactor: isBigScreen == Metrics.isTablet(context) ? 1 : 0.7,
              child: Padding(
                padding: EdgeInsets.all(Metrics.isMobile(context) ? 6 : 8.0),
                child: Container(
                  alignment: Alignment.center,
                  width: Metrics.width(context),
                  // height: 72,
                  padding: EdgeInsets.all(Metrics.isMobile(context) ? 6 : 8.0),
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
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                    // border: Border.all(
                    //     color: const Color.fromARGB(255, 163, 161, 161), width: 1),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                      ...List.generate(links.length, (index) {
                        final link = links[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: icons_links[index]),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: index != 0
                                      ? isBigScreen == Metrics.isMobile(context)
                                          ? 0
                                          : 0
                                      : 0),
                              child: TextButton(
                                onPressed: () {},
                                style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                                child: link.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(71, 69, 69, 1),
                                  fontSize: (Metrics.isDesktop(context) || Metrics.isTablet(context)) ? 16 : 8,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          if (isHover.length != 0)
            BaseContainer(
                child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Column(
                    crossAxisAlignment:
                        Metrics.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    children: [
                      for (int index1 = 0; index1 < limitedList_links.length; index1++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: '${links[index1]}'.poppins(
                                color: Color.fromRGBO(87, 87, 87, 1),
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                fontSize: 20,
                                letterSpacing: 1,
                              ),
                            ),
                            GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: Metrics.isMobile(context)
                                    ? 1
                                    : Metrics.isCompact(context)
                                        ? 2
                                        : Metrics.isTablet(context)
                                            ? 3
                                            : 4,
                                childAspectRatio: 150 / (250),
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 10,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                final gridItem = index1 == 1 ? decorativeItems[index + 4] : decorativeItems[index];

// <<<<<<< HEAD
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RentAll(),
                                      ),
                                    );
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => Rent(),
                                    //   ),
                                    // );
                                  },
                                  child: MouseRegion(
                                      onEnter: (val) => setState(() => isHover[index1][index] = true),
                                      onExit: (val) => setState(() => isHover[index1][index] = false),
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 240),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          // color: isHover[index1][index] ? Colors.grey[100] : white.withOpacity(0),
                                          color: isHover[index1][index] ? white : white,
// =======
                                          // return MouseRegion(
                                          //     onEnter: (val) => setState(() => isHover[index1][index] = true),
                                          //     onExit: (val) => setState(() => isHover[index1][index] = false),
                                          //     child: AnimatedContainer(
                                          //       duration: const Duration(milliseconds: 240),
                                          //       padding: const EdgeInsets.all(8),
                                          //       decoration: BoxDecoration(
                                          //         color: isHover[index1][index] ? Colors.grey[100] : white.withOpacity(0),
// >>>>>>> main-nav
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: isHover[index1][index]
                                                  ? textPrimary.withOpacity(0.15)
                                                  : textPrimary.withOpacity(0),
                                              offset: const Offset(0, 6),
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: Container(
// <<<<<<< HEAD
                                          // margin: EdgeInsets.only(
                                          //     bottom: 12 + 12 * pad),
                                          // decoration: BoxDecoration(
                                          //   color: white,
                                          //   borderRadius: const BorderRadius.only(
                                          //     topLeft: Radius.circular(20),
                                          //     topRight: Radius.circular(20),
                                          //     bottomLeft: Radius.circular(8),
                                          //     bottomRight: Radius.circular(8),
                                          //   ),
                                          //   boxShadow: [
                                          //     BoxShadow(
                                          //       color:
                                          //           Colors.grey.withOpacity(0.25),
                                          //       offset: const Offset(0, 4),
                                          //       blurRadius: 4,
                                          //     ),
                                          //   ],
                                          // ),
                                          // child: Column(
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.stretch,
// =======
                                          margin: EdgeInsets.only(bottom: 12 + 12 * pad),
                                          decoration: BoxDecoration(
                                              // color: white,
                                              // borderRadius: const BorderRadius.only(
                                              //   topLeft: Radius.circular(20),
                                              //   topRight: Radius.circular(20),
                                              //   bottomLeft: Radius.circular(8),
                                              //   bottomRight: Radius.circular(8),
                                              // ),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color: Colors.grey.withOpacity(0.25),
                                              //     offset: const Offset(0, 4),
                                              //     blurRadius: 4,
                                              //   ),
                                              // ],
                                              ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Stack(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 150 / 150,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(20),
                                                      child: Image.network(
                                                        gridItem.imgPath,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 10,
                                                    left: 20,
                                                    child: Container(
                                                      // width: 150,
                                                      // height: 70,
                                                      decoration: BoxDecoration(
                                                        color: white,
// <<<<<<< HEAD
                                                        //           borderRadius:
                                                        //               const BorderRadius
                                                        //                   .only(
                                                        //             topLeft:
                                                        //                 Radius.circular(15),
                                                        //             topRight:
                                                        //                 Radius.circular(15),
                                                        //             bottomLeft:
                                                        //                 Radius.circular(15),
                                                        //             bottomRight:
                                                        //                 Radius.circular(15),
                                                        //           ),
                                                        //           boxShadow: [
                                                        //             BoxShadow(
                                                        //               color: Colors.grey
                                                        //                   .withOpacity(
                                                        //                       0.25),
                                                        //               offset: const Offset(
                                                        //                   0, 4),
                                                        //               blurRadius: 4,
                                                        //             ),
                                                        //           ],
                                                        //         ),
                                                        //         padding:
                                                        //             const EdgeInsets.all(4),
                                                        //         child: Center(
                                                        //           child: ' Guest favourite'
                                                        //               .poppins(
                                                        //             color: greenBg,
                                                        //             fontSize: 15 + 4 * pad,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //     ),
                                                        //     Positioned(
                                                        //         top: 10,
                                                        //         right: 20,
                                                        //         child: IconButton(
                                                        //           onPressed: () {},
                                                        //           icon: Icon(
                                                        //             Icons.favorite,
                                                        //             color: white,
                                                        //           ),
                                                        //         ))
                                                        //   ],
                                                        // ),
                                                        // Expanded(
                                                        //   child: Padding(
                                                        //     padding:
                                                        //         const EdgeInsets.all(24),
                                                        //     child: Column(
                                                        //       crossAxisAlignment:
                                                        //           CrossAxisAlignment.start,
                                                        //       mainAxisAlignment:
                                                        //           MainAxisAlignment
                                                        //               .spaceBetween,
                                                        //       children: [
                                                        //         gridItem.title.poppins(
                                                        //           fontWeight:
                                                        //               FontWeight.bold,
                                                        //           fontSize: 18,
                                                        //         ),
                                                        //         Row(
                                                        //           mainAxisAlignment:
                                                        //               MainAxisAlignment
                                                        //                   .spaceBetween,
                                                        //           children: [
                                                        //             gridItem.subtitle
                                                        //                 .poppins(
                                                        //               fontSize: 18,
                                                        //             ),
                                                        //             gridItem.price.poppins(
                                                        //               fontSize: 18,
                                                        //               fontWeight:
                                                        //                   FontWeight.bold,
                                                        //             ),
                                                        //           ],
                                                        //         ),
                                                        //         Row(
                                                        //           mainAxisAlignment:
                                                        //               MainAxisAlignment
                                                        //                   .spaceBetween,
                                                        //           children: [
                                                        //             gridItem.subtitle
                                                        //                 .poppins(
                                                        //               fontSize: 18,
                                                        //             ),
                                                        //             gridItem.price.poppins(
                                                        //               fontSize: 18,
                                                        //               fontWeight:
                                                        //                   FontWeight.bold,
                                                        //             ),
                                                        //           ],
                                                        //         ),
                                                        //         Padding(
                                                        //           padding: const EdgeInsets
                                                        //               .fromLTRB(0, 4, 0, 4),
                                                        //           child: gridItem.title
                                                        //               .poppins(
                                                        //             fontWeight:
                                                        //                 FontWeight.bold,
                                                        //             fontSize: 18,
                                                        //           ),
                                                        //         ),
                                                        //         Row(
                                                        //           mainAxisAlignment:
                                                        //               MainAxisAlignment
                                                        //                   .spaceBetween,
                                                        //           children: [
                                                        //             gridItem.subtitle
                                                        //                 .poppins(
                                                        //               fontSize: 18,
                                                        //             ),
                                                        //             gridItem.price.poppins(
                                                        //               fontSize: 18,
                                                        //               fontWeight:
                                                        //                   FontWeight.bold,
                                                        //             ),
                                                        //           ],
// =======
                                                        borderRadius: const BorderRadius.only(
                                                          topLeft: Radius.circular(15),
                                                          topRight: Radius.circular(15),
                                                          bottomLeft: Radius.circular(15),
                                                          bottomRight: Radius.circular(15),
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
                                                      child: Center(
                                                        child: ' Guest favourite'.poppins(
                                                          color: greenBg,
                                                          fontSize: 13 + 4 * pad,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: 10,
                                                      right: 20,
                                                      child: IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.favorite_border,
                                                          color: white,
                                                        ),
                                                      ))
                                                ],
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      gridItem.title.poppins(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16,
                                                      ),
                                                      gridItem.subtitle
                                                          .poppins(fontSize: 12, fontWeight: FontWeight.w400),
                                                      gridItem.date.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                      gridItem.price.poppins(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                      gridItem.time.poppins(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12,
// >>>>>>> main-nav
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
// <<<<<<< HEAD
                                      )),
                                );
                              },
                            ),
                          ],
                        ),
                      // ),
//                   const SizedBox(height: 20),
//                   if (links.length > 3)
//                     Align(
//                       alignment: Alignment.center,
//                       child: InkWell(
//                         onTap: () {
//                           Next_links_limit();
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(8),
//                           margin: EdgeInsets.only(bottom: 12 + 12 * pad),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300]!.withOpacity(0.5),
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(8),
//                               topRight: Radius.circular(8),
//                               bottomLeft: Radius.circular(8),
//                               bottomRight: Radius.circular(8),
// =======
                      //       ));
                      // },
// >>>>>>> main-nav
                      //     );
                      //   ],
                      // ),
                      const SizedBox(height: 20),
                      if (links.length > 3)
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              Next_links_limit();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              margin: EdgeInsets.only(bottom: 12 + 12 * pad),
                              decoration: BoxDecoration(
                                color: Colors.grey[300]!.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(0.25),
                                //     offset: const Offset(0, 4),
                                //     blurRadius: 4,
                                //   ),
                                // ],
                              ),
                              child: 'view all properties'.poppins(
                                color: black,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        )
                    ]),
              ),
            )),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  'Have a vacant property? Why not list with us!'.poppins(
                    textAlign: TextAlign.start,
                    fontSize: 28,
                    color: Color.fromRGBO(72, 72, 72, 1),
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 16),
                  'Please kindly leave your email or phone number and we will get back to you as soon as possible!'
                      .poppins(
                    color: Color.fromRGBO(53, 51, 51, 1),
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: 1,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: AspectRatio(
              aspectRatio: isBigScreen == Metrics.isTablet(context) ? 16 / 12 : 16 / 3,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    // colorFilter: ColorFilter.mode(Colors.white38, BlendMode.softLight),
                    image: AssetImage('images/d0829a0498729e1591a1f3845edd3cd71.jpg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                child: Center(
                  child: FractionallySizedBox(
                    widthFactor: isBigScreen == Metrics.isMobile(context) ? 0.9 : 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          // controller: ,
                          decoration: InputDecoration(
                              hintText: 'Email or Phone number ...'.toUpperCase(),
                              filled: true,
                              hintStyle: TextStyle(fontSize: Metrics.isMobile(context) ? 8 : 12),
                              fillColor: white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            margin: EdgeInsets.only(bottom: 12 + 12 * pad),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.grey.withOpacity(0.25),
                              //     offset: const Offset(0, 4),
                              //     blurRadius: 4,
                              //   ),
                              // ],
                            ),
                            child: 'Submit Contact Information >'.toUpperCase().poppins(
                                  color: Color.fromRGBO(72, 72, 72, 1),
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                  letterSpacing: 1,
                                  fontSize: isBigScreen == Metrics.isTablet(context) ? 6 : 12,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          // if (isBigScreen)
          //   Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: List.generate(
          //       cards.length,
          //       (index) => HowItWorksCardItem(
          //         item: cards[index],
          //       ),
          //     ),
          //   ),
          // if (Metrics.isCompact(context))
          //   Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: List.generate(
          //       2,
          //       (index) => HowItWorksCardItem(
          //         item: cards[index],
          //       ),
          //     ),
          //   ),
          // if (Metrics.isCompact(context))
          //   Row(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: List.generate(
          //       2,
          //       (index) => HowItWorksCardItem(
          //         item: cards[index + 2],
          //       ),
          //     ),
          //   ),
          // if (Metrics.isMobile(context))
          //   Column(
          //     children: List.generate(
          //       cards.length,
          //       (index) => Row(
          //         children: [
          //           HowItWorksCardItem(
          //             item: cards[index],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class title1 extends StatelessWidget {
  const title1({super.key, required this.text, required this.fw});
  final String text;
  final FontWeight fw;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
        color: Color.fromRGBO(137, 125, 120, 1),
        fontWeight: fw,
        height: 1.5,
        letterSpacing: 1,
      )),
    );
  }
}
