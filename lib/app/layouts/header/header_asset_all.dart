import 'package:flutter/material.dart';
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
    final bool isBigScreen =
        Metrics.isDesktop(context) || Metrics.isTablet(context);
    final pad1 = isBigScreen
        ? 0.0
        : normalize(min: 576, max: 976, data: Metrics.width(context));

    return Container(
      child: Column(
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
            ),
            child: Column(
              children: [
                Container(
                    color: white.withOpacity(0.3),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        'Naina Asset'.poppins(
                                          color: greenBg,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          height: 1.5,
                                        ),
                                        'ในนา แอสเสท - บริการดูแลพร็อพเพอร์ตี้มืออาชีพ '
                                            .poppins(
                                          color: greenBg,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              (Metrics.isDesktop(context) ||
                                                      Metrics.isTablet(context))
                                                  ? 14
                                                  : 12,
                                          height: 1.5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    if (Metrics.isDesktop(context) ||
                                        Metrics.isTablet(context))
                                      Container(
                                        height: 30,
                                        width: 3,
                                        color: greenBg.withOpacity(0.5),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                      ),
                                    if (Metrics.isDesktop(context) ||
                                        Metrics.isTablet(context))
                                      ...List.generate(links.length, (index) {
                                        final link = links[index];

                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: index != 0 ? 24 : 0),
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
                                    if (Metrics.isDesktop(context) ||
                                        Metrics.isTablet(context))
                                      Container(
                                        height: 30,
                                        width: 3,
                                        color: greenBg.withOpacity(0.5),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 24),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Container(
                          width: 130,
                          // height: 30,
                          margin: EdgeInsets.only(
                              right: (72 * pad) + (120 * pad1),
                              left: 120 * pad1),
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
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                          color: brown,
                          border: Border.all(
                              color: const Color.fromARGB(255, 163, 161, 161),
                              width: 1),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: 'Have a Vacant Space in Chiang Mai?'
                                        .poppins(
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
          Container(
            width: Metrics.width(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  BG_AboutUs.withOpacity(0.9),
                  BG_AboutUs.withOpacity(0.8),
                  BG_AboutUs.withOpacity(0.7),
                  BG_AboutUs.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            // height: 600 + 100 * pad,
            child: Column(
              children: [
                BaseContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      if (isBigScreen)
                        for (int index1 = 0; index1 < 2; index1++)
                          SizedBox(
                            child: Column(
                              children: [
                                const SizedBox(height: 40),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: isBigScreen
                                            ? CrossAxisAlignment.start
                                            : CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: '15'.msMadi(
                                              color: orange,
                                              fontSize: 52,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child:
                                                'Years of Experiences in Real Estate Industry.'
                                                    .stixTwoText(
                                              textAlign: isBigScreen
                                                  ? TextAlign.left
                                                  : TextAlign.center,
                                              color: white,
                                              fontSize: 25,
                                              height: 1.5,
                                            ),
                                          ),
                                          const SizedBox(height: 28),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 60),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 2 / 1,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  'https://images.unsplash.com/photo-1611967164521-abae8fba4668?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            // Positioned(
                                            //   top: 90,
                                            //   right: -60,
                                            //   child: Image.asset(
                                            //     'Clock.png'.image,
                                            //     width: 120,
                                            //     height: 120,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                      if (!isBigScreen)
                        for (int index1 = 0; index1 < 2; index1++)
                          Column(
                            children: [
                              const SizedBox(height: 40),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 60),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 2 / 1,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                'https://images.unsplash.com/photo-1611967164521-abae8fba4668?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          // Positioned(
                                          //   top: 90,
                                          //   right: -60,
                                          //   child: Image.asset(
                                          //     'Clock.png'.image,
                                          //     width: 120,
                                          //     height: 120,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: '15'.msMadi(
                                      color: orange,
                                      fontSize: 52,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child:
                                        'Years of Experiences in Real Estate Industry.'
                                            .stixTwoText(
                                      textAlign: isBigScreen
                                          ? TextAlign.left
                                          : TextAlign.center,
                                      color: white,
                                      fontSize: 25,
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                ],
                              )
                            ],
                          ),
                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ],
            ),
          )
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
    final bool isBigScreen =
        Metrics.isDesktop(context) || Metrics.isTablet(context);

    return Expanded(
      child: Column(
        crossAxisAlignment:
            isBigScreen ? CrossAxisAlignment.start : CrossAxisAlignment.center,
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
    final pad1 = isBigScreen
        ? 0.0
        : normalize(min: 576, max: 976, data: Metrics.width(context));
    return Padding(
      padding:
          EdgeInsets.only(right: (68.0 * pad) + (120 * pad1), left: 120 * pad1),
      child: 'Professional Property Management Services'.poppins(
        textAlign: isBigScreen ? TextAlign.left : TextAlign.center,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: black,
        height: 1.5,
      ),
    );
  }
}

class Asset_HeaderLeftTitle extends StatelessWidget {
  const Asset_HeaderLeftTitle({Key? key, required this.isBigScreen})
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
        color: black,
        height: 1.1,
      ),
    );
  }
}
