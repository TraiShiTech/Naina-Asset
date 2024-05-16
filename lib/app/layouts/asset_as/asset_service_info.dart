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
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Asset_Service_InfoState();
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
  List<String> images = [
    'https://images.unsplash.com/photo-1579656592043-a20e25a4aa4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1618220179428-22790b461013?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=654&q=80',
    'https://images.unsplash.com/photo-1551298370-9d3d53740c72?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1540932239986-30128078f3c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1540638349517-3abd5afc5847?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
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
    await Scrollable.ensureVisible(key.currentContext!,
        duration: const Duration(milliseconds: 480));
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
    final pad1 = isBigScreen
        ? 0.0
        : normalize(min: 576, max: 976, data: Metrics.width(context));
    double plus = Metrics.isDesktop(context)
        ? 0
        : (0.5 *
            (1 - normalize(min: 976, max: 1440, data: Metrics.width(context))));
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
                          padding:
                              EdgeInsets.only(left: 36 * pad, right: 36 * pad),
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
                          crossAxisAlignment: Metrics.isMobile(context)
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
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
