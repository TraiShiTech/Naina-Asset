import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:properties/core/core.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/methods.dart';
import '../../../core/utils/metrics.dart';

class HeaderLeft extends StatelessWidget {
  const HeaderLeft({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 976, max: 1440, data: Metrics.width(context));
    final bool isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);

    return Expanded(
      child: Column(
        // crossAxisAlignment: isBigScreen ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeaderLeftTitle(isBigScreen: isBigScreen),
          const SizedBox(height: 7),
          HeaderLeftSubtitle(pad: pad, isBigScreen: isBigScreen),
          const SizedBox(height: 30),
          HeaderLeftInput(pad: pad),
        ],
      ),
    );
  }
}

class HeaderLeftInput extends StatelessWidget {
  const HeaderLeftInput({
    Key? key,
    required this.pad,
  }) : super(key: key);

  final double pad;

  @override
  Widget build(BuildContext context) {
    List<String> links = [
      'Property',
      'Check in',
      'Check out',
    ];
    final bool isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);
    final pad1 = isBigScreen ? 0.0 : normalize(min: 576, max: 976, data: Metrics.width(context));

    return Center(
      child: FractionallySizedBox(
        widthFactor: isBigScreen == Metrics.isTablet(context) ? 1 : 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Container(
                width: 160,
                // height: 30,
                margin: EdgeInsets.only(right: (72 * pad) + (120 * pad1), left: 120 * pad1),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  color: Color.fromRGBO(99, 91, 75, 1),
                ),
                child: Center(
                  child: 'Monthly Stay'.poppins(
                    color: white,
                    fontWeight: FontWeight.w300,
                    fontSize: isBigScreen == Metrics.isMobile(context) ? 10 : 14,
                    letterSpacing: 1,
                    height: 1.25,
                  ),
                ),
              ),
            ),
            Container(
              // height: 72,
              margin: EdgeInsets.only(right: (72 * pad) + (120 * pad1), left: 120 * pad1),
              padding: EdgeInsets.all(Metrics.isMobile(context) ? 2 : 8),
              decoration: BoxDecoration(
                // borderRadius: const BorderRadius.only(
                //   topLeft: Radius.circular(20),
                //   topRight: Radius.circular(20),
                //   bottomLeft: Radius.circular(20),
                //   bottomRight: Radius.circular(20),
                // ),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 0, color: Colors.transparent),
                color: white,
                // border: Border.all(color: const Color.fromARGB(255, 163, 161, 161), width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                      ...List.generate(links.length, (index) {
                        final link = links[index];

                        return Expanded(
                          flex: index == 0 ? 45 : 25,
                          child: Row(
                            children: [
                              if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                                if (index != 0)
                                  Container(
                                    height: 30,
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.5),
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                  ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: index != 0
                                        ? Metrics.isMobile(context)
                                            ? 5
                                            : 24
                                        : 0),
                                child: TextButton(
                                  style: ButtonStyle(alignment: Alignment.centerLeft),
                                  onPressed: () {},
                                  child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        link.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: (Metrics.isDesktop(context) || Metrics.isTablet(context)) ? 13 : 9,
                                          height: 1,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        index == 0
                                            ? 'Select Property from the List '.poppins(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                                fontSize:
                                                    (Metrics.isDesktop(context) || Metrics.isTablet(context)) ? 14 : 8,
                                                height: 0.7,
                                              )
                                            : 'Add dates'.poppins(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                                fontSize:
                                                    (Metrics.isDesktop(context) || Metrics.isTablet(context)) ? 14 : 8,
                                                height: 0.7,
                                              ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  )
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 16.0),
                      //   child: TextField(
                      //     style: GoogleFonts.poppins(
                      //       fontSize: 16,
                      //       color: textPrimary,
                      //       fontWeight: FontWeight.bold,
                      //       height: 1.30,
                      //     ),
                      //     decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       hintText: 'Monthly Stay',
                      //       hintStyle: GoogleFonts.poppins(
                      //         color: greenBg,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      ),
                  if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                    Container(
                      height: 30,
                      width: 1,
                      color: Colors.grey.withOpacity(0.5),
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                  if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                    InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromRGBO(232, 191, 66, 1),
                          child: Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            // FontAwesomeIcons.chevronRight,
                            color: white,
                            size: 12,
                          ),
                        )),

                  // Material(
                  //   color: const Color.fromARGB(255, 141, 106, 93),
                  //   child: InkWell(
                  //       onTap: () {},
                  //       child: CircleAvatar(
                  //         radius: 25,
                  //         backgroundColor: const Color.fromARGB(255, 141, 106, 93),
                  //         child: Icon(
                  //           FontAwesomeIcons.magnifyingGlass,
                  //           // FontAwesomeIcons.chevronRight,
                  //           color: white,
                  //           size: 12,
                  //         ),
                  //       )
                  //       // SizedBox(
                  //       //   height: 72 - 16,
                  //       //   child: Padding(
                  //       //     padding: const EdgeInsets.symmetric(horizontal: 32),
                  //       //     child: Center(
                  //       //       child: Row(
                  //       //         mainAxisAlignment: MainAxisAlignment.center,
                  //       //         children: [
                  //       //           'Get a quote'.poppins(
                  //       //             color: white,
                  //       //             height: 1.75,
                  //       //             fontWeight: FontWeight.w500,
                  //       //           ),
                  //       //           const SizedBox(width: 10),
                  //       //           const
                  //       // Icon(
                  //       //             FontAwesomeIcons.magnifyingGlass,
                  //       //             // FontAwesomeIcons.chevronRight,
                  //       //             color: white,
                  //       //             size: 12,
                  //       //           )
                  //       //         ],
                  //       //       ),
                  //       //     ),
                  //       //   ),
                  //       // ),
                  //       ),
                  // ),
                ],
              ),
            ),
            if (!Metrics.isTablet(context) && !Metrics.isDesktop(context))
              Center(
                child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      // radius: 25,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(232, 191, 66, 1), borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        // FontAwesomeIcons.chevronRight,
                        color: white,
                        size: 20,
                      ),
                    )),
              ),
          ],
        ),
      ),
    );
  }
}

