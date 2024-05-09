import 'package:flutter/material.dart';
import 'package:properties/core/core.dart';

import '../../../core/utils/metrics.dart';
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

  List<Icon> icons_links = [
    Icon(Icons.home),
    Icon(Icons.offline_share),
    Icon(Icons.home_work),
    Icon(Icons.search),
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
    final pad1 = isBigScreen
        ? 0.0
        : normalize(min: 576, max: 976, data: Metrics.width(context));

    return BaseContainer(
      child: Column(
        crossAxisAlignment: Metrics.isMobile(context)
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          Align(
            alignment: Alignment.center,
            child:
                'All properties are handpicked, curated and managed by us! Become worry-free by choosing us today!'
                    .poppinscenter(
              color: const Color(0xff896e57),
              fontWeight: FontWeight.bold,
              height: 1.5,
              letterSpacing: 1,
            ),
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
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'long term stay rents ',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'in Chiang Mai, Thailand',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: Metrics.width(context),
              height: 72,
              padding: const EdgeInsets.all(8),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                  ...List.generate(links.length, (index) {
                    final link = links[index];

                    return Column(
                      children: [
                        icons_links[index],
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
              ),
            ),
          ),
          const SizedBox(height: 40),
          if (isHover.length != 0)
            BaseContainer(
                child: Column(
                    crossAxisAlignment: Metrics.isMobile(context)
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                  for (int index1 = 0;
                      index1 < limitedList_links.length;
                      index1++)
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Metrics.isMobile(context)
                                  ? 1
                                  : Metrics.isCompact(context)
                                      ? 2
                                      : Metrics.isTablet(context)
                                          ? 3
                                          : 4,
                              childAspectRatio: 285 / (340),
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 0,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              final gridItem = decorativeItems[index];

                              return MouseRegion(
                                  onEnter: (val) => setState(
                                      () => isHover[index1][index] = true),
                                  onExit: (val) => setState(
                                      () => isHover[index1][index] = false),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 240),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isHover[index1][index]
                                          ? Colors.grey[100]
                                          : white.withOpacity(0),
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
                                      margin: EdgeInsets.only(
                                          bottom: 12 + 12 * pad),
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.25),
                                            offset: const Offset(0, 4),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 285 / 230,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Image.network(
                                                gridItem.imgPath,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(24),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  gridItem.title.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      gridItem.subtitle.poppins(
                                                        fontSize: 18,
                                                      ),
                                                      gridItem.price.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (links.length > 3)
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          Next_links_limit();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: EdgeInsets.only(bottom: 12 + 12 * pad),
                          decoration: BoxDecoration(
                            color: Colors.grey[300]!.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: 'view all properties'.toUpperCase().poppins(
                                color: black,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                                letterSpacing: 1,
                              ),
                        ),
                      ),
                    )
                ])),
          const SizedBox(height: 80),
          'Have a vacant property? Why not list with us!'.stixTwoText(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),
          'Please kindly leave your email or phone number and we will get back to you as soon as possible!'
              .toUpperCase()
              .poppins(
                color: const Color(0xff896e57),
                fontWeight: FontWeight.bold,
                height: 1.5,
                letterSpacing: 1,
              ),
          AspectRatio(
            aspectRatio: 45 / 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                decorativeItems[0].imgPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 48),
          if (isBigScreen)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                cards.length,
                (index) => HowItWorksCardItem(
                  item: cards[index],
                ),
              ),
            ),
          if (Metrics.isCompact(context))
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                2,
                (index) => HowItWorksCardItem(
                  item: cards[index],
                ),
              ),
            ),
          if (Metrics.isCompact(context))
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                2,
                (index) => HowItWorksCardItem(
                  item: cards[index + 2],
                ),
              ),
            ),
          if (Metrics.isMobile(context))
            Column(
              children: List.generate(
                cards.length,
                (index) => Row(
                  children: [
                    HowItWorksCardItem(
                      item: cards[index],
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
