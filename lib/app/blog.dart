import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:properties/app/widgets/base_container.dart';
import 'package:properties/app/with_us.dart';
import 'package:properties/core/core.dart';
import 'package:http/http.dart' as http;
import 'package:properties/core/models/img_blogs_model.dart';
import '../Constant/Myconstant.dart';
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
  List<BlogModel> blogmodels = [];
  List<ImgBlogs_model> imgBlogs_models = [];
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
    read_GC_BlogsAll();
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

///////----------------------------------------------->
  Future<Null> read_GC_BlogsAll() async {
    if (limitedList_blogmodels.length != 0) {
      limitedList_blogmodels.clear();
    }

    String url = '${MyConstant().domain}/GC_BlogsAll.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        BlogModel blogmodelss = BlogModel.fromJson(map);

        setState(() {
          limitedList_blogmodels.add(blogmodelss);
        });
      }
      read_links_limit();
    } catch (e) {}
  }

  Future<void> read_isHover() async {
    setState(() {
      isHover = List.generate(
        blogmodels.length,
        (index) => false,
      );
    });
  }

  // var num = 0;
  ///////----------------------------------------------->
  Future<Null> read_GC_BlogsImg(index) async {
    var ser_blogs = limitedList_blogmodels[index].ser.toString();
    if (imgBlogs_models.length != 0) {
      imgBlogs_models.clear();
    }

    String url = '${MyConstant().domain}/GC_Blogs_Img.php?isAdd=true&serblogs=$ser_blogs';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        ImgBlogs_model imgBlogs_modelss = ImgBlogs_model.fromJson(map);

        setState(() {
          imgBlogs_models.add(imgBlogs_modelss);
        });
      }
    } catch (e) {}
  }

