import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:properties/app/widgets/base_container.dart';
import 'package:properties/app/with_us.dart';
import 'package:properties/core/core.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../core/models/about_us_model.dart';
import '../core/models/img_aboutUsAll_model.dart';
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

class AboutUs_All extends ConsumerStatefulWidget {
  const AboutUs_All({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AboutUs_AllState();
}

class _AboutUs_AllState extends ConsumerState<AboutUs_All> {
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
  List<AboutUsModel> AboutUsModels = [];
  List<imgaboutUsAllmodel> imgaboutUsAllmodels = [];
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
    _controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.25,
    );
    read_GC_AboutUsAll();
    read_GC_AboutUs_Img();
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

///////----------------------------------------------->
  Future<Null> read_GC_AboutUsAll() async {
    if (AboutUsModels.length != 0) {
      AboutUsModels.clear();
    }

    String url = '${MyConstant().domain}/GC_AboutUsAll.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        AboutUsModel AboutUsModelss = AboutUsModel.fromJson(map);

        setState(() {
          AboutUsModels.add(AboutUsModelss);
        });
      }
    } catch (e) {}
  }

///////----------------------------------------------->
  Future<Null> read_GC_AboutUs_Img() async {
    if (imgaboutUsAllmodels.length != 0) {
      imgaboutUsAllmodels.clear();
    }

    String url = '${MyConstant().domain}/GC_AboutUs_Img.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        imgaboutUsAllmodel imgaboutUsAllmodelss =
            imgaboutUsAllmodel.fromJson(map);
        setState(() {
          imgaboutUsAllmodels.add(imgaboutUsAllmodelss);
        });
      }
      read_isHover();
    } catch (e) {}
  }

