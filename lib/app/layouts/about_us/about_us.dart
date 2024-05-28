import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:properties/Constant/Myconstant.dart';
import 'package:properties/core/core.dart';
import 'package:properties/core/models/management_typemodel.dart';
import 'package:properties/core/models/partner_model.dart';
import 'package:properties/core/models/review_model.dart';
import 'package:http/http.dart' as http;
import 'package:properties/core/utils/utils.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/methods.dart';
import '../../../core/utils/metrics.dart';
import 'about_us_image_slider.dart';
import 'about_us_info.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
///////----------------------------------------------->
  List<reviewmodel> reviewmodels = [];
  List<PartnerModel> partnerModels = [];
  List<Management_TypeModel> managementTypeModels = [];
///////----------------------------------------------->
  @override
  void initState() {
    // _baseController = ScrollController();
    // _baseController.addListener(() {
    //   if (_baseController.offset > 500) {
    //     ref.read(scrollProvider.notifier).change(true);
    //   } else {
    //     ref.read(scrollProvider.notifier).change(false);
    //   }
    // });
    read_GC_reviewmodels();
    read_GC_ManagementType();
    read_GC_Partner();
    super.initState();
  }

  @override
  void dispose() {
    // _baseController.dispose();
    super.dispose();
  }

///////----------------------------------------------->
  Future<Null> read_GC_reviewmodels() async {
    if (reviewmodels.length != 0) {
      reviewmodels.clear();
    }

    String url = '${MyConstant().domain}/GC_ReviewAll.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        reviewmodel reviewmodelss = reviewmodel.fromJson(map);

        setState(() {
          reviewmodels.add(reviewmodelss);
        });
      }

      // print(reviewmodels);
      // read_isHover();
      // Map assetlist = {};
    } catch (e) {}
  }

  ///////----------------------------------------------->  List<Management_TypeModel> managementTypeModels = [];
  Future<Null> read_GC_ManagementType() async {
    if (managementTypeModels.length != 0) {
      managementTypeModels.clear();
    }

    String url = '${MyConstant().domain}/GC_Management_Type.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        Management_TypeModel managementTypeModelss = Management_TypeModel.fromJson(map);
        setState(() {
          managementTypeModels.add(managementTypeModelss);
        });
      }
    } catch (e) {}
  }

  ///////----------------------------------------------->    List<PartnerModel> partnerModels = [];
  Future<Null> read_GC_Partner() async {
    if (partnerModels.length != 0) {
      partnerModels.clear();
    }

    String url = '${MyConstant().domain}/GC_Partner.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        PartnerModel partnerModelss = PartnerModel.fromJson(map);
        setState(() {
          partnerModels.add(partnerModelss);
        });
      }
    } catch (e) {}
  }

