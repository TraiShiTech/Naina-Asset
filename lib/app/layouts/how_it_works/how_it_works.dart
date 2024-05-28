import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:properties/Constant/Myconstant.dart';
import 'package:properties/app/layouts/rent/rent_details.dart';
import 'package:properties/core/core.dart';
import 'package:properties/core/models/assetType_model.dart';
import 'package:properties/core/models/asset_model.dart';
import 'package:http/http.dart' as http;

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
  int Tap_Index = 0;
  var ser_type;
  ///////////--------------------------------------------->
  List<String> limitedList_links = [];
  // List<String> links = [
  //   'Homes',
  //   'Condominium',
  //   'Commercial Buildings',
  //   'Others',
  // ];
///////----------------------------------------------->
  // List<String> limitedList_links = [];
  List<bool> isHover = [];
  List<assetmodel> assetmodels = [];
  List<assetTypemodel> assetTypemodels = [];
///////----------------------------------------------->
  @override
  void initState() {
    // _baseController = ScrollController();
    // _baseController.addListener(() {
    //   if (_baseController.offset > 500) {
    //     ref.read(scrollProvider.notifier).change(true);
    //   } else {
    //     ref.read(scrollProvider.notifier).change(false);
    //   }
    // });
    // read_links_limit();
    read_GC_AssetType();
    read_GC_Asset();
    super.initState();
  }

  @override
  void dispose() {
    // _baseController.dispose();
    super.dispose();
  }

  // Future<Null> read_links_limit() async {
  //   setState(() {
  //     endIndex = offset + limit;
  //     limitedList_links = limitedList_links +
  //         links.sublist(
  //             offset, // Start index
  //             (endIndex <= links.length) ? endIndex : links.length // End index
  //             );
  //   });
  //   read_isHover();
  // }

  // Next_links_limit() {
  //   setState(() {
  //     offset = offset + limit;
  //   });
  //   read_links_limit();
  // }

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
      if (assetTypemodels.length != 0) {
        setState(() {
          ser_type = assetTypemodels[0].ser;
        });
      }
      read_GC_Asset();
    } catch (e) {}
  }

///////----------------------------------------------->
  Future<Null> read_GC_Asset() async {
    if (assetmodels.length != 0) {
      assetmodels.clear();
    }

    String url = '${MyConstant().domain}/GC_RentAssetAll_SelectType.php?isAdd=true&sertype=$ser_type';

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
      read_isHover();
    } catch (e) {}
  }

  Future<void> read_isHover() async {
    setState(() {
      isHover.clear();
      isHover = List.generate(
        assetmodels.length,
        (index) => false,
      );
    });
    // setState(() {
    //   isHover = List.generate(
    //     assetTypemodels.length,
    //     (index) => List<bool>.filled(assetmodels.length, false),
    //   );
    // });
  }
  // Future<void> read_isHover() async {
  //   setState(() {
  //     isHover = List.generate(
  //       assetTypemodels.length,
  //       (index) => List<bool>.filled(assetmodels.length, false),
  //     );
  //   });
  // }

///////----------------------------------------------->
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
                      ...List.generate(assetTypemodels.length, (index) {
                        // final link = links[index];

                        return InkWell(
                          onTap: () async {
                            setState(() {
                              Tap_Index = index;
                              ser_type = assetTypemodels[index].ser;
                            });
                            read_GC_Asset();
                          },
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: (Tap_Index == index) ? Colors.grey.withOpacity(0.5) : white,
                                  child: Icon(
                                      IconData(
                                        int.parse('${assetTypemodels[index].icon}'),
                                        fontFamily: 'MaterialIcons',
                                      ),
                                      color: black),
                                  //  icons_links[index]
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: index != 0
                                          ? isBigScreen == Metrics.isMobile(context)
                                              ? 0
                                              : 0
                                          : 0),
                                  child: '${assetTypemodels[index].name} '.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(71, 69, 69, 1),
                                    fontSize: (Metrics.isDesktop(context) || Metrics.isTablet(context)) ? 16 : 8,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     // if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                  //     ...List.generate(links.length, (index) {
                  //       final link = links[index];

                  //       return Column(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Center(child: icons_links[index]),
                  //           Padding(
                  //             padding: EdgeInsets.only(
                  //                 left: index != 0
                  //                     ? isBigScreen == Metrics.isMobile(context)
                  //                         ? 0
                  //                         : 0
                  //                     : 0),
                  //             child: TextButton(
                  //               onPressed: () {},
                  //               style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(0))),
                  //               child: link.poppins(
                  //                 fontWeight: FontWeight.w500,
                  //                 color: Color.fromRGBO(71, 69, 69, 1),
                  //                 fontSize: (Metrics.isDesktop(context) || Metrics.isTablet(context)) ? 16 : 8,
                  //                 height: 1.5,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       );
                  //     }),
                  //   ],
                  // ),
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
                      // for (int index1 = 0; index1 < limitedList_links.length; index1++)
                      Column(
                          crossAxisAlignment:
                              Metrics.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                          children: [
                            // for (int index1 = 0; index1 < assetTypemodels.length; index1++)
                            // if (assetmodels.where((value) => value.typeSer == assetTypemodels[index1].ser).length != 0)
                            SizedBox(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child:
                                    '${assetTypemodels[Tap_Index].name}-${assetTypemodels[Tap_Index].name_th}'.poppins(
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
                                  itemCount: assetmodels.length,
                                  // .where((value) => value.typeSer == assetTypemodels[Tap_Index].ser)
                                  // .length,
                                  itemBuilder: (context, index) {
                                    // if (assetmodels[index].typeSer == assetTypemodels[index1].ser) {
                                    // final ass = assetmodels
                                    //     .where((value) => value.typeSer == assetTypemodels[Tap_Index].ser)
                                    //     .toList();
                                    // final ass = assetmodels;

                                    // print('${index}- ${ass[index].addr}');
                                    final sdate = DateFormat('d MMMM yyyy', 'en_US')
                                        .format(DateTime.parse('${assetmodels[index].s_datex}'));
                                    final ldate = DateFormat('d MMMM yyyy', 'en_US')
                                        .format(DateTime.parse('${assetmodels[index].l_datex}'));
                                    return InkWell(
                                      onTap: () async {
                                        var ser = assetmodels[index].ser.toString();

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => RentDetails(ser),
                                          ),
                                        );
                                      },
                                      child: MouseRegion(
                                          onEnter: (val) => setState(() {
                                                isHover[index] = true;
                                                // print(true);
                                              }),
                                          onExit: (val) => setState(() {
                                                isHover[index] = false;
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
                                                  color: isHover[index] == true
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
                                                  Stack(
                                                    children: [
                                                      AspectRatio(
                                                        aspectRatio: 150 / 150,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(20),
                                                          child: Image.network(
                                                            '${MyConstant().domain}img/${assetmodels[index].corverImg}',
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
                                                          '${assetmodels[index].name_th}'.poppins(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16,
                                                          ),
                                                          '${assetmodels[index].addr}'
                                                              .poppins(fontSize: 12, fontWeight: FontWeight.w400),
                                                          '${sdate}-${ldate}'.poppins(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                          '฿${assetmodels[index].total}'.poppins(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600,
                                                          )
//                                                       '${assetmodels[index].addr}'.poppins(
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
                                    // }
                                  }),
                            ]))
                          ]),
                      const SizedBox(height: 20),
                      // if (links.length > 3)
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RentAll(),
                              ),
                            );
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
        ),
      ),
      textAlign: TextAlign.center,
    );
  }
}
