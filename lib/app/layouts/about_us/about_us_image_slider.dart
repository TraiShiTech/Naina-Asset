import 'package:flutter/material.dart';
import 'package:properties/core/core.dart';

import '../../../core/utils/methods.dart';
import '../../../core/utils/metrics.dart';
import '../brands.dart';
import '../review/review.dart';
import 'image_clider_controller.dart';

class AboutUsImageSlider extends StatefulWidget {
  const AboutUsImageSlider({Key? key}) : super(key: key);

  @override
  State<AboutUsImageSlider> createState() => _AboutUsImageSliderState();
}

class _AboutUsImageSliderState extends State<AboutUsImageSlider> {
  List<String> images = [
    'https://images.unsplash.com/photo-1579656592043-a20e25a4aa4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1618220179428-22790b461013?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=654&q=80',
    'https://images.unsplash.com/photo-1551298370-9d3d53740c72?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1540932239986-30128078f3c5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1540638349517-3abd5afc5847?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1599696848652-f0ff23bc911f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
  ];
  late PageController _controller;
  int currentPage = 0;

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

  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 976, max: 1440, data: Metrics.width(context));
    double plus = Metrics.isDesktop(context)
        ? 0
        : (0.5 *
            (1 - normalize(min: 976, max: 1440, data: Metrics.width(context))));
    _controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.25 + plus,
    );
    return Column(
      children: [
        SizedBox(
          height: 600 + 100 * pad,
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
        Padding(
          padding: EdgeInsets.only(left: 260.0 * pad, right: 260.0 * pad),
          child:
              'With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don\'t worry about contacting us. Because we always have good suggestions.'
                  .poppins(
            textAlign: TextAlign.center,
            fontSize: 14 + 4 * pad,
            fontWeight: FontWeight.w500,
            height: 1.75,
          ),
        ),
        const SizedBox(height: 64),
        'Portfolio'.poppins(
          color: white,
          fontSize: 25 + 4 * pad,
        ),
        const SizedBox(height: 34),
        Padding(
          padding: EdgeInsets.only(left: 260.0 * pad, right: 260.0 * pad),
          // padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Metrics.isMobile(context)
                  ? 1
                  : Metrics.isCompact(context)
                      ? 2
                      : Metrics.isTablet(context)
                          ? 3
                          : 4,
              childAspectRatio: 285 / 230,
              crossAxisSpacing: 24,
              mainAxisSpacing: 0,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 8,
            itemBuilder: (context, index) {
              final gridItem = decorativeItems[index];

              return Container(
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
                child: AspectRatio(
                  aspectRatio: 285 / 230,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      gridItem.imgPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 34),
        Review(),
        Brands()
      ],
    );
  }
}
