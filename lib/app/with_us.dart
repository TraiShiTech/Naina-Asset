import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:properties/app/layouts/header/header_asset_all.dart';
import 'package:properties/app/widgets/base_container.dart';
import 'package:properties/app/widgets/how_it_work_card_item.dart';
import 'package:properties/core/core.dart';
import 'package:http/http.dart' as http;
import '../Constant/Myconstant.dart';
import '../core/models/list_withUs_model.dart';
import '../core/models/package_model.dart';
import 'components/appbar/appbar.dart';
import 'layouts/about_us/image_clider_controller.dart';
import 'layouts/asset_as/asset_management.dart';
import 'layouts/footer/footer.dart';
import 'layouts/header/header_with_us.dart';

class WistUs extends ConsumerStatefulWidget {
  const WistUs({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WistUsState();
}

class _WistUsState extends ConsumerState<WistUs> {
  int limit = 2; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
///////----------------------------------------------->
  late ScrollController _baseController;

  final GlobalKey _headerKey = GlobalKey();

///////----------------------------------------------->
  late PageController _controller;
  int currentPage = 1;
  ///////----------------------------------------------->
  List<packagemodel> packagemodels = [];
  List<ListWithUsModel> ListWithUsModels = [];
  List<bool> isHover = [];
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
    read_GC_PackagAll();
    read_GC_ListWithUsAll();
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

///////----------------------------------------------->
  Future<Null> read_GC_ListWithUsAll() async {
    if (ListWithUsModels.length != 0) {
      ListWithUsModels.clear();
    }

    String url = '${MyConstant().domain}/GC_ListWithUs_All.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        ListWithUsModel ListWithUsModelss = ListWithUsModel.fromJson(map);

        setState(() {
          ListWithUsModels.add(ListWithUsModelss);
        });
      }
    } catch (e) {}
  }

///////----------------------------------------------->
  Future<Null> read_GC_PackagAll() async {
    if (packagemodels.length != 0) {
      packagemodels.clear();
    }

    String url = '${MyConstant().domain}/GC_Package.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        packagemodel packagemodelss = packagemodel.fromJson(map);

        setState(() {
          packagemodels.add(packagemodelss);
        });
      }
      read_isHover();
    } catch (e) {}
  }