///////----------------------------------------------->

  @override
  Widget build(BuildContext context) {
    List<String> content_text = [
      'Decorations &\n Renovations',
      'Photography &\n Listing',
      'Guest \n Communications',
      'Cleaning &\n Maintenance',
    ];
    const List<String> content_image = [
      'https://s3-alpha-sig.figma.com/img/f477/4294/2841c937d8b24966c3412826595763f2?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oawp-dyDFaADsZLx9dKvWaB3MjbTbuWdTKH2GnWFrl~VxDFKborw3zV96wjilbmdJPnx4~R4wO9ya5dL~f2G5n0DZKdIZvpt9GV2IAWJxVq4CgfFHsrekkQrVTeWoc6TvlKtvr2qkzyZQ2t-9AhEpXUypNSsbfXUXIB73WzrOzICaSEJ8hsug4Nx71xHbEaZZS1guLHv~qlFNi19LloRIHSBUaavkz3TGILRpCDoUflZZCL40uR60p4db12EsnAQngDZmPm6bvTyc5h5cndza0SjwShbOC6sEgt2G0N~eLTLU7wEp6oOG-lZVnwxUj7T2mJu5A0CpQckgPOHuV0~Rg__',
      'https://s3-alpha-sig.figma.com/img/7bda/143f/e5a98a6fe7b614f448514de91a6f75c2?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=S6m2PtH5ICHxiyhq6pYhNbxQUHVUWnkaHH0K3hYoUs3Jr4AJVxs4fFZZLQd4ZyO056wVNR0aXUWqpXcHCMxLvnurLZN3cVnMv-Ud7V~oL5X7R6QSzFlXl7URGE9meZf7M89NTfFUKowtjXxoFv0NH23bEPdKFMnK7eo5xtnPwnM5~SS0ftoG3JAb4FV~21WS9N7X7ZK7NjEFuY5MpsOUU2LNRAWc4uwUy4R0lShaGqqsOkIDe23lmls34dvmhBXbPg-dWraPzCdrPAMsVh6vV7QFnRYbYjmx57i06kF7IeORq9HD6GsocO96b3RGtEGn0a3jW0w790g1q8pSHPYLCg__',
      'https://s3-alpha-sig.figma.com/img/5e7a/95c4/8a9dd8afc379f258b23cc4fc928b75c0?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=X9g~6TCf1mu4~dyXOMaQJfF3ic8ce6ezQCRRN6~w2Q-EdaJ0gqrEpVuWkJu86k9XysWA61ZuinqApq7AiU~HwZSy6Pcp5A7aUnjUbvS0Y1dhtGx7DZ1R9Te~K4CeJkHGBG0UNl1U30JiiLXyzxHovQSdnbmsLX6vClU-kgyOVruEgHm1Sgz6XfzPN3uMfeH~Nxt92TCOpg99D6ZRxhXPrDodntQDPpWZ5vneCKMf1re2p1nY24wWwEkYhF2g4-kk8c3QN9FKwCuJ-jIt-Q9JPQECEb45Uytr1Au1NaHnH-cXvKg6DPnFZJoSR~HG7-mzkuDkqmktOkaWYV7-zhUj3w__',
      'https://s3-alpha-sig.figma.com/img/248c/9403/08be956057a64cc8e78ca17e8bb7dd0d?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Jrj48c60uvOZQFA1wZZtAMlI41-m6yCRMcHgsdlQlAAglcJO3V3nwAVuMv3iFrstUns~xabHhdnbrB2sf1En7Gk4vvTQfrIamU-gy8MVcrbt3djVwb1DTWNDyBs~MyNFOlOkWg5SKMKAu-XAl6f3~KCbkzExhcFDz3xUh8CTmQ3rcaj-nLm4EHBeE8OAHPFTVKyiQtKv-rfaHbEkrRM2LjllXR0cEoFhzatk0qo3Zc91y1hzKuLKeVBHPgACQQK3cdFi00l9FNHK57Mm0o-N1jhAWfT4hynF~GXu3QtNW7tRffh7aU5cB8-kJtDRfb4yp5HeazlJrEiXJcJ2IDjBXA__',
    ];
    const List<String> gride_image = [
      'https://s3-alpha-sig.figma.com/img/161e/2805/c7c2b0e9a9be2a940d3f21168989670a?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ObKfW1dZVgfTi8IDMeNgtSJUNBfvZi~a7cWimdPvu7I2zruwRVpN5~06f8mZacAF234ITFACw2I6yA2UbrNgqbhE6UlW0o63Azjo2QdMuobpWO60FhQPOiDUWJ8jOJqi7PXxSZ1KJvAtmAQgU5AqVQs2l4~p-PvzG~k-RRCTBZCgv8SpPROU2X3r83LQvu0xhH8IJZjcAEQkXC0~3yo62LIf6xVOdywztaYzXpyPp6kYzQBXSLlh~~NrK6OphcwyXY1NfpF-DrDrZ95Gzh8HLhU0IE5sZTkHcRADx7CGyIo7H~wfsbtSbdFCXoIGQJ3dadM0fQ5qt1tv~CU1OF07dw__',
      'https://s3-alpha-sig.figma.com/img/f1a2/7a0d/d3e9a39b44ae0a1b499dc2870e7c747e?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=orIh1oN9WZlmJcx4FYqXJJss2kyqTC9YcjehtN8zfanXCULhOmv4cA9YRy3fJNeM32JaTSg6FTMt5KGi3po134GEZ2j~tHhc2uAUIsZaeYrrdkJnuOGzjbd~Cq4GBKEvhu0IR3CKVbxjBuXfcJfqRPnVZunyLbCb0zaLrMNZehaej70mhI-jQyDV6Hf30w1A8KzfvcT9zGkbvwUOJoEdZ-~-jhs0awVj37035~dfFSmgrR2lpzZ364DDgzobaZ2WsHlUBLdTVbFhTYv2y-RuU7UEiVGz3R1MMNNht~dVoC9LSKLpD23B3G1IiEU0Ku7HzkqKqJN-SNoKccr0evjN-w__',
      'https://s3-alpha-sig.figma.com/img/930f/c4ab/8298c476479abc674bfc55b50497420d?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=JjlKUrclGr1Pw3TrY19r-8k6IBLjx-E18yMm7vVxviIU5B1DKCGqx-TU59mZvF5gYBJpm510QmH3ua9CA0xnxJ2OVvFz83Z5Vo-DcHHuTQtRShTWohp-8Uwh5LN6vB1CKc558QjgF9z9bCObhTi4bdaoK9rHWmxuIsMQIHuvlIxvbCkxH~~I95rbe~jKuw1ZhfrGF7AtoeHq~v8sjtMrBe17k-IMyJW7WYilXQOdEDmo~POIRP5zWP5H076m7aWKzzUV2L5ctRxcy7DU3ZCfKX3dvNXlk34vbokohfBXWrFban7B7Bw7ghYlttqaJoQ29i2acALGHbZIwqI0TzrCKA__',
      'https://s3-alpha-sig.figma.com/img/f36b/97fc/9b3038de3373e54f8d0850284b67b231?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=cyWnhOxl5EzfiLcjgx9pFldgTLiKz3JEYoZ1Xp1M9n3KEqJaJcoQb2ItEQhnWK2OhxdLsGBcu-fDGcoE6oHwJFrOpTV-r9zZ8tLF-hoZC-6pJ46tasHHu1C7n7goJjn0AzTVobuPp5dquTXaVI7FYa3PJg4DqbwR8FzViQCCH770mqXfE2zl6hJ~3YEv8nOax7K4txnpqsxWTwmuWChRq3cAmhth2I3JmXYe0Ww1g-cT8WgtIsdPPlKmoH0aVbw2-gG-yu24JedmDjvnt7ceZQZQTfT0UIPyKCSueuyNpYjfdElDIhwye-wEweIzIyagbfRT43kJ-26myQ945f06Ag__',
      'https://s3-alpha-sig.figma.com/img/20c1/262f/bc6e90613ac3c788e067ab3367ae29df?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=mC8FV9sWD~HjH8AnASCfzH2ZanbEPeFRZjH-oVk~kLfMZaQNXFV4QSxCEfDgugnIakHMxCuyeIlwcMWlm-bM1vL2F2w4QXFveVhA6hG9W8v4H6CMxi1kcGoXwlBV1Y~rKmK5D1wTfdgEnq6cyxG377yTA~l-bqID17qQYRfW~TBYpya9YnMk05H-QI-vYAj7wJjaz1HxvwwdNRM8pQmwcNLdWXiXld1SPDNlaazdsa-BxRrwpatFkjRqYt2Piq8qkMuUQgG~3e6wAzg7WNSHqmruomWiZLdYsr6o8XFjwbmBKJ8MaMGvHEEKkQHUAsNtFSCt3XSJi2HV0KVLekCSVg__',
      'https://s3-alpha-sig.figma.com/img/f43d/240b/0d741c405d0f9456169c5d91c5f0a5b5?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Qz3d~tXNFyXhFhw8bGMcji4W1YPH0Zmvah4tx5aYHuWMGEqgY4f3FjqC3SqlTNAvlL8Q4~wz0YhEFc86OBlKJ-0vcNInHLnMbhMLvk3ajDRNy5Rh0EiEMmi-Cz87tFMuQaimiMFuB~DbfNqTula2QrkZyV94W8wD5R2kmuMlhW2lDeVRGvUgpEU3UcSGJ8fWY2z-GEwCPRBi5mKgSYzMpn6jjIdVvSiD5EpQnUaWTE5UDIC8kx~Z4IeJdd2x3Zd2gwo0G-wt0NfJxHBa5iKHK21giBpS1UxVgkv9oGLv-R69Jg1r3YWhwVh7MEDbP5KnbMqzxggBDks4l7NTjR-G5g__',
      'https://s3-alpha-sig.figma.com/img/e57f/8b4e/537c135f5f070d18747ccdbe436413ee?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=NZGteynWBfADnwJx2naD-nKB7ZwU1SiwwvAb79FqlA5WNBQia8RVYAtDnK3hJmdY8K0TDf0oOxgEFIKgiIic6PD6qZpTSASsC7x~6PFnUq5vBtLppYrFi67mVSVIEbVFcd9WXnp-YoZL8s~cIcRwrg1xh1~uW1WVxb8jCRggehZogRKRG6nhjLTwUz7Uq9BvQkiDg5eW6289iyQKGmwROlTaS5G0KMf7wouOx79XXJyO7YSJKOPkqra1cWsn6-ONyIvYVcHIiKTgqGT6zg2Mzi9JcfPJSYv2fM1FdjQFXKbxUrooTOUL0qtJPTsA-xYRIlZffyAzC3SULQQL-DUMcg__',
      'https://s3-alpha-sig.figma.com/img/f43d/240b/0d741c405d0f9456169c5d91c5f0a5b5?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Qz3d~tXNFyXhFhw8bGMcji4W1YPH0Zmvah4tx5aYHuWMGEqgY4f3FjqC3SqlTNAvlL8Q4~wz0YhEFc86OBlKJ-0vcNInHLnMbhMLvk3ajDRNy5Rh0EiEMmi-Cz87tFMuQaimiMFuB~DbfNqTula2QrkZyV94W8wD5R2kmuMlhW2lDeVRGvUgpEU3UcSGJ8fWY2z-GEwCPRBi5mKgSYzMpn6jjIdVvSiD5EpQnUaWTE5UDIC8kx~Z4IeJdd2x3Zd2gwo0G-wt0NfJxHBa5iKHK21giBpS1UxVgkv9oGLv-R69Jg1r3YWhwVh7MEDbP5KnbMqzxggBDks4l7NTjR-G5g__',
    ];

    const List<List> review = [
      ['Ms. Sophie K. ', 'reat service! amazing helpouts would definitely recommend all to try booking monthly here. '],
      [
        'Mr. Hendrik S. ',
        'Everything!! Excellent location, just 10 min drive from a great local market with bars and restaurants. Amazing beach, great staff, very clean.'
      ],
      ['Ms. Sophie K. ', 'reat service! amazing helpouts would definitely recommend all to try booking monthly here. '],
      [
        'Mr. Hendrik S. ',
        'Everything!! Excellent location, just 10 min drive from a great local market with bars and restaurants. Amazing beach, great staff, very clean.'
      ],
    ];
    final pad = normalize(min: 976, max: 1440, data: Metrics.width(context));
    final isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);
    final gride_review = review.length / 2;
    return Container(
      width: Metrics.width(context),
      // color: BG_AboutUs,
      child: Column(
        children: [
          const SizedBox(height: 20),

          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: 'Our full management service includes:'
                .poppins(color: white, fontSize: 25 + 4 * pad, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 20),
          // AboutUsInfo(pad: pad),
          // const AboutUsImageSlider(),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(
              children: [
                isBigScreen == Metrics.isTablet(context)
                    ? const AboutUsImageSlider()
                    : Row(
                        children: [
                          for (var index = 0; index < 4; index++)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: AspectRatio(
                                  aspectRatio: 9 / 16,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        // colorFilter: ColorFilter.mode(Colors.white38, BlendMode.softLight),
                                        image: NetworkImage(content_image[index]),
                                        fit: BoxFit.cover,
                                        alignment: index == 1 ? Alignment.centerLeft : Alignment.center,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          content_text[index],
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600,
                                                color: white,
                                                shadows: [
                                                  Shadow(blurRadius: 2, color: Colors.black38, offset: Offset(2, 2))
                                                ]),
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    "With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don't worry about contacting us. Because we always have good suggestions.",
                    style: GoogleFonts.poppins(
                        color: white, fontSize: Metrics.isMobile(context) ? 12 : 20, fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Portfolio',
                          style: GoogleFonts.poppins(
                            color: white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        // height: 1440,
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Metrics.isMobile(context)
                                ? 1
                                : Metrics.isCompact(context)
                                    ? 2
                                    : Metrics.isTablet(context)
                                        ? 2
                                        : 4,
                            crossAxisSpacing: 45.0, // Spacing between columns
                            mainAxisSpacing: 45.0, // Spacing between rows
                            childAspectRatio: 9 / (8),
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: managementTypeModels.length, // Number of items in the grid
                          itemBuilder: (BuildContext context, int index) {
                            // final img = index1 == 1 ? gride_image[index + 4] : gride_image[index];
                            final img = '${MyConstant().domain}/img/${managementTypeModels[index].corver_img}';
                            return ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                image: NetworkImage(img),
                                fit: BoxFit.cover,
                                // height: 300,
                              ),
                            );
                            // return Container(
                            //     clipBehavior: Clip.antiAlias,
                            //     padding: const EdgeInsets.all(16),
                            //     alignment: Alignment.bottomLeft,
                            //     decoration: BoxDecoration(
                            //         image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
                            //         borderRadius: BorderRadius.circular(16)),
                            //     child: Text(
                            //       '${managementTypeModels[index].name}',
                            //       style: TextStyle(color: white, fontSize: 25, fontWeight: FontWeight.bold),
                            //     ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                // Container(
                //   child: Column(
                //     children: [
                //       Text('Property Owner Reviews: Why let us look after your property?'),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: SizedBox(
                //           height: 720,
                //           child: GridView.builder(
                //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 2, // Number of columns
                //               crossAxisSpacing: 45.0, // Spacing between columns
                //               mainAxisSpacing: 45.0, // Spacing between rows
                //               childAspectRatio: 2 / (1),
                //             ),
                //             itemCount: 4, // Number of items in the grid
                //             itemBuilder: (BuildContext context, int index) {
                //               return Stack(
                //                 children: [
                //                   Container(
                //                     height: 100,
                //                     color: white,
                //                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                //                     child: Column(
                //                       children: [
                //                         Text("Ms. Sophie K."),
                //                         Text(
                //                             "Great service! amazing helpouts would definitely recommend all to try booking monthly here. "),
                //                       ],
                //                     ),
                //                   ),
                //                   Positioned(
                //                     // top: 10,
                //                     left: -50,

                //                     child: Container(
                //                       width: 100,
                //                       height: 100,
                //                       decoration: BoxDecoration(
                //                         color: Colors.grey,
                //                         borderRadius: BorderRadius.circular(50),
                //                       ),
                //                     ),
                //                   ),
                //                   Positioned(
                //                       top: 10,
                //                       right: 20,
                //                       child: IconButton(
                //                         onPressed: () {},
                //                         icon: Icon(
                //                           Icons.favorite_border,
                //                           color: white,
                //                         ),
                //                       ))
                //                 ],
                //               );
                //             },
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                Container(
                  width: Metrics.width(context),
                  height: 600 + 100 * pad,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(233, 233, 233, 1),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.5),
                    //     spreadRadius: 3,
                    //     blurRadius: 4,
                    //     offset: Offset(0, 4), // changes position of shadow
                    //   ),
                    // ],
                    // border: Border.all(
                    //     color: const Color.fromARGB(255, 163, 161, 161), width: 1),
                  ),
                  child: Column(
                    children: [
                      // const SizedBox(height: 64),
                      FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Column(children: [
                            const SizedBox(height: 20),
                            'Property Owner Reviews: Why let us look after your property?'.poppins(
                                color: Color.fromRGBO(60, 60, 60, 1),
                                fontSize: Metrics.isMobile(context) ? 12 : 25,
                                textAlign: TextAlign.center),
                            const SizedBox(height: 34),
                            Container(
                              height: 500,
                              width: double.infinity,
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(left: 20.0 * pad, right: 20.0 * pad),
                              // padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: GridView.builder(
                                  // scrollDirection: Axis.vertical,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: Metrics.isMobile(context)
                                        ? 1
                                        : Metrics.isCompact(context)
                                            ? 1
                                            : Metrics.isTablet(context)
                                                ? 2
                                                : 2,
                                    // crossAxisCount: gride_review.toInt(),
                                    // crossAxisCount: reviewmodels.length.toInt(),
                                    childAspectRatio: 3 / 1,
                                    crossAxisSpacing: 24,
                                    mainAxisSpacing: 10,
                                    // mainAxisExtent: 200.0
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: reviewmodels.length,
                                  itemBuilder: (context, index) {
                                    // final gridItem = decorativeItems[index];
                                    return Stack(
                                      alignment: Alignment.centerLeft,
                                      clipBehavior: Clip.none,
                                      // alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: Metrics.isMobile(context) ? 100 : 200,
                                          margin: EdgeInsets.only(left: Metrics.isMobile(context) ? 35 : 50),
                                          padding: EdgeInsets.only(
                                              left: Metrics.isMobile(context) ? 25 : 70,
                                              right: 16,
                                              top: 16,
                                              bottom: 16),
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(Metrics.isMobile(context) ? 10 : 20),
                                              topRight: Radius.circular(Metrics.isMobile(context) ? 10 : 20),
                                              bottomLeft: Radius.circular(Metrics.isMobile(context) ? 10 : 20),
                                              bottomRight: Radius.circular(Metrics.isMobile(context) ? 10 : 20),
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
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('${reviewmodels[index].name}',
                                                      style: GoogleFonts.poppins(
                                                        color: Color.fromRGBO(72, 72, 72, 1),
                                                        fontSize: 14 + 4 * pad,
                                                      ),
                                                      textAlign: TextAlign.start),
                                                  // if (Metrics.isTablet(context) || Metrics.isDesktop(context))
                                                  RatingBar.builder(
                                                    initialRating: double.parse('${reviewmodels[index].poit_score}'),
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 14,
                                                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                    unratedColor: Colors.grey.withOpacity(0.5),
                                                    wrapAlignment: WrapAlignment.start,
                                                    itemBuilder: (context, _) => const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      print(rating);
                                                    },
                                                  ),
                                                ],
                                              ),

                                              Text('${reviewmodels[index].description}',
                                                  style: GoogleFonts.poppins(
                                                    color: Color.fromRGBO(72, 72, 72, 1),
                                                    fontSize: 10 + 4 * pad,
                                                  ),
                                                  textAlign: TextAlign.start),
                                              // const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                        // AspectRatio(
                                        //   aspectRatio: 2 / 1,
                                        //   child: ClipRRect(
                                        //     borderRadius: BorderRadius.circular(20),
                                        //     child: Image.network(
                                        //       'https://images.unsplash.com/photo-1611967164521-abae8fba4668?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                                        //       fit: BoxFit.cover,
                                        //     ),
                                        //   ),
                                        // ),
                                        Positioned(
                                            // top: 25,
                                            width: Metrics.isMobile(context) ? 50 : 100,
                                            height: Metrics.isMobile(context) ? 50 : 100,
                                            // left: -12.5,
                                            child: CircleAvatar(
                                              backgroundColor: Color.fromRGBO(177, 170, 151, 1),
                                              radius: 50,
                                              child: Icon(
                                                Icons.home_rounded,
                                                color: white,
                                              ),
                                              // child: Image.asset(
                                              //   'Clock.png'.image, fit: BoxFit.cover,
                                              //   // width: 80,
                                              //   // height: 80,
                                              // ),
                                            )),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ])),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(157, 132, 45, 1), borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      'List with us',
                      style: TextStyle(color: white, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Our Partner',
                            style: GoogleFonts.poppins(
                                color: Color.fromRGBO(82, 82, 82, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: isBigScreen == Metrics.isTablet(context) ? 15 : 20),
                          ),
                          if (partnerModels.isNotEmpty)
                            for (int index = 0; index < partnerModels.length; index++)
                              Image.network(
                                '${MyConstant().domain}img/${partnerModels[index].corver_img}',
                                width: isBigScreen == Metrics.isTablet(context) ? 40 : 70,
                                height: isBigScreen == Metrics.isTablet(context) ? 40 : 70,
                              ),
                        ],
                      ),
                    ))
            ],
          ),
          const SizedBox(height: 40),
          if (Metrics.isMobile(context))
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Our Partner',
                    style: GoogleFonts.poppins(
                        color: Color.fromRGBO(82, 82, 82, 1),
                        fontWeight: FontWeight.w600,
                        fontSize: isBigScreen == Metrics.isTablet(context) ? 15 : 20),
                  ),
                  if (partnerModels.isNotEmpty)
                    for (int index = 0; index < partnerModels.length; index++)
                      Image.network(
                        '${MyConstant().domain}img/${partnerModels[index].corver_img}',
                        width: isBigScreen == Metrics.isTablet(context) ? 40 : 70,
                        height: isBigScreen == Metrics.isTablet(context) ? 40 : 70,
                      ),
                ],
              ),
            ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