///////----------------------------------------------->
  Future<Null> read_links_limit() async {
    setState(() {
      endIndex = offset + limit;
      blogmodels = limitedList_blogmodels.sublist(
          offset, // Start index
          (endIndex <= limitedList_blogmodels.length) ? endIndex : limitedList_blogmodels.length // End index
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
                                        onTap: () async {
                                          // List imgBlog = [];
                                          read_GC_BlogsImg(index).then(
                                            (value) {
                                              // print('${imgBlogs_models.length}--${index}');

                                              // imgBlog = imgBlogs_models;
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  // Return an AlertDialog

                                                  // print('${imgBlogs_models.length}--${index}');

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
                                                                      bottom:
                                                                          BorderSide(width: 1, color: Colors.grey))),
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      children: [
                                                                        '${blogmodels[index].name}'.poppinsBlog(
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: Color.fromRGBO(71, 69, 69, 1)),
                                                                        '${blogmodels[index].name_th}'.poppinsBlog(
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: Color.fromRGBO(71, 69, 69, 1)),
                                                                      ],
                                                                    ),
                                                                  ),
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
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child: AspectRatio(
                                                                              aspectRatio: 4 / 3,
                                                                              child: Image.network(
                                                                                blogmodels[index].corver_img.toString(),
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          for (int index1 = 0;
                                                                              index1 < imgBlogs_models.length;
                                                                              index1++)
                                                                            Expanded(
                                                                              child: AspectRatio(
                                                                                aspectRatio: 4 / 3,
                                                                                child: Image.network(
                                                                                  imgBlogs_models[index1].img.toString(),
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                      // Padding(
                                                                      //   padding: const EdgeInsets.all(8.0),
                                                                      //   child: Row(
                                                                      //     children: [
                                                                      //       Padding(
                                                                      //         padding: const EdgeInsets.symmetric(
                                                                      //             vertical: 16.0),
                                                                      //         child: 'FRUIT'.toUpperCase().poppins(
                                                                      //             fontSize: 12,
                                                                      //             fontWeight: FontWeight.w400,
                                                                      //             color: Color.fromRGBO(64, 178, 201, 1)),
                                                                      //       ),
                                                                      //       ' - 5 mins read'.poppins(
                                                                      //           fontSize: 12, fontWeight: FontWeight.w400)
                                                                      //     ],
                                                                      //   ),
                                                                      // ),
                                                                      Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height: 20,
                                                                          ),
                                                                          '${blogmodels[index].content}'.poppins(
                                                                              color: Color.fromRGBO(87, 87, 87, 1),
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400,
                                                                              textAlign: TextAlign.justify),
                                                                          const SizedBox(
                                                                            height: 20,
                                                                          ),
                                                                          '${blogmodels[index].content_sub1}'.poppins(
                                                                              color: Color.fromRGBO(87, 87, 87, 1),
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400,
                                                                              textAlign: TextAlign.justify),
                                                                          const SizedBox(
                                                                            height: 20,
                                                                          ),
                                                                          '${blogmodels[index].content_sub2}'.poppins(
                                                                              color: Color.fromRGBO(87, 87, 87, 1),
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400,
                                                                              textAlign: TextAlign.justify),
                                                                          const SizedBox(
                                                                            height: 20,
                                                                          ),
                                                                          '${blogmodels[index].content_sub3}'.poppins(
                                                                              color: Color.fromRGBO(87, 87, 87, 1),
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w400,
                                                                              textAlign: TextAlign.justify),
                                                                          const SizedBox(
                                                                            height: 20,
                                                                          ),
                                                                        ],
                                                                      ),
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
                                                    blogmodels[index].corver_img.toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      // Row(
                                                      //   children: [
                                                      //     Padding(
                                                      //       padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                      //       child: 'FRUIT'.toUpperCase().poppins(
                                                      //           fontSize: 12,
                                                      //           fontWeight: FontWeight.w400,
                                                      //           color: Color.fromRGBO(64, 178, 201, 1)),
                                                      //     ),
                                                      //     ' - 5 mins read'
                                                      //         .poppins(fontSize: 12, fontWeight: FontWeight.w400)
                                                      //   ],
                                                      // ),
                                                      // Padding(
                                                      //   padding: const EdgeInsets.all(4),
                                                      //   child:
                                                      //       '[${blogmodels[index].id}] ${blogmodels[index].title}'
                                                      //           .poppins(
                                                      //     fontWeight: FontWeight.bold,
                                                      //     fontSize: 16,
                                                      //   ),
                                                      // ),
                                                      '${blogmodels[index].name}'.poppinsBlog(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: '${blogmodels[index].name_th}'.poppinsBlog(
                                                          fontSize: 12,
                                                        ),
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

// class Show extends StatelessWidget {
//   const Show({super.key, required this.index, required this.blogmodels, required this.imgBlogs_models});
//   final int index;
//   final List blogmodels;
//   final List imgBlogs_models;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog.fullscreen(
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Container(
//           // width: double.infinity,
//           // height: double.infinity,
//           // decoration: BoxDecoration(
//           //   color: white,
//           //   borderRadius: BorderRadius.zero,
//           // ),
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           '${blogmodels[index].name}'.poppinsBlog(
//                               fontSize: 14, fontWeight: FontWeight.w600, color: Color.fromRGBO(71, 69, 69, 1)),
//                           '${blogmodels[index].name_th}'.poppinsBlog(
//                               fontSize: 14, fontWeight: FontWeight.w600, color: Color.fromRGBO(71, 69, 69, 1)),
//                         ],
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(color: black, borderRadius: BorderRadius.circular(4)),
//                         child: 'Close'.poppins(
//                           color: white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Center(
//                   child: FractionallySizedBox(
//                     widthFactor: 0.7,
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: AspectRatio(
//                                 aspectRatio: 4 / 3,
//                                 child: Image.network(
//                                   blogmodels[index].corver_img.toString(),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Row(
//                                 children: [
//                                   for (int index1 = 0; index1 < imgBlogs_models.length; index1++)
//                                     AspectRatio(
//                                       aspectRatio: 4 / 3,
//                                       child: Image.network(
//                                         imgBlogs_models[index1].img.toString(),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         // Padding(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: Row(
//                         //     children: [
//                         //       Padding(
//                         //         padding: const EdgeInsets.symmetric(
//                         //             vertical: 16.0),
//                         //         child: 'FRUIT'.toUpperCase().poppins(
//                         //             fontSize: 12,
//                         //             fontWeight: FontWeight.w400,
//                         //             color: Color.fromRGBO(64, 178, 201, 1)),
//                         //       ),
//                         //       ' - 5 mins read'.poppins(
//                         //           fontSize: 12, fontWeight: FontWeight.w400)
//                         //     ],
//                         //   ),
//                         // ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 20,
//                             ),
//                             '${blogmodels[index].content}'.poppins(
//                                 color: Color.fromRGBO(87, 87, 87, 1),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 textAlign: TextAlign.justify),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             '${blogmodels[index].content_sub1}'.poppins(
//                                 color: Color.fromRGBO(87, 87, 87, 1),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 textAlign: TextAlign.justify),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             '${blogmodels[index].content_sub2}'.poppins(
//                                 color: Color.fromRGBO(87, 87, 87, 1),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 textAlign: TextAlign.justify),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             '${blogmodels[index].content_sub3}'.poppins(
//                                 color: Color.fromRGBO(87, 87, 87, 1),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 textAlign: TextAlign.justify),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 60,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
