import 'package:flutter/material.dart';
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
    await Scrollable.ensureVisible(key.currentContext!,
        duration: const Duration(milliseconds: 480));
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
          (endIndex <= blogmodel.length)
              ? endIndex
              : blogmodel.length // End index
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
                      color: brown,
                      fontSize: 25 + 4 * pad,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: 'Read more about Property and Real Estate Trends!'
                          .poppinscenter(
                        color: const Color(0xff896e57),
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),

                  BaseContainer(
                      child: Column(
                          crossAxisAlignment: Metrics.isMobile(context)
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
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

                        SizedBox(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Metrics.isMobile(context)
                                  ? 1
                                  : Metrics.isCompact(context)
                                      ? 2
                                      : Metrics.isTablet(context)
                                          ? 3
                                          : 4,
                              childAspectRatio: 285 / (320),
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 0,
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
                                    onEnter: (val) =>
                                        setState(() => isHover[index] = true),
                                    onExit: (val) =>
                                        setState(() => isHover[index] = false),
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 240),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: isHover[index]
                                            ? Colors.grey[100]
                                            : white.withOpacity(0),
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
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: 12 + 12 * pad),
                                        decoration: BoxDecoration(
                                          color: white,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
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
                                              aspectRatio: 285 / 180,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  limitedList_blogmodels[index]
                                                      .imgPath,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(24),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child:
                                                          '[${limitedList_blogmodels[index].id}] ${limitedList_blogmodels[index].title}'
                                                              .poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    limitedList_blogmodels[
                                                            index]
                                                        .budget
                                                        .poppinsBlog(
                                                          fontSize: 14,
                                                        ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 34),
                        ImageSliderController(
                          currentPage: currentPage,
                          images: [
                            for (int index = 0;
                                index < (blogmodel.length / limit).ceil();
                                index++)
                              ''
                          ],
                          prev: currentPage != 0
                              ? () {
                                  setState(() {
                                    currentPage = currentPage - 1;
                                    offset = offset - limit;
                                  });
                                  read_links_limit();
                                  // print('currentPage');
                                  // print(currentPage);
                                  // _controller.animateToPage(
                                  //   currentPage - 1,
                                  //   duration: const Duration(milliseconds: 240),
                                  //   curve: Curves.linear,
                                  // );
                                }
                              : null,
                          next: ((endIndex / limit) ==
                                  (blogmodel.length / limit).ceil())
                              ? null
                              : () {
                                  setState(() {
                                    currentPage = currentPage + 1;
                                    offset = offset + limit;
                                  });
                                  read_links_limit();
                                  // _controller.animateToPage(
                                  //   currentPage + 1,
                                  //   duration: const Duration(milliseconds: 240),
                                  //   curve: Curves.linear,
                                  // );
                                  // print('currentPage');
                                  // print(currentPage);
                                },
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
