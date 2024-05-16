import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:properties/app/widgets/base_container.dart';
import 'package:properties/app/with_us.dart';
import 'package:properties/core/core.dart';

import '../core/models/blog_model.dart';
import '../core/providers/scroll_provider.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/methods.dart';
import '../core/utils/metrics.dart';
import 'components/appbar/appbar.dart';
import 'asset_all.dart';
import 'layouts/about_us/image_clider_controller.dart';
import 'layouts/contact_us/contactus.dart';
import 'layouts/custom_decoratives/custom_decoratives.dart';
import 'layouts/footer/footer.dart';
import 'layouts/header/header_rent.dart';
import 'layouts/layouts.dart';

class BlogAll extends ConsumerStatefulWidget {
  const BlogAll({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BlogAllState();
}

List<String> title = [
  'Decorations &\n Renovations',
  'Photography &\n Listing',
  'Guest \n Communications',
  'Cleaning &\n Maintenance',
];
List<String> images = [
  'https://s3-alpha-sig.figma.com/img/f477/4294/2841c937d8b24966c3412826595763f2?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oawp-dyDFaADsZLx9dKvWaB3MjbTbuWdTKH2GnWFrl~VxDFKborw3zV96wjilbmdJPnx4~R4wO9ya5dL~f2G5n0DZKdIZvpt9GV2IAWJxVq4CgfFHsrekkQrVTeWoc6TvlKtvr2qkzyZQ2t-9AhEpXUypNSsbfXUXIB73WzrOzICaSEJ8hsug4Nx71xHbEaZZS1guLHv~qlFNi19LloRIHSBUaavkz3TGILRpCDoUflZZCL40uR60p4db12EsnAQngDZmPm6bvTyc5h5cndza0SjwShbOC6sEgt2G0N~eLTLU7wEp6oOG-lZVnwxUj7T2mJu5A0CpQckgPOHuV0~Rg__',
  'https://s3-alpha-sig.figma.com/img/7bda/143f/e5a98a6fe7b614f448514de91a6f75c2?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=S6m2PtH5ICHxiyhq6pYhNbxQUHVUWnkaHH0K3hYoUs3Jr4AJVxs4fFZZLQd4ZyO056wVNR0aXUWqpXcHCMxLvnurLZN3cVnMv-Ud7V~oL5X7R6QSzFlXl7URGE9meZf7M89NTfFUKowtjXxoFv0NH23bEPdKFMnK7eo5xtnPwnM5~SS0ftoG3JAb4FV~21WS9N7X7ZK7NjEFuY5MpsOUU2LNRAWc4uwUy4R0lShaGqqsOkIDe23lmls34dvmhBXbPg-dWraPzCdrPAMsVh6vV7QFnRYbYjmx57i06kF7IeORq9HD6GsocO96b3RGtEGn0a3jW0w790g1q8pSHPYLCg__',
  'https://s3-alpha-sig.figma.com/img/5e7a/95c4/8a9dd8afc379f258b23cc4fc928b75c0?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=X9g~6TCf1mu4~dyXOMaQJfF3ic8ce6ezQCRRN6~w2Q-EdaJ0gqrEpVuWkJu86k9XysWA61ZuinqApq7AiU~HwZSy6Pcp5A7aUnjUbvS0Y1dhtGx7DZ1R9Te~K4CeJkHGBG0UNl1U30JiiLXyzxHovQSdnbmsLX6vClU-kgyOVruEgHm1Sgz6XfzPN3uMfeH~Nxt92TCOpg99D6ZRxhXPrDodntQDPpWZ5vneCKMf1re2p1nY24wWwEkYhF2g4-kk8c3QN9FKwCuJ-jIt-Q9JPQECEb45Uytr1Au1NaHnH-cXvKg6DPnFZJoSR~HG7-mzkuDkqmktOkaWYV7-zhUj3w__',
  'https://s3-alpha-sig.figma.com/img/248c/9403/08be956057a64cc8e78ca17e8bb7dd0d?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Jrj48c60uvOZQFA1wZZtAMlI41-m6yCRMcHgsdlQlAAglcJO3V3nwAVuMv3iFrstUns~xabHhdnbrB2sf1En7Gk4vvTQfrIamU-gy8MVcrbt3djVwb1DTWNDyBs~MyNFOlOkWg5SKMKAu-XAl6f3~KCbkzExhcFDz3xUh8CTmQ3rcaj-nLm4EHBeE8OAHPFTVKyiQtKv-rfaHbEkrRM2LjllXR0cEoFhzatk0qo3Zc91y1hzKuLKeVBHPgACQQK3cdFi00l9FNHK57Mm0o-N1jhAWfT4hynF~GXu3QtNW7tRffh7aU5cB8-kJtDRfb4yp5HeazlJrEiXJcJ2IDjBXA__',
];

class _BlogAllState extends ConsumerState<BlogAll> {
  int limit = 8; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
///////----------------------------------------------->
  late PageController _controller;
  int currentPage = 0;
///////----------------------------------------------->
  late ScrollController _baseController;

  final GlobalKey _headerKey = GlobalKey();

///////----------------------------------------------->
  List<BlogModel> limitedList_blogmodels = [];

  List<bool> isHover = [];

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
        limitedList_blogmodels.length,
        (index) => false,
      );
    });
  }