class HeaderLeftSubtitle extends StatelessWidget {
  const HeaderLeftSubtitle({
    Key? key,
    required this.pad,
    required this.isBigScreen,
  }) : super(key: key);

  final double pad;
  final bool isBigScreen;

  @override
  Widget build(BuildContext context) {
    final pad1 = isBigScreen ? 0.0 : normalize(min: 576, max: 976, data: Metrics.width(context));
    return Padding(
      padding: EdgeInsets.only(right: (68.0 * pad) + (120 * pad1), left: 120 * pad1),
      // child: 'choose from over 20+ exclusive properties curated by Naina Asset'.poppins(
      //   textAlign: TextAlign.center,
      //   fontSize: 28,
      //   fontWeight: FontWeight.w500,
      //   color: white,
      //   height: 1,

      // ),
      child: Text(
        'choose from over 20+ exclusive properties curated by Naina Asset',
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: Metrics.isMobile(context) ? 16 : 28,
              fontWeight: FontWeight.w500,
              color: white,
              shadows: [Shadow(blurRadius: 2, color: Colors.black38, offset: Offset(2, 2))]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class HeaderLeftTitle extends StatelessWidget {
  const HeaderLeftTitle({Key? key, required this.isBigScreen}) : super(key: key);
  final bool isBigScreen;

  @override
  Widget build(BuildContext context) {
    final pad1 = isBigScreen ? 0.0 : normalize(min: 576, max: 976, data: Metrics.width(context));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 120 * pad1),
      child: 'NAINA ASSET'.poppins(
        // textAlign: isBigScreen ? TextAlign.left : TextAlign.center,
        textAlign: TextAlign.center,
        fontSize: Metrics.isMobile(context) ? 40 : 60,
        fontWeight: FontWeight.w200,
        color: white,
        height: 1,
      ),
    );
  }
}
