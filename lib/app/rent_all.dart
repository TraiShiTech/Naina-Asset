import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:properties/app/widgets/base_container.dart';
import 'package:properties/app/with_us.dart';
import 'package:properties/core/core.dart';

import '../core/providers/scroll_provider.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/methods.dart';
import '../core/utils/metrics.dart';
import 'components/appbar/appbar.dart';
import 'asset_all.dart';
import 'layouts/contact_us/contactus.dart';
import 'layouts/custom_decoratives/custom_decoratives.dart';
import 'layouts/footer/footer.dart';
import 'layouts/header/header_rent.dart';
import 'layouts/layouts.dart';

class RentAll extends ConsumerStatefulWidget {
  const RentAll({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RentAllState();
}

class _RentAllState extends ConsumerState<RentAll> {
  int limit = 2; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
///////----------------------------------------------->
  late ScrollController _baseController;

  final GlobalKey _headerKey = GlobalKey();

///////----------------------------------------------->
  List<String> limitedList_links = [];
  List<String> links = [
    'Homes',
    'Condominium',
    'Commercial Buildings',
    'Others',
  ];

  List<Icon> icons_links = [
    Icon(Icons.home),
    Icon(Icons.offline_share),
    Icon(Icons.home_work),
    Icon(Icons.search),
  ];
  List<List<bool>> isHover = [];

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
    read_links_limit();
    super.initState();
  }

  @override
  void dispose() {
    _baseController.dispose();
    super.dispose();
  }

///////----------------------------------------------->
  Future scrollToItem(GlobalKey key) async {
    await Scrollable.ensureVisible(key.currentContext!, duration: const Duration(milliseconds: 480));
  }

  Future<void> read_isHover() async {
    setState(() {
      isHover = List.generate(
        links.length,
        (index) => List<bool>.filled(links.length, false),
      );
    });
  }

///////----------------------------------------------->

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

///////----------------------------------------------->
  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));

    final isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);
    final pad1 = isBigScreen ? 0.0 : normalize(min: 576, max: 976, data: Metrics.width(context));
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
                    child: 'Our Properties'.poppins(
                      color: brown,
                      fontSize: 25 + 4 * pad,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: 'monthly & yearly rentals at prime locations in Chiang Mai, Thailand'.poppinscenter(
                        color: const Color(0xff896e57),
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  BaseContainer(
                      child: Column(
                          crossAxisAlignment:
                              Metrics.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                          children: [
                        for (int index1 = 0; index1 < links.length; index1++)
                          SizedBox(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: '${links[index1]}'.toUpperCase().poppins(
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
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
                                childAspectRatio: 285 / (400),
                                crossAxisSpacing: 24,
                                mainAxisSpacing: 10,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                final gridItem = decorativeItems[index];

                                return InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => xxxx(),
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
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
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
                                          margin: EdgeInsets.only(bottom: 12 + 12 * pad),
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8),
                                            ),
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
                                              // Stack(
                                              //   children: [
                                              //     AspectRatio(
                                              //       aspectRatio: 285 / 230,
                                              //       child: ClipRRect(
                                              //         borderRadius:
                                              //             BorderRadius
                                              //                 .circular(20),
                                              //         child: Image.network(
                                              //           gridItem.imgPath,
                                              //           fit: BoxFit.cover,
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     Positioned(
                                              //       top: 10,
                                              //       left: 20,
                                              //       child: Container(
                                              //         // width: 150,
                                              //         // height: 70,
                                              //         decoration:
                                              //             BoxDecoration(
                                              //           color: white,
                                              //           borderRadius:
                                              //               const BorderRadius
                                              //                   .only(
                                              //             topLeft: Radius
                                              //                 .circular(15),
                                              //             topRight: Radius
                                              //                 .circular(15),
                                              //             bottomLeft: Radius
                                              //                 .circular(15),
                                              //             bottomRight:
                                              //                 Radius
                                              //                     .circular(
                                              //                         15),
                                              //           ),
                                              //           boxShadow: [
                                              //             BoxShadow(
                                              //               color: Colors
                                              //                   .grey
                                              //                   .withOpacity(
                                              //                       0.25),
                                              //               offset:
                                              //                   const Offset(
                                              //                       0, 4),
                                              //               blurRadius: 4,
                                              //             ),
                                              //           ],
                                              //         ),
                                              //         padding:
                                              //             const EdgeInsets
                                              //                 .all(4),
                                              //         child: Center(
                                              //           child:
                                              //               ' Guest favourite'
                                              //                   .poppins(
                                              //             color: greenBg,
                                              //             fontSize:
                                              //                 15 + 4 * pad,
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
                                              //         const EdgeInsets.all(
                                              //             24),
                                              //     child: Column(
                                              //       crossAxisAlignment:
                                              //           CrossAxisAlignment
                                              //               .start,
                                              //       mainAxisAlignment:
                                              //           MainAxisAlignment
                                              //               .spaceBetween,
                                              //       children: [
                                              //         gridItem.title
                                              //             .poppins(
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
                                              //             gridItem.price
                                              //                 .poppins(
                                              //               fontSize: 18,
                                              //               fontWeight:
                                              //                   FontWeight
                                              //                       .bold,
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
                                              //             gridItem.price
                                              //                 .poppins(
                                              //               fontSize: 18,
                                              //               fontWeight:
                                              //                   FontWeight
                                              //                       .bold,
                                              //             ),
                                              //           ],
                                              //         ),
                                              //         Padding(
                                              //           padding:
                                              //               const EdgeInsets
                                              //                       .fromLTRB(
                                              //                   0, 4, 0, 4),
                                              //           child: gridItem
                                              //               .title
                                              //               .poppins(
                                              //             fontWeight:
                                              //                 FontWeight
                                              //                     .bold,
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
                                              //             gridItem.price
                                              //                 .poppins(
                                              //               fontSize: 18,
                                              //               fontWeight:
                                              //                   FontWeight
                                              //                       .bold,
                                              //             ),
                                              //           ],
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
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
                                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
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
                                      )),
                                );
                              },
                            ),
                          ]))
                      ])),
                  const SizedBox(height: 80),
                  const Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
