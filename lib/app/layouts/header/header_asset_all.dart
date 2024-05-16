import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:properties/app/layouts/experiences/experiences.dart';
import 'package:properties/core/core.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/metrics.dart';
import '../../components/appbar/appbar.dart';
import '../../widgets/base_container.dart';
import '../../widgets/icon_btn.dart';
import '../experiences/experiences_image.dart';
import '../experiences/experiences_info.dart';
import '../experiences/experiences_info_item.dart';
import 'header_left.dart';
import 'header_right.dart';

class Header_AssetAll extends StatelessWidget {
  const Header_AssetAll({
    Key? key,
    required GlobalKey<State<StatefulWidget>> headerKey,
  })  : _headerKey = headerKey,
        super(key: key);

  final GlobalKey<State<StatefulWidget>> _headerKey;

  @override
  Widget build(BuildContext context) {
    List<String> links = [
      'Property',
      'Check in',
      'Check out',
    ];
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));
    final bool isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);
    final pad1 = isBigScreen ? 0.0 : normalize(min: 576, max: 976, data: Metrics.width(context));

    return Container(
      color: const Color.fromRGBO(52, 49, 36, 1),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Container(
                key: _headerKey,
                width: Metrics.width(context),
                height: 720,
                // color: greenBorder,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/property_service/08.jpg'),
                      //  NetworkImage(
                      //     "https://drive.google.com/file/d/128N1Li3SURnZ_sn8DUsbCU-A6YKecTip/view"),
                      fit: BoxFit.cover,
                    ),
                    color: white),
                child: Column(
                  children: [
                    Container(
                        color: white,
                        child: Column(
                          children: [
                            BaseContainer(
                              child: SizedBox(
                                height: 70,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://s3-alpha-sig.figma.com/img/5da3/4bc4/1fbe5a4bd62aa21042bda5592db20d39?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=geKrfG~kUGFIFaThNK326NB9Xq-JXVPXqv69fq2oQWE0VhdxWskf354YLvNhQIm3EYT7zvTsMgDa5YStFmeYsFLS814xjFEKXVgLwjOxHlkPe1IeLMZppAMlrqx4v8ncGKbxTLCORQl7Er60asGy1b70hV21bYVYNHOldpvm3n6A8Cgt6rEhdrz1L4jpxv8Ye9RdJCgpb7OVElv6G8lvvnof0oUPTld4j1raiV8EpyuLJp4EhUuEsT-Mg2LgfJLuAeuIhc7xh-8UhOX7vV7YhuPAnHNz6ufW5tB6hQQw9BEqXBEh205iMqvnxp9TAuSUVdUBsWbathZzvvL~QL7Bcw__"),
                                              fit: BoxFit.cover,
                                              filterQuality: FilterQuality.high,
                                              isAntiAlias: true,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            'Naina Asset'.poppins(
                                              color: greenBg,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24,
                                              height: 1.5,
                                            ),
                                            'ในนา แอสเสท - บริการดูแลพร็อพเพอร์ตี้มืออาชีพ '.poppins(
                                              color: greenBg,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  (Metrics.isDesktop(context) || Metrics.isTablet(context)) ? 14 : 12,
                                              height: 1.5,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                                          Container(
                                            height: 30,
                                            width: 3,
                                            color: greenBg.withOpacity(0.5),
                                            margin: const EdgeInsets.symmetric(horizontal: 24),
                                          ),
                                        if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                                          ...List.generate(links.length, (index) {
                                            final link = links[index];

                                            return Padding(
                                              padding: EdgeInsets.only(left: index != 0 ? 24 : 0),
                                              child: TextButton(
                                                onPressed: () {},
                                                child: link.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  color: greenBg,
                                                  fontSize: 16,
                                                  height: 1.5,
                                                ),
                                              ),
                                            );
                                          }),
                                        if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                                          Container(
                                            height: 30,
                                            width: 3,
                                            color: greenBg.withOpacity(0.5),
                                            margin: const EdgeInsets.symmetric(horizontal: 24),
                                          ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.arrow_back,
                                              color: greenBg,
                                            ))
                                        // if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                                        //   Padding(
                                        //     padding: const EdgeInsets.only(left: 8.0),
                                        //     child: IconBtn(
                                        //       icon: FontAwesomeIcons.bars,
                                        //       onTap: () {},
                                        //     ),
                                        //   ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: Metrics.width(context),
                              height: 1,
                              // color: greenlight,
                            ),
                          ],
                        )),
                    Expanded(
                      child: BaseContainer(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: BaseContainer(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Asset_HeaderLeft(),
                                  // HeaderRight(),
                                ],
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          //   child: Container(
                          //     width: 130,
                          //     // height: 30,
                          //     margin: EdgeInsets.only(right: (72 * pad) + (120 * pad1), left: 120 * pad1),
                          //     padding: const EdgeInsets.all(4),
                          //     decoration: BoxDecoration(
                          //       borderRadius: const BorderRadius.only(
                          //         topLeft: Radius.circular(10),
                          //         topRight: Radius.circular(10),
                          //         bottomLeft: Radius.circular(0),
                          //         bottomRight: Radius.circular(0),
                          //       ),
                          //       color: brown2,
                          //     ),
                          //     child: Center(
                          //       child: 'Monthly Stay'.stixTwoText(
                          //         color: white,
                          //         fontWeight: FontWeight.w600,
                          //         fontSize: 14,
                          //         letterSpacing: 1,
                          //         height: 1.25,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   height: 72,
                          //   margin: EdgeInsets.only(right: (72 * pad) + (120 * pad1), left: 120 * pad1),
                          //   padding: const EdgeInsets.all(8),
                          //   decoration: BoxDecoration(
                          //     borderRadius: const BorderRadius.only(
                          //       topLeft: Radius.circular(20),
                          //       topRight: Radius.circular(20),
                          //       bottomLeft: Radius.circular(0),
                          //       bottomRight: Radius.circular(0),
                          //     ),
                          //     color: brown,
                          //     border: Border.all(color: const Color.fromARGB(255, 163, 161, 161), width: 1),
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         child: Align(
                          //           alignment: Alignment.center,
                          //           child: Padding(
                          //             padding: EdgeInsets.all(8.0),
                          //             child: TextButton(
                          //               onPressed: () {},
                          //               child: 'Have a Vacant Space in Chiang Mai?'.poppins(
                          //                 fontWeight: FontWeight.w500,
                          //                 color: Colors.black,
                          //                 fontSize: (Metrics.isDesktop(context) || Metrics.isTablet(context)) ? 16 : 12,
                          //                 height: 1.5,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
              Container(
                color: const Color.fromRGBO(52, 49, 36, 1),
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        'Become stress-free by letting us look after your property and earn passive income!'
                            .poppins(fontSize: 20, fontWeight: FontWeight.w600, color: white, letterSpacing: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (isBigScreen != Metrics.isTablet(context))
                              Expanded(
                                  child: const Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  statistics(
                                    text1: '15',
                                    text2: 'Years of Experiences in Real Estate Industry',
                                  ),
                                  statistics(
                                    text1: '45%',
                                    text2: 'Increase in booking from individual listing',
                                  ),
                                  statistics(
                                    text1: '62%',
                                    text2: 'Reduction in Fixed Costs by homeowners',
                                  ),
                                ],
                              )),
                            Expanded(
                              // width: 400,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: isBigScreen == Metrics.isTablet(context)
                                        ? EdgeInsets.all(4.0)
                                        : EdgeInsets.all(8.0),
                                    child: AspectRatio(
                                      aspectRatio: 4 / 2,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          'https://s3-alpha-sig.figma.com/img/9979/7153/bbb6af608b8a32eb4ef98dacf7c2a770?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=GA5Q78WcKSpdTIvOdcx7yBnfG~SeOwrq2mTzVeWj0hXVlLUZukpOPje1bCwa7xFso6KJZa~f0OZHD3R4Kn~0rn52qMJsIRDeXAT3JVN5btbiZWONK9cdqVIa5XXxa1BBu2gAqznUDg8jHdHbETKAzZxBTWP7wl57sBrQVUFXa5GAAPNpJeLSbqo68m2ZXSTE~Fk7cTQdOF1RQmaZSFyqnEfM109Q1DMfpSRQxFPVBYU0PhFm0AqSWFqekMU4ADKGziooUmUMG7cke-Rxkd-LFyKTMZ~8QFgehyzR37SHYOIn43z~H19Oh81WbTu-q~joQSQ6NZ6cdcTVkgPHoZWVtg__',
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: isBigScreen == Metrics.isTablet(context)
                                        ? EdgeInsets.all(4.0)
                                        : EdgeInsets.all(8.0),
                                    child: AspectRatio(
                                      aspectRatio: 4 / 2,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          'https://s3-alpha-sig.figma.com/img/9e5c/6fa0/965355bbb3309dcf68f7af1e8ce116ce?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=KpF94cOwjDQdTlZHuivmmdNYDuG58cCExR4zjge2TQlUXqo9HloQQ-s86WN0V4ajG2CQFDGyun0ZjHOFXtN0voDRStdjibi9L55Br1rrW3d-TxdlJDinSQ3gA44QisZMR5XC3FV31KpfQrNX9l5uavkYrMQFc4Pdkze7a4SH~HOhnxAs5cItOJtM8SDqBLfQgTeDLD25jcXhjGMmJWA4sSOW3ruTVCXCwvtlwkHcgtSgs5yvMSq7Qi4wEMUfZRiepjiXBmmIgdLg2qL4iTf6xz7ybv6imE-c6MjuAH9gTDLHPn08lNoT3I8dnFQSdzZWXyDVZezttq4IhcpR-MV-xA__',
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Container(
          //   width: Metrics.width(context),
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         BG_AboutUs.withOpacity(0.9),
          //         BG_AboutUs.withOpacity(0.8),
          //         BG_AboutUs.withOpacity(0.7),
          //         BG_AboutUs.withOpacity(0.6),
          //       ],
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //     ),
          //   ),
          //   // height: 600 + 100 * pad,
          //   child: Column(
          //     children: [
          //       BaseContainer(
          //         child: Column(
          //           children: [
          //             const SizedBox(height: 10),
          //             if (isBigScreen)
          //               for (int index1 = 0; index1 < 2; index1++)
          //                 SizedBox(
          //                   child: Column(
          //                     children: [
          //                       const SizedBox(height: 40),
          //                       Row(
          //                         children: [
          //                           Expanded(
          //                             flex: 2,
          //                             child: Column(
          //                               crossAxisAlignment:
          //                                   isBigScreen ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          //                               children: [
          //                                 Align(
          //                                   alignment: Alignment.center,
          //                                   child: '15'.msMadi(
          //                                     color: orange,
          //                                     fontSize: 52,
          //                                   ),
          //                                 ),
          //                                 Align(
          //                                   alignment: Alignment.center,
          //                                   child: 'Years of Experiences in Real Estate Industry.'.stixTwoText(
          //                                     textAlign: isBigScreen ? TextAlign.left : TextAlign.center,
          //                                     color: white,
          //                                     fontSize: 25,
          //                                     height: 1.5,
          //                                   ),
          //                                 ),
          //                                 const SizedBox(height: 28),
          //                               ],
          //                             ),
          //                           ),
          //                           Expanded(
          //                             child: Padding(
          //                               padding: const EdgeInsets.only(right: 60),
          //                               child: Stack(
          //                                 clipBehavior: Clip.none,
          //                                 children: [
          //                                   AspectRatio(
          //                                     aspectRatio: 2 / 1,
          //                                     child: ClipRRect(
          //                                       borderRadius: BorderRadius.circular(20),
          //                                       child: Image.network(
          //                                         'https://images.unsplash.com/photo-1611967164521-abae8fba4668?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
          //                                         fit: BoxFit.cover,
          //                                       ),
          //                                     ),
          //                                   ),
          //                                   // Positioned(
          //                                   //   top: 90,
          //                                   //   right: -60,
          //                                   //   child: Image.asset(
          //                                   //     'Clock.png'.image,
          //                                   //     width: 120,
          //                                   //     height: 120,
          //                                   //   ),
          //                                   // ),
          //                                 ],
          //                               ),
          //                             ),
          //                           )
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //             if (!isBigScreen)
          //               for (int index1 = 0; index1 < 2; index1++)
          //                 Column(
          //                   children: [
          //                     const SizedBox(height: 40),
          //                     Row(
          //                       children: [
          //                         Expanded(
          //                           child: Padding(
          //                             padding: const EdgeInsets.only(right: 60),
          //                             child: Stack(
          //                               clipBehavior: Clip.none,
          //                               children: [
          //                                 AspectRatio(
          //                                   aspectRatio: 2 / 1,
          //                                   child: ClipRRect(
          //                                     borderRadius: BorderRadius.circular(20),
          //                                     child: Image.network(
          //                                       'https://images.unsplash.com/photo-1611967164521-abae8fba4668?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
          //                                       fit: BoxFit.cover,
          //                                     ),
          //                                   ),
          //                                 ),
          //                                 // Positioned(
          //                                 //   top: 90,
          //                                 //   right: -60,
          //                                 //   child: Image.asset(
          //                                 //     'Clock.png'.image,
          //                                 //     width: 120,
          //                                 //     height: 120,
          //                                 //   ),
          //                                 // ),
          //                               ],
          //                             ),
          //                           ),
          //                         )
          //                       ],
          //                     ),
          //                     Column(
          //                       children: [
          //                         Align(
          //                           alignment: Alignment.center,
          //                           child: '15'.msMadi(
          //                             color: orange,
          //                             fontSize: 52,
          //                           ),
          //                         ),
          //                         Align(
          //                           alignment: Alignment.center,
          //                           child: 'Years of Experiences in Real Estate Industry.'.stixTwoText(
          //                             textAlign: isBigScreen ? TextAlign.left : TextAlign.center,
          //                             color: white,
          //                             fontSize: 25,
          //                             height: 1.5,
          //                           ),
          //                         ),
          //                         const SizedBox(height: 28),
          //                       ],
          //                     )
          //                   ],
          //                 ),
          //             const SizedBox(height: 90),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // )
          Positioned(
              child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: Container(
                margin: EdgeInsets.only(bottom: 70),
                padding: EdgeInsets.all(20.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50), color: Color.fromRGBO(171, 141, 62, 1)),
                child: 'Have a Vacant Space in Chiang Mai?'.poppins(
                  fontWeight: FontWeight.w600,
                  color: white,
                  fontSize: 30,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class Asset_HeaderLeft extends StatelessWidget {
  const Asset_HeaderLeft({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 976, max: 1440, data: Metrics.width(context));
    final bool isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: isBigScreen ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Asset_HeaderLeftTitle(isBigScreen: isBigScreen),
          const SizedBox(height: 24),
          Asset_HeaderLeftSubtitle(pad: pad, isBigScreen: isBigScreen),
          const SizedBox(height: 52),
        ],
      ),
    );
  }
}

class Asset_HeaderLeftSubtitle extends StatelessWidget {
  const Asset_HeaderLeftSubtitle({
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
        child: Text(
          'Professional \nProperty Management \nServices',
          style: TextStyle(
              color: Color.fromRGBO(72, 60, 60, 1),
              fontWeight: FontWeight.bold,
              fontSize: 50,
              height: 1.5,
              letterSpacing: 1,
              shadows: [Shadow(blurRadius: 2, color: Colors.black38, offset: Offset(2, 2))]),
        ));
  }
}

class Asset_HeaderLeftTitle extends StatelessWidget {
  const Asset_HeaderLeftTitle({Key? key, required this.isBigScreen}) : super(key: key);
  final bool isBigScreen;

  @override
  Widget build(BuildContext context) {
    final pad1 = isBigScreen ? 0.0 : normalize(min: 576, max: 976, data: Metrics.width(context));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 120 * pad1),
      child: Align(
        alignment: Alignment.centerLeft,
        child: 'NAINA ASSET'
            .toUpperCase()
            .poppins(color: Color.fromRGBO(72, 60, 60, 1), fontSize: 30 + 4 * pad1, fontWeight: FontWeight.w400),
      ),
    );
  }
}