///////----------------------------------------------->
  Future<void> read_isHover() async {
    setState(() {
      isHover = List.generate(
        packagemodels.length,
        (index) => false,
      );
    });
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

    ///////-------------------------------------->
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
                  Header_WithUs(headerKey: _headerKey),
                  const SizedBox(height: 80),
                  Align(
                    alignment: Alignment.center,
                    child: 'List with us'.poppins(
                      color: Color.fromRGBO(71, 69, 69, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 25 + 4 * pad,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: 'Earn'.poppinscenter(
                        color: Color.fromRGBO(87, 87, 87, 1),
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  BaseContainer(
                      child: FractionallySizedBox(
                    widthFactor: Metrics.isMobile(context) ? 1 : 0.7,
                    child: Column(
                        crossAxisAlignment:
                            Metrics.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.center,
                        children: [
                          Metrics.isMobile(context)
                              ? Container(
                                  width: double.infinity,
                                  // height: 500 * pad1,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(width: 1, color: Colors.grey)),
                                  child: Column(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 6 / 4,
                                        child: Image.network(
                                          '${ListWithUsModels[0].corver_img}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 20),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  'Get in touch'.poppins(
                                                    color: Color.fromRGBO(85, 82, 82, 1),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25 + 4 * pad,
                                                  ),
                                                  Container(
                                                    height: 5,
                                                    width: 100,
                                                    color: Color.fromRGBO(222, 110, 75, 1),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Container(
                                            // width: 200,
                                            height: 40,
                                            // color: white,
                                            padding: EdgeInsets.only(left: 30.0 * pad, right: 30.0 * pad),
                                            child: Container(
                                              color: white,
                                              child: TextFormField(
                                                cursorColor: Colors.green,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.grey[200]!.withOpacity(0.5),
                                                  filled: true,
                                                  // prefixIcon:
                                                  //     const Icon(Icons.person, color: Colors.black),
                                                  // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                  focusedBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(10),
                                                      topLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(10),
                                                      bottomLeft: Radius.circular(10),
                                                    ),
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  enabledBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(10),
                                                      topLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(10),
                                                      bottomLeft: Radius.circular(10),
                                                    ),
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Container(
                                            // width: 200,
                                            height: 40,
                                            // color: white,
                                            padding: EdgeInsets.only(left: 30.0 * pad, right: 30.0 * pad),
                                            child: Container(
                                              color: white,
                                              child: TextFormField(
                                                cursorColor: Colors.green,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.grey[200]!.withOpacity(0.5),
                                                  filled: true,
                                                  // prefixIcon:
                                                  //     const Icon(Icons.person, color: Colors.black),
                                                  // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                  focusedBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(10),
                                                      topLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(10),
                                                      bottomLeft: Radius.circular(10),
                                                    ),
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  enabledBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(10),
                                                      topLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(10),
                                                      bottomLeft: Radius.circular(10),
                                                    ),
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              height: 200,
                                              padding: EdgeInsets.only(left: 30.0 * pad, right: 30.0 * pad),
                                              color: white,
                                              child: Center(
                                                child: TextFormField(
                                                  maxLines: 80,
                                                  // maxLength: 13,
                                                  cursorColor: Colors.green,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey[200]!.withOpacity(0.5),
                                                    filled: true,
                                                    // prefixIcon:
                                                    //     const Icon(Icons.person, color: Colors.black),
                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                    focusedBorder: const OutlineInputBorder(
                                                      borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(10),
                                                        topLeft: Radius.circular(10),
                                                        bottomRight: Radius.circular(10),
                                                        bottomLeft: Radius.circular(10),
                                                      ),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    enabledBorder: const OutlineInputBorder(
                                                      borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(10),
                                                        topLeft: Radius.circular(10),
                                                        bottomRight: Radius.circular(10),
                                                        bottomLeft: Radius.circular(10),
                                                      ),
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: Container(
                                                // height: 40,
                                                // width: 120,
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight: Radius.circular(8),
                                                    bottomLeft: Radius.circular(8),
                                                    bottomRight: Radius.circular(8),
                                                  ),
                                                  color: Color.fromRGBO(154, 135, 129, 1),
                                                  // border: Border.all(
                                                  //     color: Color.fromARGB(255, 150, 148, 148), width: 2),
                                                ),
                                                padding: const EdgeInsets.all(8.0),
                                                child: 'Submit'.poppins(
                                                  color: white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12 + 4 * pad,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : Stack(
                                  children: [
                                    AspectRatio(
                                        aspectRatio:
                                            // 45 / 35,
                                            Metrics.isMobile(context)
                                                ? 45 / 65
                                                : Metrics.isCompact(context)
                                                    ? 45 / 65
                                                    : Metrics.isTablet(context)
                                                        ? 6 / 2
                                                        : 60 / 30,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                                bottomRight: Radius.circular(20),
                                              ),
                                              color: white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.25),
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                              border: Border.all(color: Color.fromARGB(255, 192, 189, 189), width: 1),
                                              // image: DecorationImage(
                                              //   image: AssetImage(
                                              //     'assets/property_service/11.jpg',
                                              //   ),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        const SizedBox(height: 20),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(20.0),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                'Get in touch'.poppins(
                                                                  color: Color.fromRGBO(85, 82, 82, 1),
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 25 + 4 * pad,
                                                                ),
                                                                Container(
                                                                  height: 5,
                                                                  width: 100,
                                                                  color: Color.fromRGBO(222, 110, 75, 1),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 20),
                                                        Container(
                                                          // width: 200,
                                                          height: 40,
                                                          // color: white,
                                                          padding: EdgeInsets.only(left: 30.0 * pad, right: 30.0 * pad),
                                                          child: Container(
                                                            color: white,
                                                            child: TextFormField(
                                                              cursorColor: Colors.green,
                                                              decoration: InputDecoration(
                                                                fillColor: Colors.grey[200]!.withOpacity(0.5),
                                                                filled: true,
                                                                // prefixIcon:
                                                                //     const Icon(Icons.person, color: Colors.black),
                                                                // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                focusedBorder: const OutlineInputBorder(
                                                                  borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(10),
                                                                    topLeft: Radius.circular(10),
                                                                    bottomRight: Radius.circular(10),
                                                                    bottomLeft: Radius.circular(10),
                                                                  ),
                                                                  borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                                enabledBorder: const OutlineInputBorder(
                                                                  borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(10),
                                                                    topLeft: Radius.circular(10),
                                                                    bottomRight: Radius.circular(10),
                                                                    bottomLeft: Radius.circular(10),
                                                                  ),
                                                                  borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10),
                                                        Container(
                                                          // width: 200,
                                                          height: 40,
                                                          // color: white,
                                                          padding: EdgeInsets.only(left: 30.0 * pad, right: 30.0 * pad),
                                                          child: Container(
                                                            color: white,
                                                            child: TextFormField(
                                                              cursorColor: Colors.green,
                                                              decoration: InputDecoration(
                                                                fillColor: Colors.grey[200]!.withOpacity(0.5),
                                                                filled: true,
                                                                // prefixIcon:
                                                                //     const Icon(Icons.person, color: Colors.black),
                                                                // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                focusedBorder: const OutlineInputBorder(
                                                                  borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(10),
                                                                    topLeft: Radius.circular(10),
                                                                    bottomRight: Radius.circular(10),
                                                                    bottomLeft: Radius.circular(10),
                                                                  ),
                                                                  borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                                enabledBorder: const OutlineInputBorder(
                                                                  borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(10),
                                                                    topLeft: Radius.circular(10),
                                                                    bottomRight: Radius.circular(10),
                                                                    bottomLeft: Radius.circular(10),
                                                                  ),
                                                                  borderSide: BorderSide(
                                                                    width: 1,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10),
                                                        Expanded(
                                                          // flex: 3,
                                                          child: Align(
                                                            alignment: Alignment.center,
                                                            child: Container(
                                                              // height: 300,
                                                              padding:
                                                                  EdgeInsets.only(left: 30.0 * pad, right: 30.0 * pad),
                                                              color: white,
                                                              child: Center(
                                                                child: TextFormField(
                                                                  maxLines: 80,
                                                                  // maxLength: 13,
                                                                  cursorColor: Colors.green,
                                                                  decoration: InputDecoration(
                                                                    fillColor: Colors.grey[200]!.withOpacity(0.5),
                                                                    filled: true,
                                                                    // prefixIcon:
                                                                    //     const Icon(Icons.person, color: Colors.black),
                                                                    // suffixIcon: Icon(Icons.clear, color: Colors.black),
                                                                    focusedBorder: const OutlineInputBorder(
                                                                      borderRadius: BorderRadius.only(
                                                                        topRight: Radius.circular(10),
                                                                        topLeft: Radius.circular(10),
                                                                        bottomRight: Radius.circular(10),
                                                                        bottomLeft: Radius.circular(10),
                                                                      ),
                                                                      borderSide: BorderSide(
                                                                        width: 1,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                    enabledBorder: const OutlineInputBorder(
                                                                      borderRadius: BorderRadius.only(
                                                                        topRight: Radius.circular(10),
                                                                        topLeft: Radius.circular(10),
                                                                        bottomRight: Radius.circular(10),
                                                                        bottomLeft: Radius.circular(10),
                                                                      ),
                                                                      borderSide: BorderSide(
                                                                        width: 1,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10),
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(20.0),
                                                            child: Container(
                                                              // height: 40,
                                                              // width: 120,
                                                              decoration: const BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(8),
                                                                  topRight: Radius.circular(8),
                                                                  bottomLeft: Radius.circular(8),
                                                                  bottomRight: Radius.circular(8),
                                                                ),
                                                                color: Color.fromRGBO(154, 135, 129, 1),
                                                                // border: Border.all(
                                                                //     color: Color.fromARGB(255, 150, 148, 148), width: 2),
                                                              ),
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: 'Submit'.poppins(
                                                                color: white,
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 12 + 4 * pad,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10),
                                                      ],
                                                    )),
                                                Expanded(
                                                  flex: 1,
                                                  child: ClipPath(
                                                      child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.only(
                                                        topLeft: Radius.circular(0),
                                                        topRight: Radius.circular(20),
                                                        bottomLeft: Radius.circular(0),
                                                        bottomRight: Radius.circular(20),
                                                      ),
                                                      image: DecorationImage(
                                                        // image: AssetImage(
                                                        //   'assets/property_service/11.jpg',
                                                        // ),
                                                        image: NetworkImage(
                                                          '${ListWithUsModels[0].corver_img}',
                                                        ),

                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )),
                                                ),
                                              ],
                                            ))),
                                  ],
                                ),
                          const SizedBox(height: 34),
                          Align(
                            alignment: Alignment.center,
                            child: 'Our Service Fee'.poppins(
                              color: Color.fromRGBO(71, 69, 69, 1),
                              fontSize: 22 + 4 * pad,
                            ),
                          ),
                          const SizedBox(height: 34),
                          '${ListWithUsModels[0].content}'.poppins(
                            textAlign: TextAlign.center,
                            fontSize: 14 + 4 * pad,
                            fontWeight: FontWeight.w400,
                            height: 1.75,
                          ),
                        ]),
                  )),
                  const SizedBox(height: 34),
                  service(),
                  const SizedBox(height: 34),
                  BaseContainer(
                      child: Column(
                          crossAxisAlignment:
                              Metrics.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                          children: [
                        Align(
                          alignment: Alignment.center,
                          child: 'What we can do for you:'.poppins(
                            color: Color.fromRGBO(72, 72, 72, 1),
                            fontSize: 25 + 4 * pad,
                          ),
                        ),
                        const SizedBox(height: 34),
                        Center(
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            child: '${ListWithUsModels[0].content_sub1}'.poppins(
                              textAlign: TextAlign.center,
                              fontSize: 14 + 4 * pad,
                              fontWeight: FontWeight.w400,
                              height: 1.75,
                            ),
                          ),
                        ),
                        const SizedBox(height: 34),
                        Center(
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
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
                                          color: white.withOpacity(0.8),
                                          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Text(
                                        title,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            color: white,
                                            fontSize: 20,
                                            shadows: [
                                              Shadow(blurRadius: 2, color: Colors.black38, offset: Offset(2, 2))
                                            ]),
                                      )),
                                );
                              },
                            ),
                          ),
                        ),
                      ])),
                  const SizedBox(height: 90),
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

////---------------------------------------->
  Widget service() {
    List<String> imageUrls = packagemodels.map((data) => data.img.toString()).toList();
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));
    return Column(
      children: [
        const SizedBox(height: 80),
        SizedBox(
          height: 400 + 100 * pad,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (val) => setState(() => currentPage = val),
            itemCount: packagemodels.length,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              String trimmedData = packagemodels[index]
                  .description
                  .toString()
                  .substring(1, packagemodels[index].description.toString().length - 1);
              String trimmedData_sub = packagemodels[index]
                  .descriptionSub
                  .toString()
                  .substring(1, packagemodels[index].descriptionSub.toString().length - 1);

              // Split the string into a list
              List<String> description_List = trimmedData.split('],[');
              List<String> descriptionSub_List = trimmedData_sub.split('],[');
              return Padding(
                padding: EdgeInsets.only(left: 36 * pad, right: 36 * pad),
                child: AnimatedScale(
                    duration: const Duration(milliseconds: 240),
                    scale: currentPage == index ? 1 : 0.75,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        color:
                            (packagemodels[index].name.toString() == 'Free') ? Color.fromRGBO(86, 230, 165, 1) : white,
                        border: Border.all(color: Color.fromARGB(255, 216, 213, 213), width: 1),
                        // gradient:
                        //     (data_Service[index]['name'].toString() == 'Free')
                        //         ? LinearGradient(
                        //             colors: [
                        //               Color.fromRGBO(86, 230, 165, 1)
                        //                   .withOpacity(0.6),
                        //               Color.fromRGBO(86, 230, 165, 1)
                        //                   .withOpacity(0.8),
                        //               Color.fromRGBO(86, 230, 165, 1),
                        //             ],
                        //             begin: Alignment.topCenter,
                        //             end: Alignment.bottomCenter,
                        //           )
                        //         : null,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 180, 175, 175).withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: '${packagemodels[index].name}'.toString().poppins(
                                    fontWeight: FontWeight.w500,
                                    color: greenBg,
                                    fontSize: 25 + 4 * pad,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: '\$ ${packagemodels[index].pri}'.poppins(
                                color: greenBg,
                                fontWeight: FontWeight.w500,
                                fontSize: 25 + 4 * pad,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {},
                              child: Container(
                                height: 40,
                                // width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                  color: (packagemodels[index].name.toString() == 'Free') ? Colors.brown : null,
                                  border: Border.all(color: Color.fromARGB(255, 150, 148, 148), width: 2),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: 'Request a demo'.poppins(
                                  color: (packagemodels[index].name.toString() == 'Free') ? white : greenBg,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16 + 4 * pad,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          for (int index2 = 0; index2 < description_List.length; index2++)
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: '🟢 ${description_List[index2].toString()}'.poppins(
                                  color: greenBg,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16 + 4 * pad,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Divider(
                            color: Colors.grey,
                            height: 4.0,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          for (int index3 = 0; index3 < descriptionSub_List.length; index3++)
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: '+ ${descriptionSub_List[index3].toString()}'.poppins(
                                  color: greenBg,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16 + 4 * pad,
                                ),
                              ),
                            ),
                        ],
                      ),
                    )),
              );
            },
          ),
        ),
        const SizedBox(height: 34),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 300,
            child: ImageSliderController(
              currentPage: currentPage,
              images: imageUrls,
              prev: currentPage != 0
                  ? () {
                      _controller.animateToPage(
                        currentPage - 1,
                        duration: const Duration(milliseconds: 240),
                        curve: Curves.linear,
                      );
                    }
                  : null,
              next: (currentPage != imageUrls.length - 1)
                  ? () {
                      _controller.animateToPage(
                        currentPage + 1,
                        duration: const Duration(milliseconds: 240),
                        curve: Curves.linear,
                      );
                    }
                  : null,
              title: [],
            ),
          ),
        ),
      ],
    );
  }
}

/////------------------------------------------->
class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width * 0.3005100, size.height * 0.0046800);
    path.moveTo(size.width * 0.3005100, size.height * -0.0033000);
    path.lineTo(size.width * 0.9997000, size.height * -0.0063800);
    path.lineTo(size.width * 0.9998700, size.height * 0.9978200);
    path.lineTo(size.width * 0.1574300, size.height * 1.0058200);

    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(TrapeziumClipper oldClipper) => false;
}
