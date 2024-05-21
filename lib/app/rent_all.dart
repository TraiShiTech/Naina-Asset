import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:properties/app/widgets/base_container.dart';
import 'package:properties/app/with_us.dart';
import 'package:properties/core/core.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../core/models/assetType_model.dart';
import '../core/models/asset_model.dart';
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
import 'layouts/rent/rent_details.dart';

class RentAll extends ConsumerStatefulWidget {
  const RentAll({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RentAllState();
}

class _RentAllState extends ConsumerState<RentAll> {
  int limit = 2; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
  int count = 0;
///////----------------------------------------------->
  late ScrollController _baseController;

  final GlobalKey _headerKey = GlobalKey();

///////----------------------------------------------->
  // List<String> limitedList_links = [];
  List<List<bool>> isHover = [];
  List<assetmodel> assetmodels = [];
  List<assetTypemodel> assetTypemodels = [];
  Map assetlist = {};
  Map hover = {};

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
    read_GC_AssetType();
    read_GC_Asset();
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

///////----------------------------------------------->
  Future<Null> read_GC_AssetType() async {
    if (assetTypemodels.length != 0) {
      assetTypemodels.clear();
    }

    String url = '${MyConstant().domain}/GC_Asset_Type.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        assetTypemodel assetTypemodelss = assetTypemodel.fromJson(map);

        setState(() {
          assetTypemodels.add(assetTypemodelss);
        });
      }
      Future.delayed(const Duration(milliseconds: 300), () {
        read_GC_Asset();
      });
    } catch (e) {}
  }

///////----------------------------------------------->
  Future<Null> read_GC_Asset() async {
    if (assetmodels.length != 0) {
      assetmodels.clear();
    }

    String url = '${MyConstant().domain}/GC_Rent_AssetAll.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        assetmodel assetmodelss = assetmodel.fromJson(map);

        setState(() {
          assetmodels.add(assetmodelss);
        });
      }
      // print(assetlist);
      read_isHover();
      // Map assetlist = {};
    } catch (e) {}
  }

  Future<void> read_isHover() async {
    if (isHover.length != 0) {
      isHover.clear();
    } else {
      setState(() {
        isHover = List.generate(
          assetTypemodels.length,
          (index) => List<bool>.filled(assetmodels.length, false),
        );
        // int numm = 0;
        // isHover.removeWhere((list) => list.isEmpty);
        // print('$isHover-${assetTypemodels.length}');
        // isHover = List.generate(
        //   assetTypemodels.length,
        //   (index) => List<bool>.filled(assetmodels.length, false),
        // );
      });
    }
  }

///////----------------------------------------------->
  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));
    // final isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);
    // final pad1 = isBigScreen ? 0.0 : normalize(min: 576, max: 976, data: Metrics.width(context));
    // print(isHover);
    // read_isHover();
    // int num = 0;
    // for (int index1 = 0; index1 < assetTypemodels.length; index1++) {
    //   Map assmap = {};
    //   int count = 0;
    //   // print(assetmodels.where((value) => value.typeSer == assetTypemodels[index1].ser).length);
    //   for (int index = 0; index < assetmodels.length; index++) {
    //     if (assetmodels[index].typeSer == assetTypemodels[index1].ser) {
    //       assmap[count] = {
    //         'corverImg': '${assetmodels[index].corverImg}',
    //         'name_th': '${assetmodels[index].name_th}',
    //         'addr': '${assetmodels[index].addr}',
    //         's_datex': '${assetmodels[index].s_datex}',
    //         'l_datex': '${assetmodels[index].l_datex}',
    //         'total': '${assetmodels[index].total}',
    //         'hover': false,
    //       };
    //       count = count + 1;
    //     }
    //   }
    //   num = num + 1;
    //   assetlist[index1] = {
    //     'name': '${assetTypemodels[index1].name} -${assetTypemodels[index1].name_th}',
    //     'assets': assmap,
    //     'count': count,
    //   } as Map;
    // }
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
                      color: Color.fromRGBO(71, 69, 69, 1),
                      fontSize: 25 + 4 * pad,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: 'monthly & yearly rentals at prime locations in Chiang Mai, Thailand'.poppinscenter(
                        color: Color.fromRGBO(71, 69, 69, 1),
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
                        for (int index1 = 0; index1 < assetTypemodels.length; index1++)
                          // if (assetmodels.where((value) => value.typeSer == assetTypemodels[index1].ser).length != 0)
                          SizedBox(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: '${assetTypemodels[index1].name}-${assetTypemodels[index1].name_th}'.poppins(
                                color: Color.fromRGBO(87, 87, 87, 1),
                                fontWeight: FontWeight.w600,
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
                                itemCount:
                                    assetmodels.where((value) => value.typeSer == assetTypemodels[index1].ser).length,
                                itemBuilder: (context, index) {
                                  // if (assetmodels[index].typeSer == assetTypemodels[index1].ser) {

                                  final ass = assetmodels
                                      .where((value) => value.typeSer == assetTypemodels[index1].ser)
                                      .toList();
                                  // print(isHover[index1][index]);
                                  // String dateStr = '${ass[index].s_datex}';

                                  final sdate = DateFormat('d MMMM yyyy', 'en_US')
                                      .format(DateTime.parse('${ass[index].s_datex}'));
                                  final ldate = DateFormat('d MMMM yyyy', 'en_US')
                                      .format(DateTime.parse('${ass[index].l_datex}'));

                                  if (isHover.isEmpty) {
                                    // setState(() {
                                    isHover.clear();
                                    read_isHover();
                                    // });
                                  }
                                  if (ass.isNotEmpty && isHover.isNotEmpty) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => RentDetails(ass[index].ser.toString()),
                                          ),
                                        );
                                      },
                                      child: MouseRegion(
                                          onEnter: (val) => setState(() {
                                                isHover[index1][index] = true;
                                                // print(true);
                                              }),
                                          onExit: (val) => setState(() {
                                                isHover[index1][index] = false;
                                                // print(false);
                                              }),
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 240),
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              // color: isHover[index1][index] ? Colors.grey[100] : white.withOpacity(0),
                                              color: white,
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                                bottomLeft: Radius.circular(8),
                                                bottomRight: Radius.circular(8),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: isHover[index1][index] == true
                                                      ? textPrimary.withOpacity(0.15)
                                                      : textPrimary.withOpacity(0),
                                                  offset: const Offset(0, 6),
                                                  blurRadius: 10,
                                                ),
                                              ],
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     // color: isHover[index1][index] == true
                                              //     color: textPrimary.withOpacity(0.15),
                                              //     // : textPrimary.withOpacity(0),
                                              //     offset: const Offset(0, 6),
                                              //     blurRadius: 10,
                                              //   ),
                                              // ],
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(bottom: 12 + 12 * pad),
                                              decoration: BoxDecoration(
                                                color: white,
                                                borderRadius: BorderRadius.circular(20),
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
                                                            '${ass[index].corverImg}',
                                                            fit: BoxFit.cover,
                                                            alignment: Alignment.center,
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
                                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          '${ass[index].name_th}'.poppins(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16,
                                                          ),
                                                          '${ass[index].addr}'
                                                              .poppins(fontSize: 12, fontWeight: FontWeight.w400),
                                                          '${sdate} - ${ldate}'.poppins(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                          '฿${ass[index].total}'.poppins(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                          )
//                                                       '${ass[index].addr}'.poppins(
//                                                         fontWeight: FontWeight.w400,
//                                                         fontSize: 12,
// // >>>>>>> main-nav
//                                                       ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    );
                                  }
                                  return null;
                                  // }
                                }),
                          ]))
                      ])),
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
  }
}
