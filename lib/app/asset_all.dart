import 'dart:convert';
import 'dart:js';
// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:properties/Constant/Myconstant.dart';
import 'package:properties/app/layouts/header/header_asset_all.dart';
import 'package:properties/app/layouts/how_it_works/how_it_works.dart';
import 'package:properties/app/widgets/base_container.dart';
import 'package:properties/app/widgets/how_it_work_card_item.dart';
import 'package:properties/core/core.dart';
import 'package:properties/core/models/review_model.dart';
import 'package:http/http.dart' as http;
import 'package:properties/core/theme/app_colors.dart';
import 'package:properties/core/utils/metrics.dart';
import 'package:properties/core/utils/utils.dart';

import 'components/appbar/appbar.dart';
import 'layouts/asset_as/asset_management.dart';
import 'layouts/footer/footer.dart';

class AssetAll extends ConsumerStatefulWidget {
  const AssetAll({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AssetAllState();
}

class _AssetAllState extends ConsumerState<AssetAll> {
  int limit = 2; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
///////----------------------------------------------->
  late ScrollController _baseController;
  List<reviewmodel> reviewmodels = [];
  final GlobalKey _headerKey = GlobalKey();

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
    read_GC_reviewmodels();
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

///////----------------------------------------------->
  List<String> gride_image = [
    'https://s3-alpha-sig.figma.com/img/9879/be65/cb78d9f230682212edb7f9f15137b65b?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jMU29Pk~LhuZ5hxRlQpNF3UNjp~j2n5FgnUXX25zIYO~V3zdGdSwpbn-gQyBWGfH4MYH3D-cYz5A0MmIqq0WB6pePq~RlYPkZPDxKnB6qsvV8ofqbECcwi~hn7Kg6i0U7gQcWTOd8TiPTmIyEqMkjXo~raoMD-69adA8FCcplv-zQldleZkz1AyEV76W4ZvpFIsYhVHFo5ZENzIZcgK2dHLT8orFTUN4iT0pZfTWtRhb0SYbc-5NuWfOoi7~PJyf111FRT-mgCp8RNkojR27WpKbJ5ZA5QYqsXlFmmt8c0LfqL28XX0GUuLxAbLDlboPw11Jb5UBJ-hW70Wy9cr0kw__',
    'https://s3-alpha-sig.figma.com/img/e7e4/0206/2e74f45aa3e5b9aa0c38a030cee4959b?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=OmOjQCvQOX434-6Rux8tQzgc8Im~morWIeGy63AA5cFk4hH8d~DGafXWVGNf4WP~T3f2nCfaGM-5bLEk2uQWL3lJn~Ak6Rcqs2ssIx6~7UZriBm7SSagp2~FUdksaQfL7ygKz02m660U36Qp7EhQqrFJ94nOLCNMkcl1F9ewsUBE38ztRyHdzKpd5-Im7nxCP~gxYbUklzgH5fHwlpHXc2xLZ~CzFyKXyizDcuGmXu9lTm05bZIvFNBdhE6OKoSIZteCdXEfhIsWW5zeZbGO44ECd9YbjJ2G~22J3SJdSVquZYpRr4BwDuYGqLetC6gqxBxuybEY1pXhPc1Ff5iHxw__',
    'https://s3-alpha-sig.figma.com/img/3dd3/2388/548a1a5cd4fae1a12e1ed8d5eb5d7f67?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=n1TatgbC8GLonyNMekLcky9ZGm-TCSy6wz8A6avR1FnwhIhkcNpsbS7YPaS6YY-qgTMBl7chB77sQjGjAIhxXsQ2O2StwoDI3Du8UgQEupHwUcjyVr2iZj6VFK93seLRw1xZNLzo6nZaQv3RJ0Ten5k4JgY4gKeLCpzuS3CKxt1yoEBt-5y9ROiBTTcXu~-abtKQxAtLdWntFXipIvHFlh9UrgcMcDwM-UR-XLU39tVBjRcMIGssb0s7P7W~2Wp-3fLvMl-pW7f6ntdwKl9~KnxBA7HSK7NLpaoHn5r6CQzGhWV5z6oPEkLJuxD4PN2GT~igKYSH35e9qAVwYsPxmw__',
    'https://s3-alpha-sig.figma.com/img/ce38/14fb/9f261f4effa2b794948511b54810259b?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=LUN8Yi~gp4so4y7ppqduJVt8dGmhZtdzy8s~uOqi9GDzRhzJqtSRlDONYVzwxS2FRnpfqxRtPawLgXsrPEvlm8nSJt4KZFKheIClxEs3WjLMxcSsg2fRj~26LzHHuGZLSaWMxKiH4uBMDQZ7J3EJfjDD7P49NDaFUfcyK6VSFjpAzZwN8cwJptKLcc4PDPGPMI7I4Cl2Q5Fj8MtzNPfMDOj10w~XJkoNqyQ6ZNY2HVZEHkVhsTCWf4jc0OZx8DP~YJdud7Y0Cei7haQMeBagtB9~~iQ4TeUjD2ByFiTr~~EbWGI9b2Iz9U2ib5YJJuoS1jbQba1ybv4DL6fNq4zjhw__',
    'https://s3-alpha-sig.figma.com/img/a838/e9c2/8f148541f8f8674d41bc3d5e257446e1?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qOOHsVO~90fn6fq6uxLMB556kF1eckFMkW3MHqHBcgEweDuFkKS44vWzepBoPB2iWWjBLPmwKlIqI04R-sFZyGjPKVO3OQiP7eDUTxNJxTpN0470yoyfESeKmPNcZTIosBdkmtxL6DmRL0cibKlYN3SzgptDvrLL43QmxKTKWPyWSsHtbTL07abQTzcSNnh7yWFJTeAB0ixchQ-O0dpOvKpTAQ-9jSai4ArUdX1W5-Wvu15FL4hkkpYhoulTRtfqkKQazMVvfqmhrgCd~X0ju2ZTVf9pX4rjrMiBsPJykAAMT89YP-pw83~eJzJpw1P-FEwcA2E-xnF9d~kyBePMxQ__',
    'https://s3-alpha-sig.figma.com/img/a889/8d75/e0ff3ee67194644a954dad74b688da4a?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=hIgJXAPNZXERhYrLrAEMR4JOiTR0Xlg2754Q0M2r4pFxTCo3c0l25KEdRHkhsQU0FJNAYypA2Zo-6XjCEfFiwbj534azGaAkmxyqXB7Y4sAWi6rwhva5D6U0Nthjtx0uBPpzsfXyb3LIbE-znFbT6wi0KhsFhIS7K89ommRyKxqZzgLBgEDPCmAE-dCycYI8Wjm2S59u9n3hdV65vxZkWRom0Y4vFks-yMNT3I0J64b5XMTfOzW63cU99Cre5x5sAoH27boMAQn0-eykRZK0P~yLn38KHOSb~7XjFQ67y3V4zJLXBQBa5mkqY7mETJHQhnxla8c7JPhF4G36Yp2vCg__',
    'https://s3-alpha-sig.figma.com/img/a853/0d13/0fe0ddaeec703a316f384aee22d5ee51?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=H-z~ZD8sqTnLo~i5my5I5u7os5vdTQBV67Xc8kWmXDBR15e66CKfVSnIJ8WYe5z5lFyv2Pox-6h-ooWdV9a90wRtHj7eEGED2doY9gyWYmfBGK0YXpNka3uuLrwLD9VBliDunFYT5-twXp5MWBe9cKZ-EsC6Ryg7jo6O3PuJUdULUj9eDDrF8qg82FmE2NMooZFOETKhC5Z02Uf0uHOoqr36q2ce-BgwxrySB2IEEL8cW4peSoHlUyL-LCPTlegQ5y-OXIpIj6~MNueoj6NTVOewTYTceWkakCA3PQz5Mb0cdgbXHkKqUBB2W6q1EzjGUpOWT7bDIbastmrdvMSWNg__',
    'https://s3-alpha-sig.figma.com/img/29ee/b2de/ad9c059e52c42db60e4382fcbfdea8ce?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=iCZagAo5~0XbxpnOtYSAMZ88J0LrLy~QMbiavGYWyXY4mlYSQYVxsdPMwudjQdyAcwYnDwdL~42b1ucW32IELYc5I6jbcnjd8kXpj7kYK3t4UEPDBDOStkwTaLwlV5xYJiKQ0DKxL4-tbJbcoxDp7gh2zlW5vVWB0HDcSlc30O3TobmesagzroCeK1GFZjJBPvdnaskR~usMfgYDomK9UcW4sNMGaU6~~dYbn4oof1ss6OlijW2xbolV4ft4zSL2zGVwZ~7Te5L6wD5rA7VPhCIFY2ub39L~Z7~E23a-Bjw7sMoIxrZkj2bio9LlulGx3qoVSgeHUp8bchIk5338YA__',
  ];
  List<String> gride_image1 = [
    'https://s3-alpha-sig.figma.com/img/9879/be65/cb78d9f230682212edb7f9f15137b65b?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jMU29Pk~LhuZ5hxRlQpNF3UNjp~j2n5FgnUXX25zIYO~V3zdGdSwpbn-gQyBWGfH4MYH3D-cYz5A0MmIqq0WB6pePq~RlYPkZPDxKnB6qsvV8ofqbECcwi~hn7Kg6i0U7gQcWTOd8TiPTmIyEqMkjXo~raoMD-69adA8FCcplv-zQldleZkz1AyEV76W4ZvpFIsYhVHFo5ZENzIZcgK2dHLT8orFTUN4iT0pZfTWtRhb0SYbc-5NuWfOoi7~PJyf111FRT-mgCp8RNkojR27WpKbJ5ZA5QYqsXlFmmt8c0LfqL28XX0GUuLxAbLDlboPw11Jb5UBJ-hW70Wy9cr0kw__',
    'https://s3-alpha-sig.figma.com/img/3dd3/2388/548a1a5cd4fae1a12e1ed8d5eb5d7f67?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=n1TatgbC8GLonyNMekLcky9ZGm-TCSy6wz8A6avR1FnwhIhkcNpsbS7YPaS6YY-qgTMBl7chB77sQjGjAIhxXsQ2O2StwoDI3Du8UgQEupHwUcjyVr2iZj6VFK93seLRw1xZNLzo6nZaQv3RJ0Ten5k4JgY4gKeLCpzuS3CKxt1yoEBt-5y9ROiBTTcXu~-abtKQxAtLdWntFXipIvHFlh9UrgcMcDwM-UR-XLU39tVBjRcMIGssb0s7P7W~2Wp-3fLvMl-pW7f6ntdwKl9~KnxBA7HSK7NLpaoHn5r6CQzGhWV5z6oPEkLJuxD4PN2GT~igKYSH35e9qAVwYsPxmw__',
    'https://s3-alpha-sig.figma.com/img/ce38/14fb/9f261f4effa2b794948511b54810259b?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=LUN8Yi~gp4so4y7ppqduJVt8dGmhZtdzy8s~uOqi9GDzRhzJqtSRlDONYVzwxS2FRnpfqxRtPawLgXsrPEvlm8nSJt4KZFKheIClxEs3WjLMxcSsg2fRj~26LzHHuGZLSaWMxKiH4uBMDQZ7J3EJfjDD7P49NDaFUfcyK6VSFjpAzZwN8cwJptKLcc4PDPGPMI7I4Cl2Q5Fj8MtzNPfMDOj10w~XJkoNqyQ6ZNY2HVZEHkVhsTCWf4jc0OZx8DP~YJdud7Y0Cei7haQMeBagtB9~~iQ4TeUjD2ByFiTr~~EbWGI9b2Iz9U2ib5YJJuoS1jbQba1ybv4DL6fNq4zjhw__',
    'https://s3-alpha-sig.figma.com/img/a889/8d75/e0ff3ee67194644a954dad74b688da4a?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=hIgJXAPNZXERhYrLrAEMR4JOiTR0Xlg2754Q0M2r4pFxTCo3c0l25KEdRHkhsQU0FJNAYypA2Zo-6XjCEfFiwbj534azGaAkmxyqXB7Y4sAWi6rwhva5D6U0Nthjtx0uBPpzsfXyb3LIbE-znFbT6wi0KhsFhIS7K89ommRyKxqZzgLBgEDPCmAE-dCycYI8Wjm2S59u9n3hdV65vxZkWRom0Y4vFks-yMNT3I0J64b5XMTfOzW63cU99Cre5x5sAoH27boMAQn0-eykRZK0P~yLn38KHOSb~7XjFQ67y3V4zJLXBQBa5mkqY7mETJHQhnxla8c7JPhF4G36Yp2vCg__',
  ];
  List<String> gride_title = [
    'Property Listing',
    'Photography',
    'Guest\nCommunications',
    'Check-In / Out',
    'Repairs &\nMaintenance',
    'Housekeeping',
    'Gardening',
    'Renovation &\nDecorations',
  ];
  List<String> gride_title1 = [
    'Property Listing',
    'Guest\nCommunications',
    'Check-In / Out',
    'Housekeeping',
  ];
  List<List> review = [
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
                  Header_AssetAll(headerKey: _headerKey),
                  const SizedBox(height: 80),
                  Align(
                    alignment: Alignment.center,
                    child: 'Naina Asset: Professional Rental Property Manager'.poppins(
                        color: Color.fromRGBO(72, 72, 72, 1),
                        fontSize: 34 + 4 * pad,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center),
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '10+ years of experience in hospitality and real estate experience. ',
                          style: TextStyle(
                            color: Color.fromRGBO(72, 60, 60, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            height: 1.5,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  const SizedBox(height: 48),
                  FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Metrics.isMobile(context)
                          ? const SizedBox(
                              height: 500,
                              child: Column(
                                children: [
                                  tag(
                                    img: 'images/82931e3de9e258f8d41ea43191d784c5s.png',
                                    title: 'Lease Out Your Property',
                                    subtitle:
                                        'Stay with us ease-free at our handpicked properties at prime locations in Chiang Mai, Thailand! ',
                                  ),
                                  tag(
                                    img: 'images/82931e3de9e258f8d41ea43191d784c5d.png',
                                    title: 'Maintenance Services',
                                    subtitle: 'property listings, bookings, guest communications, full management',
                                  ),
                                  tag(
                                    img: 'images/82931e3de9e258f8d41ea43191d784c5df.png',
                                    title: 'Guest Communications',
                                    subtitle:
                                        'In need of property maintenance services i.e. repairs, cleanings, gardening ? We’re here to help!',
                                  ),
                                ],
                              ),
                            )
                          : const Row(
                              children: [
                                tag(
                                  img: 'images/82931e3de9e258f8d41ea43191d784c5s.png',
                                  title: 'Lease Out Your Property',
                                  subtitle:
                                      'Stay with us ease-free at our handpicked properties at prime locations in Chiang Mai, Thailand! ',
                                ),
                                tag(
                                  img: 'images/82931e3de9e258f8d41ea43191d784c5d.png',
                                  title: 'Maintenance Services',
                                  subtitle: 'property listings, bookings, guest communications, full management',
                                ),
                                tag(
                                  img: 'images/82931e3de9e258f8d41ea43191d784c5df.png',
                                  title: 'Guest Communications',
                                  subtitle:
                                      'In need of property maintenance services i.e. repairs, cleanings, gardening ? We’re here to help!',
                                ),
                              ],
                            )
                      // Column(
                      //   children: [

                      //     // if (isBigScreen)
                      //     //   Row(
                      //     //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     //     children: List.generate(
                      //     //       cards.length,
                      //     //       (index) => HowItWorksCardItem(
                      //     //         item: cards[index],
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //     // if (Metrics.isCompact(context))
                      //     //   Row(
                      //     //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     //     children: List.generate(
                      //     //       2,
                      //     //       (index) => HowItWorksCardItem(
                      //     //         item: cards[index],
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //     // if (Metrics.isCompact(context))
                      //     //   Row(
                      //     //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     //     children: List.generate(
                      //     //       2,
                      //     //       (index) => HowItWorksCardItem(
                      //     //         item: cards[index + 2],
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //     // if (Metrics.isMobile(context))
                      //     //   Column(
                      //     //     children: List.generate(
                      //     //       cards.length,
                      //     //       (index) => Row(
                      //     //         children: [
                      //     //           HowItWorksCardItem(
                      //     //             item: cards[index],
                      //     //           ),
                      //     //         ],
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //   ],
                      // ),
                      ),

                  const SizedBox(height: 80),
                  BaseContainer(
                      child: Column(
                          crossAxisAlignment:
                              Metrics.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                          children: [
                        // Asset_Management()
                        Stack(
                          children: [
                            Center(
                              child: FractionallySizedBox(
                                widthFactor: 0.95,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: textPrimary.withOpacity(0.15),
                                        offset: const Offset(0, 6),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      FractionallySizedBox(
                                        widthFactor: 0.9,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Metrics.isMobile(context)
                                              ? Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          '35%'.poppins(
                                                              fontSize: 40,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color.fromRGBO(72, 72, 72, 1),
                                                              textAlign: TextAlign.center),
                                                          'Commission Fee'.poppins(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color.fromRGBO(72, 72, 72, 1),
                                                              textAlign: TextAlign.center),
                                                          '+ Renovation Fee*'.poppins(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w400,
                                                              color: Color.fromRGBO(72, 72, 72, 1),
                                                              textAlign: TextAlign.center),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                            child: 'Inclusive Services'.poppins(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                color: Color.fromRGBO(72, 72, 72, 1)),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(0.0),
                                                            child:
                                                                '    \n With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don\'t worry about contacting us. Because we always have good suggestions.'
                                                                    .poppins(
                                                                        fontSize: 18,
                                                                        fontWeight: FontWeight.w400,
                                                                        textAlign: TextAlign.center,
                                                                        color: Color.fromRGBO(72, 72, 72, 1)),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(40.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          '35%'.poppins(
                                                              fontSize: 40,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color.fromRGBO(72, 72, 72, 1)),
                                                          'Commission Fee'.poppins(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color.fromRGBO(72, 72, 72, 1)),
                                                          '+ Renovation Fee*'.poppins(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w400,
                                                              color: Color.fromRGBO(72, 72, 72, 1)),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                              child: 'Inclusive Services'.poppins(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Color.fromRGBO(72, 72, 72, 1)),
                                                            ),
                                                            Container(
                                                              padding: const EdgeInsets.all(16.0),
                                                              child:
                                                                  '    \n With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don\'t worry about contacting us. Because we always have good suggestions.'
                                                                      .poppins(
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.w400,
                                                                          textAlign: TextAlign.justify,
                                                                          color: Color.fromRGBO(72, 72, 72, 1)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                        ),
                                      ),
                                      Center(
                                        child: FractionallySizedBox(
                                          widthFactor: 0.95,
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
                                            itemCount: 8, // Number of items in the grid
                                            itemBuilder: (BuildContext context, int index) {
                                              // final img = index1 == 1 ? gride_image[index + 4] : gride_image[index];
                                              final img = gride_image[index];
                                              final title = gride_title[index];
                                              return AspectRatio(
                                                aspectRatio: 9 / 8,
                                                child: Container(
                                                    alignment: Alignment.bottomLeft,
                                                    clipBehavior: Clip.antiAlias,
                                                    padding: EdgeInsets.all(20),
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(img), fit: BoxFit.cover),
                                                        borderRadius: BorderRadius.circular(20)),
                                                    child: Text(
                                                      title,
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w600,
                                                          color: white,
                                                          fontSize: 20,
                                                          shadows: [
                                                            Shadow(
                                                                blurRadius: 2,
                                                                color: Colors.black38,
                                                                offset: Offset(2, 2))
                                                          ]),
                                                    )),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                              padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 100),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                    color: textPrimary.withOpacity(0.15),
                                    offset: const Offset(0, 6),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: 'Full Management Scheme'.poppins(
                                  fontSize: Metrics.isMobile(context) ? 14 : 30,
                                  color: Color.fromRGBO(61, 57, 57, 1),
                                  fontWeight: FontWeight.w600),
                            )),
                          ],
                        ),
                        Stack(
                          children: [
                            Center(
                              child: FractionallySizedBox(
                                widthFactor: 0.95,
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: textPrimary.withOpacity(0.15),
                                        offset: const Offset(0, 6),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      FractionallySizedBox(
                                        widthFactor: 0.9,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Metrics.isMobile(context)
                                              ? Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          '25%'.poppins(
                                                              fontSize: 40,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color.fromRGBO(72, 72, 72, 1),
                                                              textAlign: TextAlign.center),
                                                          'Commission Fee'.poppins(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color.fromRGBO(72, 72, 72, 1),
                                                              textAlign: TextAlign.center),
                                                          '+ Renovation Fee*'.poppins(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w400,
                                                              color: Color.fromRGBO(72, 72, 72, 1),
                                                              textAlign: TextAlign.center),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                            child: 'Inclusive Services'.poppins(
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                color: Color.fromRGBO(72, 72, 72, 1)),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(0.0),
                                                            child:
                                                                '    \n With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don\'t worry about contacting us. Because we always have good suggestions.'
                                                                    .poppins(
                                                                        fontSize: 18,
                                                                        fontWeight: FontWeight.w400,
                                                                        textAlign: TextAlign.center,
                                                                        color: Color.fromRGBO(72, 72, 72, 1)),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(40.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          '25%'.poppins(
                                                              fontSize: 40,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color.fromRGBO(72, 72, 72, 1)),
                                                          'Commission Fee'.poppins(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color.fromRGBO(72, 72, 72, 1)),
                                                          '+ Renovation Fee*'.poppins(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w400,
                                                              color: Color.fromRGBO(72, 72, 72, 1)),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                              child: 'Inclusive Services'.poppins(
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Color.fromRGBO(72, 72, 72, 1)),
                                                            ),
                                                            Container(
                                                              padding: const EdgeInsets.all(16.0),
                                                              child:
                                                                  '    \n With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don\'t worry about contacting us. Because we always have good suggestions.'
                                                                      .poppins(
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.w400,
                                                                          textAlign: TextAlign.justify,
                                                                          color: Color.fromRGBO(72, 72, 72, 1)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                        ),
                                      ),
                                      Center(
                                        child: FractionallySizedBox(
                                          widthFactor: 0.95,
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
                                            itemCount: 4, // Number of items in the grid
                                            itemBuilder: (BuildContext context, int index) {
                                              // final img = index1 == 1 ? gride_image[index + 4] : gride_image[index];
                                              final img = gride_image1[index];
                                              final title = gride_title1[index];
                                              return AspectRatio(
                                                aspectRatio: 9 / 8,
                                                child: Container(
                                                    alignment: Alignment.bottomLeft,
                                                    clipBehavior: Clip.antiAlias,
                                                    padding: EdgeInsets.all(20),
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(img), fit: BoxFit.cover),
                                                        borderRadius: BorderRadius.circular(20)),
                                                    child: Text(
                                                      title,
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w600,
                                                          color: white,
                                                          fontSize: 20,
                                                          shadows: [
                                                            Shadow(
                                                                blurRadius: 2,
                                                                color: Colors.black38,
                                                                offset: Offset(2, 2))
                                                          ]),
                                                    )),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                              padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 100),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                    color: textPrimary.withOpacity(0.15),
                                    offset: const Offset(0, 6),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: 'Partial Management Scheme'.poppins(
                                  fontSize: Metrics.isMobile(context) ? 14 : 30,
                                  color: Color.fromRGBO(61, 57, 57, 1),
                                  fontWeight: FontWeight.w600),
                            )),
                          ],
                        ),
                        Center(
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Column(
                              children: [
                                'Or simply choose our one-off services:'.poppins(
                                    fontSize: 30, fontWeight: FontWeight.w600, color: Color.fromRGBO(72, 72, 72, 1)),
                                Metrics.isMobile(context)
                                    ? Column(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 12 / 9,
                                            child: Container(
                                              margin: EdgeInsets.all(Metrics.isMobile(context) ? 10 : 40),
                                              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://s3-alpha-sig.figma.com/img/a838/e9c2/8f148541f8f8674d41bc3d5e257446e1?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qOOHsVO~90fn6fq6uxLMB556kF1eckFMkW3MHqHBcgEweDuFkKS44vWzepBoPB2iWWjBLPmwKlIqI04R-sFZyGjPKVO3OQiP7eDUTxNJxTpN0470yoyfESeKmPNcZTIosBdkmtxL6DmRL0cibKlYN3SzgptDvrLL43QmxKTKWPyWSsHtbTL07abQTzcSNnh7yWFJTeAB0ixchQ-O0dpOvKpTAQ-9jSai4ArUdX1W5-Wvu15FL4hkkpYhoulTRtfqkKQazMVvfqmhrgCd~X0ju2ZTVf9pX4rjrMiBsPJykAAMT89YP-pw83~eJzJpw1P-FEwcA2E-xnF9d~kyBePMxQ__'),
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment.center)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  'Repairs &\n Maintenance'
                                                      .poppins(fontWeight: FontWeight.bold, fontSize: 20, color: white),
                                                  Container(
                                                    padding: EdgeInsets.all(16.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8.0), color: white),
                                                    child: 'See more'.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromRGBO(55, 65, 81, 1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          AspectRatio(
                                            aspectRatio: 12 / 9,
                                            child: Container(
                                              margin: EdgeInsets.all(Metrics.isMobile(context) ? 10 : 40),
                                              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://s3-alpha-sig.figma.com/img/a889/8d75/e0ff3ee67194644a954dad74b688da4a?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=hIgJXAPNZXERhYrLrAEMR4JOiTR0Xlg2754Q0M2r4pFxTCo3c0l25KEdRHkhsQU0FJNAYypA2Zo-6XjCEfFiwbj534azGaAkmxyqXB7Y4sAWi6rwhva5D6U0Nthjtx0uBPpzsfXyb3LIbE-znFbT6wi0KhsFhIS7K89ommRyKxqZzgLBgEDPCmAE-dCycYI8Wjm2S59u9n3hdV65vxZkWRom0Y4vFks-yMNT3I0J64b5XMTfOzW63cU99Cre5x5sAoH27boMAQn0-eykRZK0P~yLn38KHOSb~7XjFQ67y3V4zJLXBQBa5mkqY7mETJHQhnxla8c7JPhF4G36Yp2vCg__'),
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment.center)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  'House-\nkeeping'
                                                      .poppins(fontWeight: FontWeight.bold, fontSize: 20, color: white),
                                                  Container(
                                                    padding: EdgeInsets.all(16.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8.0), color: white),
                                                    child: 'See more'.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromRGBO(55, 65, 81, 1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          AspectRatio(
                                            aspectRatio: 12 / 9,
                                            child: Container(
                                              margin: EdgeInsets.all(Metrics.isMobile(context) ? 10 : 40),
                                              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://s3-alpha-sig.figma.com/img/a853/0d13/0fe0ddaeec703a316f384aee22d5ee51?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=H-z~ZD8sqTnLo~i5my5I5u7os5vdTQBV67Xc8kWmXDBR15e66CKfVSnIJ8WYe5z5lFyv2Pox-6h-ooWdV9a90wRtHj7eEGED2doY9gyWYmfBGK0YXpNka3uuLrwLD9VBliDunFYT5-twXp5MWBe9cKZ-EsC6Ryg7jo6O3PuJUdULUj9eDDrF8qg82FmE2NMooZFOETKhC5Z02Uf0uHOoqr36q2ce-BgwxrySB2IEEL8cW4peSoHlUyL-LCPTlegQ5y-OXIpIj6~MNueoj6NTVOewTYTceWkakCA3PQz5Mb0cdgbXHkKqUBB2W6q1EzjGUpOWT7bDIbastmrdvMSWNg__'),
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment.center)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  'Gardening'
                                                      .poppins(fontWeight: FontWeight.bold, fontSize: 20, color: white),
                                                  Container(
                                                    padding: EdgeInsets.all(16.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8.0), color: white),
                                                    child: 'See more'.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromRGBO(55, 65, 81, 1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                              child: AspectRatio(
                                            aspectRatio: 9 / 12,
                                            child: Container(
                                              margin: EdgeInsets.all(40),
                                              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://s3-alpha-sig.figma.com/img/a838/e9c2/8f148541f8f8674d41bc3d5e257446e1?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qOOHsVO~90fn6fq6uxLMB556kF1eckFMkW3MHqHBcgEweDuFkKS44vWzepBoPB2iWWjBLPmwKlIqI04R-sFZyGjPKVO3OQiP7eDUTxNJxTpN0470yoyfESeKmPNcZTIosBdkmtxL6DmRL0cibKlYN3SzgptDvrLL43QmxKTKWPyWSsHtbTL07abQTzcSNnh7yWFJTeAB0ixchQ-O0dpOvKpTAQ-9jSai4ArUdX1W5-Wvu15FL4hkkpYhoulTRtfqkKQazMVvfqmhrgCd~X0ju2ZTVf9pX4rjrMiBsPJykAAMT89YP-pw83~eJzJpw1P-FEwcA2E-xnF9d~kyBePMxQ__'),
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment.center)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  'Repairs &\n Maintenance'
                                                      .poppins(fontWeight: FontWeight.bold, fontSize: 30, color: white),
                                                  Container(
                                                    padding: EdgeInsets.all(16.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8.0), color: white),
                                                    child: 'See more'.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromRGBO(55, 65, 81, 1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                          Expanded(
                                              child: AspectRatio(
                                            aspectRatio: 9 / 12,
                                            child: Container(
                                              margin: EdgeInsets.all(40),
                                              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://s3-alpha-sig.figma.com/img/a889/8d75/e0ff3ee67194644a954dad74b688da4a?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=hIgJXAPNZXERhYrLrAEMR4JOiTR0Xlg2754Q0M2r4pFxTCo3c0l25KEdRHkhsQU0FJNAYypA2Zo-6XjCEfFiwbj534azGaAkmxyqXB7Y4sAWi6rwhva5D6U0Nthjtx0uBPpzsfXyb3LIbE-znFbT6wi0KhsFhIS7K89ommRyKxqZzgLBgEDPCmAE-dCycYI8Wjm2S59u9n3hdV65vxZkWRom0Y4vFks-yMNT3I0J64b5XMTfOzW63cU99Cre5x5sAoH27boMAQn0-eykRZK0P~yLn38KHOSb~7XjFQ67y3V4zJLXBQBa5mkqY7mETJHQhnxla8c7JPhF4G36Yp2vCg__'),
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment.center)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  'House-\nkeeping'
                                                      .poppins(fontWeight: FontWeight.bold, fontSize: 30, color: white),
                                                  Container(
                                                    padding: EdgeInsets.all(16.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8.0), color: white),
                                                    child: 'See more'.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromRGBO(55, 65, 81, 1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                          Expanded(
                                              child: AspectRatio(
                                            aspectRatio: 9 / 12,
                                            child: Container(
                                              margin: EdgeInsets.all(40),
                                              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://s3-alpha-sig.figma.com/img/a853/0d13/0fe0ddaeec703a316f384aee22d5ee51?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=H-z~ZD8sqTnLo~i5my5I5u7os5vdTQBV67Xc8kWmXDBR15e66CKfVSnIJ8WYe5z5lFyv2Pox-6h-ooWdV9a90wRtHj7eEGED2doY9gyWYmfBGK0YXpNka3uuLrwLD9VBliDunFYT5-twXp5MWBe9cKZ-EsC6Ryg7jo6O3PuJUdULUj9eDDrF8qg82FmE2NMooZFOETKhC5Z02Uf0uHOoqr36q2ce-BgwxrySB2IEEL8cW4peSoHlUyL-LCPTlegQ5y-OXIpIj6~MNueoj6NTVOewTYTceWkakCA3PQz5Mb0cdgbXHkKqUBB2W6q1EzjGUpOWT7bDIbastmrdvMSWNg__'),
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment.center)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  'Gardening'
                                                      .poppins(fontWeight: FontWeight.bold, fontSize: 30, color: white),
                                                  Container(
                                                    padding: EdgeInsets.all(16.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8.0), color: white),
                                                    child: 'See more'.poppins(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color.fromRGBO(55, 65, 81, 1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ))
                                        ],
                                      ),
                                AspectRatio(
                                  aspectRatio: Metrics.isMobile(context) ? 4 / 3 : 3 / 1,
                                  child: Container(
                                    margin: EdgeInsets.all(Metrics.isMobile(context) ? 20 : 40),
                                    padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://s3-alpha-sig.figma.com/img/29ee/b2de/ad9c059e52c42db60e4382fcbfdea8ce?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=iCZagAo5~0XbxpnOtYSAMZ88J0LrLy~QMbiavGYWyXY4mlYSQYVxsdPMwudjQdyAcwYnDwdL~42b1ucW32IELYc5I6jbcnjd8kXpj7kYK3t4UEPDBDOStkwTaLwlV5xYJiKQ0DKxL4-tbJbcoxDp7gh2zlW5vVWB0HDcSlc30O3TobmesagzroCeK1GFZjJBPvdnaskR~usMfgYDomK9UcW4sNMGaU6~~dYbn4oof1ss6OlijW2xbolV4ft4zSL2zGVwZ~7Te5L6wD5rA7VPhCIFY2ub39L~Z7~E23a-Bjw7sMoIxrZkj2bio9LlulGx3qoVSgeHUp8bchIk5338YA__'),
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center)),
                                    child: Column(
                                      crossAxisAlignment: Metrics.isMobile(context)
                                          ? CrossAxisAlignment.center
                                          : CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          Metrics.isMobile(context) ? MainAxisAlignment.center : MainAxisAlignment.end,
                                      children: [
                                        'Renovation Service'.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Metrics.isMobile(context) ? 20 : 40,
                                            color: white),
                                      ],
                                    ),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: 0.9,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 64),
                                      'Homeowners Testimonials on Listing with Naina Asset'.poppins(
                                          color: Color.fromRGBO(60, 60, 60, 1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: Metrics.isMobile(context) ? 12 : 25,
                                          textAlign: TextAlign.center),
                                      const SizedBox(height: 34),
                                      Container(
                                        height: 500,
                                        width: double.infinity,
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
                                                // childAspectRatio: 3 / 1,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10,
                                                mainAxisExtent: 200.0),
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
                                                    height: 150,
                                                    margin: EdgeInsets.only(left: 50),
                                                    padding: EdgeInsets.only(left: 70, right: 16, top: 16, bottom: 16),
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
                                                            if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                                                              RatingBar.builder(
                                                                initialRating:
                                                                    double.parse('${reviewmodels[index].poit_score}'),
                                                                minRating: 1,
                                                                direction: Axis.horizontal,
                                                                allowHalfRating: true,
                                                                itemCount: 5,
                                                                itemSize: 16,
                                                                itemPadding:
                                                                    const EdgeInsets.symmetric(horizontal: 4.0),
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
                                                        if (Metrics.isMobile(context))
                                                          RatingBar.builder(
                                                            initialRating:
                                                                double.parse('${reviewmodels[index].poit_score}'),
                                                            minRating: 1,
                                                            direction: Axis.horizontal,
                                                            allowHalfRating: true,
                                                            itemCount: 5,
                                                            itemSize: 16,
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
                                                      width: 100,
                                                      height: 100,
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
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 80),
                                      'Have a vacant property? Why not list with us!'.poppins(
                                        textAlign: TextAlign.start,
                                        fontSize: 28,
                                        color: Color.fromRGBO(72, 72, 72, 1),
                                        fontWeight: FontWeight.w600,
                                      ),
                                      const SizedBox(height: 16),
                                      'Please kindly leave your email or phone number and we will get back to you as soon as possible!'
                                          .poppins(
                                        color: Color.fromRGBO(53, 51, 51, 1),
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                        letterSpacing: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AspectRatio(
                                  aspectRatio: isBigScreen == Metrics.isTablet(context) ? 16 / 12 : 16 / 3,
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        // colorFilter: ColorFilter.mode(Colors.white38, BlendMode.softLight),
                                        image: AssetImage('images/d0829a0498729e1591a1f3845edd3cd71.jpg'),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    child: Center(
                                      child: FractionallySizedBox(
                                        widthFactor: isBigScreen == Metrics.isMobile(context) ? 0.9 : 0.6,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextField(
                                              // controller: ,
                                              decoration: InputDecoration(
                                                  hintText: 'Email or Phone number ...'.toUpperCase(),
                                                  filled: true,
                                                  hintStyle: TextStyle(fontSize: Metrics.isMobile(context) ? 8 : 12),
                                                  fillColor: white,
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide.none,
                                                      borderRadius: BorderRadius.circular(5))),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                padding: const EdgeInsets.all(16),
                                                margin: EdgeInsets.only(bottom: 12 + 12 * pad),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(5),
                                                  // boxShadow: [
                                                  //   BoxShadow(
                                                  //     color: Colors.grey.withOpacity(0.25),
                                                  //     offset: const Offset(0, 4),
                                                  //     blurRadius: 4,
                                                  //   ),
                                                  // ],
                                                ),
                                                child: 'Submit Contact Information >'.toUpperCase().poppins(
                                                      color: Color.fromRGBO(72, 72, 72, 1),
                                                      fontWeight: FontWeight.w500,
                                                      height: 1.5,
                                                      letterSpacing: 1,
                                                      fontSize: isBigScreen == Metrics.isTablet(context) ? 6 : 12,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ])),
                  // Container(
                  //     width: Metrics.width(context),
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.only(
                  //         topLeft: Radius.circular(0),
                  //         topRight: Radius.circular(0),
                  //         bottomLeft: Radius.circular(0),
                  //         bottomRight: Radius.circular(0),
                  //       ),
                  //       // color: white,
                  //       // border: Border.all(
                  //       //     color: const Color.fromARGB(255, 163, 161, 161), width: 1),
                  //       gradient: LinearGradient(
                  //         colors: [
                  //           white,
                  //           Colors.grey[50]!.withOpacity(0.5),
                  //           Colors.grey[100]!.withOpacity(0.5),
                  //           white,
                  //         ],
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.bottomCenter,
                  //       ),
                  //     ),
                  //     child: Asset_Management()),
                  // const SizedBox(height: 80),
                  // BaseContainer(
                  //     child: Column(
                  //         crossAxisAlignment: Metrics.isMobile(context)
                  //             ? CrossAxisAlignment.center
                  //             : CrossAxisAlignment.start,
                  //         children: [])),
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

class tag extends StatelessWidget {
  const tag({super.key, required this.img, required this.title, required this.subtitle});
  final String img;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        // padding: EdgeInsets.all(0),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
          boxShadow: [
            BoxShadow(
              color: textPrimary.withOpacity(0.15),
              offset: const Offset(0, 6),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(color: Color.fromRGBO(35, 66, 103, 1)),
              child: Image.asset(
                img,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    title.poppins(
                        color: Color.fromRGBO(72, 72, 72, 1), fontWeight: FontWeight.w600, textAlign: TextAlign.start),
                    subtitle.poppins(
                        color: Color.fromRGBO(72, 72, 72, 1), fontWeight: FontWeight.w400, textAlign: TextAlign.start),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
