import 'package:flutter/material.dart';
import 'package:properties/core/core.dart';

import '../../../core/utils/metrics.dart';
import '../../widgets/base_container.dart';
import '../about_us/image_clider_controller.dart';
import '../brands.dart';
import '../review/review.dart';
import '../review/review_asset.dart';

class Asset_Management extends StatefulWidget {
  const Asset_Management({super.key});

  @override
  State<Asset_Management> createState() => _Asset_ManagementState();
}

class _Asset_ManagementState extends State<Asset_Management> {
  int limit = 2; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
///////----------------------------------------------->
  late PageController _controller;
  int currentPage = 1;
///////----------------------------------------------->
  List<String> images = [
    'https://images.unsplash.com/photo-1579656592043-a20e25a4aa4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1618220179428-22790b461013?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=654&q=80',
    'https://images.unsplash.com/photo-1551298370-9d3d53740c72?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1540932239986-30128078f3c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1540638349517-3abd5afc5847?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  ];
  List<String> title = [
    'Decorations &\n Renovations',
    'Photography &\n Listing',
    'Guest \n Communications',
    'Cleaning &\n Maintenance',
  ];
///////----------------------------------------------->
  @override
  void initState() {
    _controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.25,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

///////----------------------------------------------->
  @override
  Widget build(BuildContext context) {
    ///////----------------->
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
    ///////-------------------------------------->
    return BaseContainer(
        child: Column(
      children: [
        for (int index = 0; index < 2; index++)
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30 * pad),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Container(
                    width: 130,
                    // height: 30,
                    margin: EdgeInsets.only(right: (72 * pad) + (120 * pad1), left: 120 * pad1),
                    padding: const EdgeInsets.all(10),
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
                  width: Metrics.width(context),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: white,
                    // border: Border.all(
                    //     color: const Color.fromARGB(255, 163, 161, 161), width: 1),
                    // gradient: LinearGradient(
                    //   colors: [
                    //     BG_AboutUs.withOpacity(0.9),
                    //     BG_AboutUs.withOpacity(0.8),
                    //     BG_AboutUs.withOpacity(0.7),
                    //     BG_AboutUs.withOpacity(0.6),
                    //   ],
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    // ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 130,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    color: Colors.grey,
                                    border: Border.all(color: const Color.fromARGB(255, 163, 161, 161), width: 1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      '35%'.poppins(
                                        color: brown,
                                        fontSize: 14 + 4 * pad,
                                      ),
                                      'Commission Fee '.poppins(
                                        color: brown,
                                        fontSize: 14 + 4 * pad,
                                      ),
                                      '+ Renovation Fee*'.poppins(
                                        color: brown,
                                        fontSize: 14 + 4 * pad,
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                                crossAxisAlignment:
                                    Metrics.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 80),
                                  Align(
                                    alignment: Alignment.center,
                                    child: 'Inclusive Services'.poppins(
                                      color: brown,
                                      fontSize: 25 + 4 * pad,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child:
                                          'With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don\'t worry about contacting us. Because we always have good suggestions..'
                                              .poppinscenter(
                                        color: greenBg,
                                        fontWeight: FontWeight.bold,
                                        height: 1.5,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 48),
                                ]),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Metrics.isMobile(context)
                                ? 1
                                : Metrics.isCompact(context)
                                    ? 2
                                    : Metrics.isTablet(context)
                                        ? 3
                                        : 4,
                            childAspectRatio: 285 / 185,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 0,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            final gridItem = decorativeItems[index];

                            return Center(
                              child: InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => AssetAll(),
                                  //   ),
                                  // );
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => Rent(),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 12 + 12 * pad),
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.25),
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Stack(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 265 / 150,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: Image.network(
                                                gridItem.imgPath,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 10,
                                            left: 20,
                                            child: Container(
                                              // width: 150,
                                              // height: 70,
                                              decoration: BoxDecoration(
                                                color: white,
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                  bottomLeft: Radius.circular(15),
                                                  bottomRight: Radius.circular(15),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.25),
                                                    offset: const Offset(0, 4),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                              padding: const EdgeInsets.all(4),
                                              child: Center(
                                                child: ' Guest favourite'.poppins(
                                                  color: greenBg,
                                                  fontSize: 15 + 4 * pad,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 34),
        Align(
          alignment: Alignment.centerLeft,
          child: 'Or simply choose our one-off services:'.poppins(
            color: greenBg,
            fontSize: 25 + 4 * pad,
          ),
        ),
        const SizedBox(height: 20),

        ///------->
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
                child: Stack(children: [
                  AnimatedScale(
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
                  Positioned(
                    bottom: 100,
                    child: '$img'.poppins(
                      color: white,
                      fontSize: 20 + 4 * pad,
                    ),
                  )
                ]),
              );
            },
          ),
        ),
        const SizedBox(height: 34),
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
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 45 / 10,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/property_service/06.jpg',
                    fit: BoxFit.cover,
                  )
                  // Image.network(
                  //   decorativeItems[0].imgPath,
                  //   fit: BoxFit.cover,
                  // ),
                  ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              child: 'Renovation Service.'.poppinscenter(
                color: white,
                fontWeight: FontWeight.bold,
                fontSize: 25 + 4 * pad,
                height: 1.5,
                letterSpacing: 1,
              ),
            )
          ],
        ),
        const SizedBox(height: 64),
        'Property Owner Reviews: Why let us look after your property?'.poppins(
          color: brown,
          fontSize: 25 + 4 * pad,
        ),
        const SizedBox(height: 34),
        ReviewAsset(), const SizedBox(height: 64),
        'Have a vacant property? Why not list with us!'.poppins(
          color: brown,
          fontSize: 25 + 4 * pad,
        ),
        'Please kindly leave your email or phone number and we will get back to you as soon as possible!'.poppins(
          color: brown,
          fontSize: 16 + 4 * pad,
        ),
        const SizedBox(height: 34),
        Stack(
          children: [
            AspectRatio(
                aspectRatio: 45 / 10,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/property_service/06.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // width: 200,
                        height: 40,
                        // color: white,
                        padding: EdgeInsets.only(left: 260.0 * pad, right: 260.0 * pad),
                        child: Container(
                          color: white,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              // icon: Icon(Icons.person),
                              hintText: 'What do people call you?',
                              // labelText: 'Name *',
                            ),
                            onSaved: (String? value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                            },
                            validator: (String? value) {
                              return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 34),
                      Container(
                          width: 200,
                          height: 40,
                          color: white,
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: 'submit contact information'.poppins(
                              color: brown,
                              fontSize: 16 + 4 * pad,
                            ),
                          )),
                    ],
                  ),
                )
                // ClipRRect(
                //     borderRadius: BorderRadius.circular(20),
                //     child: Image.asset(
                //       'assets/property_service/06.jpg',
                //       fit: BoxFit.cover,
                //     )
                //     // Image.network(
                //     //   decorativeItems[0].imgPath,
                //     //   fit: BoxFit.cover,
                //     // ),
                //     ),
                ),
            // Positioned(
            //   left: 20,
            //   bottom: 20,
            //   child: 'Renovation Service.'.poppinscenter(
            //     color: white,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 25 + 4 * pad,
            //     height: 1.5,
            //     letterSpacing: 1,
            //   ),
            // )
          ],
        ),
        const SizedBox(height: 64),
      ],
    ));
  }
}
