import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:properties/core/core.dart';

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
    final bool isBigScreen =
        Metrics.isDesktop(context) || Metrics.isTablet(context);

    return Expanded(
      child: Column(
        crossAxisAlignment:
            isBigScreen ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HeaderLeftTitle(isBigScreen: isBigScreen),
          const SizedBox(height: 24),
          HeaderLeftSubtitle(pad: pad, isBigScreen: isBigScreen),
          const SizedBox(height: 52),
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
    final bool isBigScreen =
        Metrics.isDesktop(context) || Metrics.isTablet(context);
    final pad1 = isBigScreen
        ? 0.0
        : normalize(min: 576, max: 976, data: Metrics.width(context));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Container(
            width: 130,
            // height: 30,
            margin: EdgeInsets.only(
                right: (72 * pad) + (120 * pad1), left: 120 * pad1),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              color: brown2,
            ),
            child: Center(
              child: 'Monthly Stay'.stixTwoText(
                color: white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 1,
                height: 1.25,
              ),
            ),
          ),
        ),
        Container(
          height: 72,
          margin: EdgeInsets.only(
              right: (72 * pad) + (120 * pad1), left: 120 * pad1),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: white,
            border: Border.all(
                color: const Color.fromARGB(255, 163, 161, 161), width: 1),
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

                    return Row(
                      children: [
                        if (Metrics.isDesktop(context) ||
                            Metrics.isTablet(context))
                          if (index != 0)
                            Container(
                              height: 30,
                              width: 1,
                              color: Colors.grey.withOpacity(0.5),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 24),
                            ),
                        Padding(
                          padding: EdgeInsets.only(left: index != 0 ? 24 : 0),
                          child: TextButton(
                            onPressed: () {},
                            child: link.poppins(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: (Metrics.isDesktop(context) ||
                                      Metrics.isTablet(context))
                                  ? 16
                                  : 12,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
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
              InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: brown,
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
      ],
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
    final pad1 = isBigScreen
        ? 0.0
        : normalize(min: 576, max: 976, data: Metrics.width(context));
    return Padding(
      padding:
          EdgeInsets.only(right: (68.0 * pad) + (120 * pad1), left: 120 * pad1),
      child:
          'choose from over 20+ exclusive properties by Naina Asset.'.poppins(
        textAlign: isBigScreen ? TextAlign.left : TextAlign.center,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: white,
        height: 1.5,
      ),
    );
  }
}

class HeaderLeftTitle extends StatelessWidget {
  const HeaderLeftTitle({Key? key, required this.isBigScreen})
      : super(key: key);
  final bool isBigScreen;

  @override
  Widget build(BuildContext context) {
    final pad1 = isBigScreen
        ? 0.0
        : normalize(min: 576, max: 976, data: Metrics.width(context));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 120 * pad1),
      child: 'NAINA ASSET'.stixTwoText(
        textAlign: isBigScreen ? TextAlign.left : TextAlign.center,
        fontSize: 90,
        fontWeight: FontWeight.bold,
        color: white,
        height: 1.1,
      ),
    );
  }
}