///////----------------------------------------------->
  Future<Null> read_links_limit() async {
    setState(() {
      endIndex = offset + limit;
      limitedList_blogmodels = blogmodel.sublist(
          offset, // Start index
          (endIndex <= blogmodel.length) ? endIndex : blogmodel.length // End index
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
                    child: 'Blogs'.poppins(
                      color: Color.fromRGBO(71, 69, 69, 1),
                      fontSize: 25 + 4 * pad,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: 'Read more about Property and Real Estate Trends!'.poppinscenter(
                        color: const Color(0xff896e57),
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),

                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: BaseContainer(
                        child: Column(
                            crossAxisAlignment:
                                Metrics.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                            children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: 'Latest'.toUpperCase().poppins(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                  letterSpacing: 1,
                                ),
                          ),
                          // for (int index1 = 0; index1 < links.length; index1++)
                          GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Metrics.isMobile(context)
                                  ? 1
                                  : Metrics.isCompact(context)
                                      ? 2
                                      : Metrics.isTablet(context)
                                          ? 3
                                          : 4,
                              childAspectRatio: 285 / (320),
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 10,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: limitedList_blogmodels.length,
                            itemBuilder: (context, index) {
                              // final gridItem = blogmodel[index];

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
                                    onEnter: (val) => setState(() => isHover[index] = true),
                                    onExit: (val) => setState(() => isHover[index] = false),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 240),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        // color: isHover[index] ? Colors.grey[100] : white.withOpacity(0),
                                        color: white,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: isHover[index]
                                                ? textPrimary.withOpacity(0.15)
                                                : textPrimary.withOpacity(0),
                                            offset: const Offset(0, 6),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              // Return an AlertDialog
                                              return Dialog.fullscreen(
                                                child: SingleChildScrollView(
                                                  scrollDirection: Axis.vertical,
                                                  child: Container(
                                                    // width: double.infinity,
                                                    // height: double.infinity,
                                                    // decoration: BoxDecoration(
                                                    //   color: white,
                                                    //   borderRadius: BorderRadius.zero,
                                                    // ),
                                                    padding: EdgeInsets.all(16.0),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding: const EdgeInsets.all(8.0),
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(width: 1, color: Colors.grey))),
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              limitedList_blogmodels[index].budget.poppinsBlog(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Color.fromRGBO(71, 69, 69, 1)),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: Container(
                                                                  padding: EdgeInsets.all(8.0),
                                                                  decoration: BoxDecoration(
                                                                      color: black,
                                                                      borderRadius: BorderRadius.circular(4)),
                                                                  child: 'Close'.poppins(
                                                                    color: white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Center(
                                                            child: FractionallySizedBox(
                                                              widthFactor: 0.7,
                                                              child: Column(
                                                                children: [
                                                                  AspectRatio(
                                                                    aspectRatio: 16 / 9,
                                                                    child: Image.network(
                                                                      limitedList_blogmodels[index].imgPath,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              vertical: 16.0),
                                                                          child: 'FRUIT'.toUpperCase().poppins(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w400,
                                                                              color: Color.fromRGBO(64, 178, 201, 1)),
                                                                        ),
                                                                        ' - 5 mins read'.poppins(
                                                                            fontSize: 12, fontWeight: FontWeight.w400)
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  "With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don't worry about contacting us. Because we always have good suggestions.With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don't worry about contacting us. Because we always have good suggestions."
                                                                      .poppins(
                                                                          color: Color.fromRGBO(87, 87, 87, 1),
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w400,
                                                                          textAlign: TextAlign.center),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 60,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        mouseCursor: SystemMouseCursors.click,
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 12 * pad),
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
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
                                              AspectRatio(
                                                aspectRatio: 285 / 180,
                                                child: ClipRRect(
                                                  // borderRadius: BorderRadius.circular(8),
                                                  child: Image.network(
                                                    limitedList_blogmodels[index].imgPath,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                            child: 'FRUIT'.toUpperCase().poppins(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w400,
                                                                color: Color.fromRGBO(64, 178, 201, 1)),
                                                          ),
                                                          ' - 5 mins read'
                                                              .poppins(fontSize: 12, fontWeight: FontWeight.w400)
                                                        ],
                                                      ),
                                                      // Padding(
                                                      //   padding: const EdgeInsets.all(4),
                                                      //   child:
                                                      //       '[${limitedList_blogmodels[index].id}] ${limitedList_blogmodels[index].title}'
                                                      //           .poppins(
                                                      //     fontWeight: FontWeight.bold,
                                                      //     fontSize: 16,
                                                      //   ),
                                                      // ),
                                                      limitedList_blogmodels[index].budget.poppinsBlog(
                                                            fontSize: 14,
                                                          ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            },
                          ),
                          // const SizedBox(height: 34),
                          // ImageSliderController(
                          //   currentPage: currentPage,
                          //   title: title,
                          //   images: [for (int index = 0; index < (blogmodel.length / limit).ceil(); index++) ''],
                          //   prev: currentPage != 0
                          //       ? () {
                          //           setState(() {
                          //             currentPage = currentPage - 1;
                          //             offset = offset - limit;
                          //           });
                          //           read_links_limit();
                          //           // print('currentPage');
                          //           // print(currentPage);
                          //           // _controller.animateToPage(
                          //           //   currentPage - 1,
                          //           //   duration: const Duration(milliseconds: 240),
                          //           //   curve: Curves.linear,
                          //           // );
                          //         }
                          //       : null,
                          //   next: ((endIndex / limit) == (blogmodel.length / limit).ceil())
                          //       ? null
                          //       : () {
                          //           setState(() {
                          //             currentPage = currentPage + 1;
                          //             offset = offset + limit;
                          //           });
                          //           read_links_limit();
                          //           // _controller.animateToPage(
                          //           //   currentPage + 1,
                          //           //   duration: const Duration(milliseconds: 240),
                          //           //   curve: Curves.linear,
                          //           // );
                          //           // print('currentPage');
                          //           // print(currentPage);
                          //         },
                          // ),
                        ])),
                  ),
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