///////----------------------------------------------->
  Future<void> read_isHover() async {
    setState(() {
      isHover = List.generate(
        imgaboutUsAllmodels.length,
        (index) => false,
      );
    });
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
    List<String> imageUrls =
        imgaboutUsAllmodels.map((data) => data.img.toString()).toList();
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
                    child: 'About Us'.poppins(
                        color: Color.fromRGBO(71, 69, 69, 1),
                        fontSize: 25 + 4 * pad,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: '${AboutUsModels[0].content}'.poppinscenter(
                        color: Color.fromRGBO(71, 69, 69, 1),
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 34),
                  SizedBox(
                    height: 400 + 100 * pad,
                    child: PageView.builder(
                      controller: _controller,
                      onPageChanged: (val) => setState(() => currentPage = val),
                      itemCount: imgaboutUsAllmodels.length,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // final img = images[index];

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
                                child: Image.network(
                                    imgaboutUsAllmodels[index].img.toString(),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 300 * pad,
                      child: ImageSliderController(
                        currentPage: currentPage,
                        images: imageUrls,
                        title: [],
                        prev: currentPage != 0
                            ? () {
                                _controller.animateToPage(
                                  currentPage - 1,
                                  duration: const Duration(milliseconds: 240),
                                  curve: Curves.linear,
                                );
                              }
                            : null,
                        next: (currentPage != imgaboutUsAllmodels.length - 1)
                            ? () {
                                _controller.animateToPage(
                                  currentPage + 1,
                                  duration: const Duration(milliseconds: 240),
                                  curve: Curves.linear,
                                );
                              }
                            : null,
                      ),
                    ),
                  ),
                  //     :
                  // FractionallySizedBox(
                  //   widthFactor: 0.9,
                  //   child: Row(
                  //     children: [
                  //       for (var index = 0;
                  //           index < imgaboutUsAllmodels.length;
                  //           index++)
                  //         Expanded(
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(16),
                  //             child: AspectRatio(
                  //               aspectRatio: 9 / 16,
                  //               child: Container(
                  //                 margin: EdgeInsets.all(8.0),
                  //                 padding: EdgeInsets.all(8),
                  //                 clipBehavior: Clip.antiAlias,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius:
                  //                       BorderRadius.all(Radius.circular(10)),
                  //                   image: DecorationImage(
                  //                     // colorFilter: ColorFilter.mode(Colors.white38, BlendMode.softLight),
                  //                     image: NetworkImage(
                  //                         imgaboutUsAllmodels[index]
                  //                             .img
                  //                             .toString()),
                  //                     // image: NetworkImage(content_image[index]),
                  //                     fit: BoxFit.cover,
                  //                     alignment: index == 1
                  //                         ? Alignment.centerLeft
                  //                         : Alignment.center,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 34),
                  BaseContainer(
                      child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Column(
                        crossAxisAlignment: Metrics.isMobile(context)
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          for (int index = 0; index < 3; index++)
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: (index == 0)
                                    ? '${AboutUsModels[0].content}'.poppins(
                                        textAlign: TextAlign.center,
                                        fontSize: 14 + 4 * pad,
                                        fontWeight: FontWeight.w400,
                                        height: 1.75,
                                        color: Color.fromRGBO(87, 87, 87, 1))
                                    : (index == 1)
                                        ? '${AboutUsModels[0].content_sub1}'
                                            .poppins(
                                                textAlign: TextAlign.center,
                                                fontSize: 14 + 4 * pad,
                                                fontWeight: FontWeight.w400,
                                                height: 1.75,
                                                color: Color.fromRGBO(
                                                    87, 87, 87, 1))
                                        : (index == 2)
                                            ? '${AboutUsModels[0].content_sub2}'
                                                .poppins(
                                                    textAlign: TextAlign.center,
                                                    fontSize: 14 + 4 * pad,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.75,
                                                    color: Color.fromRGBO(
                                                        87, 87, 87, 1))
                                            : '${AboutUsModels[0].content_sub3}'
                                                .poppins(
                                                    textAlign: TextAlign.center,
                                                    fontSize: 14 + 4 * pad,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.75,
                                                    color: Color.fromRGBO(
                                                        87, 87, 87, 1)),
                              ),
                            ),
                          const SizedBox(height: 80),
                          AspectRatio(
                              aspectRatio:
                                  // 45 / 35,
                                  Metrics.isMobile(context)
                                      ? 45 / 65
                                      : Metrics.isCompact(context)
                                          ? 45 / 65
                                          : Metrics.isTablet(context)
                                              ? 45 / 65
                                              : 45 / 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  // borderRadius: const BorderRadius.only(
                                  //   topLeft: Radius.circular(20),
                                  //   topRight: Radius.circular(20),
                                  //   bottomLeft: Radius.circular(20),
                                  //   bottomRight: Radius.circular(20),
                                  // ),
                                  color: white,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.withOpacity(0.25),
                                  //     offset: const Offset(0, 4),
                                  //     blurRadius: 4,
                                  //   ),
                                  // ],
                                  border: Border.all(
                                      color: Color.fromARGB(255, 192, 189, 189),
                                      width: 1),
                                  image: DecorationImage(
                                    // image: AssetImage(
                                    //   'assets/property_service/11.jpg',
                                    // ),
                                    image: NetworkImage(
                                      '${AboutUsModels[0].corver_img}',
                                      // 'https://s3-alpha-sig.figma.com/img/5707/6267/b40190e4b5dd591f1343ccfc4f040e38?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=SNXG~rvl~9f4Y7EbFn8oeKrtQZ75UGe~9KC-fu1JUxOvMW5JaSJ1S4tM-S7Uztz1ghGXw9OBjs5neImyN70j~mKAAkay0rxvfn0MsPJpw1bSkzjJ6p3lK29yStGitIVwNpznHjXg6jwX1Wl70GEX0Cfm9bpP1waz47fZJtgB896yc1Tii93Tv-uYigDigHq1foabPRtGob6lFTJmfwt0Soup3SaXj9VRMt0rMWhgxmu9tSsvk8Fufx4xk0JzqCAK9FqziH4q43weqOVPgJzOtz0z~1eFXqi091-CbadNzP3ZdZad4ujf9D-~XoOh5Ay3tAHT24QDxEST209MiECHWw__',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                        ]),
                  )),
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
