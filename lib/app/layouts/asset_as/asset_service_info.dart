import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:properties/app/widgets/base_container.dart';
import 'package:properties/app/with_us.dart';
import 'package:properties/core/core.dart';

import '../about_us/image_clider_controller.dart';
import '../footer/footer.dart';
import '../header/header_asset_all.dart';
import '../header/header_rent.dart';

class Asset_Service_Info extends ConsumerStatefulWidget {
  const Asset_Service_Info({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Asset_Service_InfoState();
}

class _Asset_Service_InfoState extends ConsumerState<Asset_Service_Info> {
  int limit = 2; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
///////----------------------------------------------->
  late ScrollController _baseController;

  final GlobalKey _headerKey = GlobalKey();
  ///////----------------------------------------------->
  late PageController _controller;
  int currentPage = 0;
///////----------------------------------------------->
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
    _controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.25,
    );
    read_links_limit();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
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
    double plus =
        Metrics.isDesktop(context) ? 0 : (0.5 * (1 - normalize(min: 976, max: 1440, data: Metrics.width(context))));
    _controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.25 + plus,
    );
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
                  Header_AssetAll(
                    headerKey: _headerKey,
                  ),
                  // Container(
                  //     color: brown.withOpacity(0.1), child: const Appbar()),
                  const SizedBox(height: 80),
                  Align(
                    alignment: Alignment.center,
                    child: '#Service information#'.poppins(
                      color: brown,
                      fontSize: 25 + 4 * pad,
                    ),
                  ),

                  const SizedBox(height: 34),
                  SizedBox(
                    height: 400 + 100 * pad,
                    child: PageView.builder(
                      controller: _controller,
                      onPageChanged: (val) => setState(() => currentPage = val),
                      itemCount: images.length,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final img = images[index];

                        return Padding(
                          padding: EdgeInsets.only(left: 36 * pad, right: 36 * pad),
                          child: AnimatedScale(
                            duration: const Duration(milliseconds: 240),
                            scale: currentPage == index ? 1 : 0.75,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 240),
                              opacity: currentPage == index ? 1 : 0.25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(img, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ImageSliderController(
                    currentPage: currentPage,
                    images: images,
                    title: title,
                    prev: currentPage != 0
                        ? () {
                            _controller.animateToPage(
                              currentPage - 1,
                              duration: const Duration(milliseconds: 240),
                              curve: Curves.linear,
                            );
                          }
                        : null,
                    next: (currentPage != images.length - 1)
                        ? () {
                            _controller.animateToPage(
                              currentPage + 1,
                              duration: const Duration(milliseconds: 240),
                              curve: Curves.linear,
                            );
                          }
                        : null,
                  ),
                  const SizedBox(height: 34),
                  BaseContainer(
                      child: Column(
                          crossAxisAlignment:
                              Metrics.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                          children: [
                        for (int index = 0; index < 4; index++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child:
                                  'With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don\'t worry about contacting us. Because we always have good suggestions.'
                                      .poppins(
                                textAlign: TextAlign.center,
                                fontSize: 14 + 4 * pad,
                                fontWeight: FontWeight.w500,
                                height: 1.75,
                              ),
                            ),
                          ),
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
