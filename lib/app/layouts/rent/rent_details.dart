import 'dart:convert';
import 'dart:developer';
// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:properties/app/widgets/base_container.dart';
import 'package:properties/app/with_us.dart';
import 'package:properties/core/core.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../Constant/Myconstant.dart';
import '../../../core/models/assetDetails_model.dart';
import '../../../core/models/asset_model.dart';
import '../../../core/models/img_assetAll_model.dart';
import '../../../core/models/places_type_model.dart';
import '../../../core/models/specialknow_model.dart';
import '../../../core/models/thingsknowType_model.dart';
import '../../../core/models/thingsknow_model.dart';
import '../about_us/image_clider_controller.dart';

import '../footer/footer.dart';
import '../header/header_rent.dart';

class RentDetails extends ConsumerStatefulWidget {
  final ser_asset;
  const RentDetails(this.ser_asset, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RentDetailsState();
}

class _RentDetailsState extends ConsumerState<RentDetails> {
  int limit = 2; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
  int index_imgPath = 0;
  int index_asset = 0;
  var selectsdate;
  var selectldate;
  bool rangedate = false;

///////----------------------------------------------->
  late PageController _controller;
  int currentPage = 1;
///////----------------------------------------------->
  late ScrollController _baseController;

  final GlobalKey _headerKey = GlobalKey();
  ///////----------------------------------------------->
  List<placestype_model> placestype_models = [];
  List<assetdetails_model> assetmodels = [];
  List<imgassetAllmodel> imgassetAllmodels = [];
  List<placestype_model> place_list = [];
  List<ThingsknowType_model> ThingsknowType_models = [];
  List<Thingsknow_model> Thingsknow_models = [];
  List<Specialknow_model> specialknow_models = [];
  List<DateTime> disabledDates = [];
///////----------------------------------------------->
  String? corver_Img;

///////----------------------------------------------->
  @override
  void initState() {
    read_GC_PlacesType();
    read_GC_ThingsknowType();
    read_GC_Asset_Details();
    read_GC_Specialknow();
    read_GC_Thingsknow();

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
  Future<Null> read_GC_PlacesType() async {
    if (placestype_models.length != 0) {
      placestype_models.clear();
    }

    String url = '${MyConstant().domain}/GC_Places_Type.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        placestype_model placestype_modelss = placestype_model.fromJson(map);

        setState(() {
          placestype_models.add(placestype_modelss);
        });
      }
    } catch (e) {}
  }

///////----------------------------------------------->
  Future<Null> read_GC_ThingsknowType() async {
    if (ThingsknowType_models.length != 0) {
      ThingsknowType_models.clear();
    }

    String url = '${MyConstant().domain}/GC_Thingsknow_Type.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        ThingsknowType_model ThingsknowType_modelss = ThingsknowType_model.fromJson(map);

        setState(() {
          ThingsknowType_models.add(ThingsknowType_modelss);
        });
      }
    } catch (e) {}
  }
  ///////----------------------------------------------->(ข้อมูลอื่นๆ)

  Future<Null> read_GC_Asset_Details() async {
    String? places;
    var ser_asset = widget.ser_asset.toString();

    if (assetmodels.length != 0) {
      assetmodels.clear();
    }

    String url = '${MyConstant().domain}/GC_Rent_AssetDetails.php?isAdd=true&serasset=$ser_asset';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        assetdetails_model assetmodelss = assetdetails_model.fromJson(map);

        setState(() {
          assetmodels.add(assetmodelss);
          places = assetmodelss.place.toString().trim();
          corver_Img = assetmodelss.corver_img.toString().trim();
        });
      }

      await read_GC_AssetImg_Details();
      await check_add_places(places);
    } catch (e) {}
  }

  Future<Null> check_add_places(places) async {
    setState(() {
      place_list.clear();
    });
    if (places != null || places.toString() != '') {
      List<int> dataList = places.toString().split(',').map(int.parse).toList();

      if (dataList.length != 0) {
        for (int index_add = 0; index_add < dataList.length; index_add++) {
          Map<String, dynamic> map = Map();
          map['ser'] =
              '${placestype_models.where((model) => model.ser == '${dataList[index_add]}').map((model) => model.ser).join(', ')}';
          map['datex'] =
              '${placestype_models.where((model) => model.ser == '${dataList[index_add]}').map((model) => model.datex).join(', ')}';
          map['timex'] =
              '${placestype_models.where((model) => model.ser == '${dataList[index_add]}').map((model) => model.timex).join(', ')}';
          map['user'] =
              '${placestype_models.where((model) => model.ser == '${dataList[index_add]}').map((model) => model.user).join(', ')}';
          map['name'] =
              '${placestype_models.where((model) => model.ser == '${dataList[index_add]}').map((model) => model.name).join(', ')}';
          map['icon'] =
              '${placestype_models.where((model) => model.ser == '${dataList[index_add]}').map((model) => model.icon).join(', ')}';
          map['st'] =
              '${placestype_models.where((model) => model.ser == '${dataList[index_add]}').map((model) => model.st).join(', ')}';
          map['dataUpdate'] =
              '${placestype_models.where((model) => model.ser == '${dataList[index_add]}').map((model) => model.dataUpdate).join(', ')}';

          placestype_model placestypemodelss = placestype_model.fromJson(map);

          setState(() {
            place_list.add(placestypemodelss);
          });
        }
      }
    }

    /////////------------------>
  }

  ///////----------------------------------------------->(รูปอื่นๆ) about_us
  Future<Null> read_GC_AssetImg_Details() async {
    var ser_asset = widget.ser_asset.toString();
    if (imgassetAllmodels.length != 0) {
      imgassetAllmodels.clear();
    }

    String url = '${MyConstant().domain}/GC_Asset_Img.php?isAdd=true&serasset=$ser_asset';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        imgassetAllmodel imgassetAllmodelss = imgassetAllmodel.fromJson(map);

        setState(() {
          imgassetAllmodels.add(imgassetAllmodelss);
        });
      }
      if (corver_Img != null) {
        Map<String, dynamic> map = Map();
        map['img'] = '${corver_Img}';
        imgassetAllmodel imgassetAllmodelss = imgassetAllmodel.fromJson(map);

        setState(() {
          imgassetAllmodels.add(imgassetAllmodelss);
        });
      }
    } catch (e) {}
  }

///////----------------------------------------------->
  Future<Null> read_GC_Thingsknow() async {
    var ser_asset = widget.ser_asset.toString();
    if (Thingsknow_models.length != 0) {
      Thingsknow_models.clear();
    }

    String url = '${MyConstant().domain}/GC_Asset_Thingsknow.php?isAdd=true&serasset=$ser_asset';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        Thingsknow_model Thingsknow_modelss = Thingsknow_model.fromJson(map);

        setState(() {
          Thingsknow_models.add(Thingsknow_modelss);
        });
      }
    } catch (e) {}
  }

///////----------------------------------------------->
  Future<Null> read_GC_Specialknow() async {
    var ser_asset = widget.ser_asset.toString();
    if (specialknow_models.length != 0) {
      specialknow_models.clear();
    }

    String url = '${MyConstant().domain}/GC_Asset_SpecialKnow.php?isAdd=true&serasset=$ser_asset';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        Specialknow_model specialknow_modelss = Specialknow_model.fromJson(map);

        setState(() {
          specialknow_models.add(specialknow_modelss);
        });
      }
    } catch (e) {}
  }

  String main_img = '';
///////----------------------------------------------->
  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));

    final isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);
    final pad1 = isBigScreen ? 0.0 : normalize(min: 576, max: 976, data: Metrics.width(context));
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) / _crossAxisCount;
    var cellHeight = 60;
    var _aspectRatio = _width / cellHeight;
    double plus =
        Metrics.isDesktop(context) ? 0 : (0.5 * (1 - normalize(min: 976, max: 1440, data: Metrics.width(context))));
    _controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.25 + plus,
    );
    final sdate;
    final ldate;
    if (selectsdate != null) {
      sdate = DateFormat('d MMMM yyyy', 'en_US').format(DateTime.parse('$selectsdate'));
    } else {
      sdate = DateFormat('d MMMM yyyy', 'en_US').format(DateTime.parse('${assetmodels[0].s_datex}'));
    }
    if (selectldate != null) {
      ldate = DateFormat('d MMMM yyyy', 'en_US').format(DateTime.parse('$selectldate'));
    } else {
      ldate = DateFormat('d MMMM yyyy', 'en_US').format(DateTime.parse('${assetmodels[0].l_datex}'));
    }
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
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: '${assetmodels[0].name_en} - ${assetmodels[0].name_th}'.poppins(
                            color: black,
                            fontSize: 25 + 4 * pad,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: '${assetmodels[0].addr}'.poppinscenter(
                            color: Color.fromRGBO(69, 69, 69, 1),
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            textAlign: TextAlign.center,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 34),

                  BaseContainer(
                      child: Column(
                          crossAxisAlignment:
                              Metrics.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                          children: [
                        // Container(
                        //   height: 350 + 100 * pad,
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: Container(
                        //             decoration: BoxDecoration(
                        //               borderRadius: const BorderRadius.only(
                        //                 topLeft: Radius.circular(20),
                        //                 topRight: Radius.circular(20),
                        //                 bottomLeft: Radius.circular(20),
                        //                 bottomRight: Radius.circular(20),
                        //               ),
                        //               image: DecorationImage(
                        //                 image: NetworkImage(
                        //                   decorativeItems[index_imgPath].imgPath,
                        //                 ),
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //             child: (Metrics.isMobile(context) ||
                        //                     Metrics.isCompact(context) ||
                        //                     Metrics.isTablet(context))
                        //                 ? Column(
                        //                     mainAxisAlignment: MainAxisAlignment.end,
                        //                     children: [
                        //                       Container(
                        //                         width: Metrics.width(context),
                        //                         height: 100,
                        //                         decoration: BoxDecoration(
                        //                           color: white.withOpacity(0.3),
                        //                           borderRadius: const BorderRadius.only(
                        //                             topLeft: Radius.circular(0),
                        //                             topRight: Radius.circular(0),
                        //                             bottomLeft: Radius.circular(0),
                        //                             bottomRight: Radius.circular(0),
                        //                           ),
                        //                         ),
                        //                         padding: const EdgeInsets.all(2.0),
                        //                         child: SingleChildScrollView(
                        //                           scrollDirection: Axis.horizontal,
                        //                           child: Row(
                        //                             children: [
                        //                               for (int index = 0; index < 7; index++)
                        //                                 Padding(
                        //                                   padding: const EdgeInsets.all(8.0),
                        //                                   child: InkWell(
                        //                                     onTap: () {
                        //                                       setState(() {
                        //                                         index_imgPath = index;
                        //                                       });
                        //                                     },
                        //                                     child: AspectRatio(
                        //                                       aspectRatio: 265 / 170,
                        //                                       child: ClipRRect(
                        //                                         borderRadius: BorderRadius.circular(20),
                        //                                         child: Image.network(
                        //                                           decorativeItems[index].imgPath,
                        //                                           fit: BoxFit.cover,
                        //                                         ),
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                 ),
                        //                             ],
                        //                           ),
                        //                         ),
                        //                       )
                        //                     ],
                        //                   )
                        //                 : null),
                        //       ),
                        //       (Metrics.isMobile(context) || Metrics.isCompact(context) || Metrics.isTablet(context))
                        //           ? SizedBox()
                        //           : Expanded(
                        //               child: Container(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: GridView.builder(
                        //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //                     crossAxisCount: Metrics.isMobile(context)
                        //                         ? 1
                        //                         : Metrics.isCompact(context)
                        //                             ? 1
                        //                             : Metrics.isTablet(context)
                        //                                 ? 2
                        //                                 : 3,
                        //                     childAspectRatio: 285 / 220,
                        //                     crossAxisSpacing: 24,
                        //                     mainAxisSpacing: 0,
                        //                   ),
                        //                   shrinkWrap: true,
                        //                   // physics:
                        //                   //     const NeverScrollableScrollPhysics(),
                        //                   itemCount: 7,
                        //                   itemBuilder: (context, index) {
                        //                     final gridItem = decorativeItems[index];

                        //                     return Center(
                        //                       child: InkWell(
                        //                         onTap: () {
                        //                           setState(() {
                        //                             index_imgPath = index;
                        //                           });
                        //                           // Navigator.push(
                        //                           //   context,
                        //                           //   MaterialPageRoute(
                        //                           //     builder: (context) => AssetAll(),
                        //                           //   ),
                        //                           // );
                        //                           // Navigator.pushReplacement(
                        //                           //   context,
                        //                           //   MaterialPageRoute(
                        //                           //     builder: (context) => Rent(),
                        //                           //   ),
                        //                           // );
                        //                         },
                        //                         child: Container(
                        //                           margin: EdgeInsets.only(bottom: 12 + 12 * pad),
                        //                           decoration: BoxDecoration(
                        //                             color: white,
                        //                             borderRadius: const BorderRadius.only(
                        //                               topLeft: Radius.circular(20),
                        //                               topRight: Radius.circular(20),
                        //                               bottomLeft: Radius.circular(20),
                        //                               bottomRight: Radius.circular(20),
                        //                             ),
                        //                             boxShadow: [
                        //                               BoxShadow(
                        //                                 color: Colors.grey.withOpacity(0.25),
                        //                                 offset: const Offset(0, 4),
                        //                                 blurRadius: 4,
                        //                               ),
                        //                             ],
                        //                           ),
                        //                           child: Column(
                        //                             crossAxisAlignment: CrossAxisAlignment.stretch,
                        //                             children: [
                        //                               Stack(
                        //                                 children: [
                        //                                   AspectRatio(
                        //                                     aspectRatio: 265 / 170,
                        //                                     child: ClipRRect(
                        //                                       borderRadius: BorderRadius.circular(20),
                        //                                       child: Image.network(
                        //                                         gridItem.imgPath,
                        //                                         fit: BoxFit.cover,
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                   Positioned(
                        //                                     bottom: 10,
                        //                                     left: 20,
                        //                                     child: Container(
                        //                                       // width: 150,
                        //                                       // height: 70,
                        //                                       decoration: BoxDecoration(
                        //                                         color: white,
                        //                                         borderRadius: const BorderRadius.only(
                        //                                           topLeft: Radius.circular(15),
                        //                                           topRight: Radius.circular(15),
                        //                                           bottomLeft: Radius.circular(15),
                        //                                           bottomRight: Radius.circular(15),
                        //                                         ),
                        //                                         boxShadow: [
                        //                                           BoxShadow(
                        //                                             color: Colors.grey.withOpacity(0.25),
                        //                                             offset: const Offset(0, 4),
                        //                                             blurRadius: 4,
                        //                                           ),
                        //                                         ],
                        //                                       ),
                        //                                       padding: const EdgeInsets.all(4),
                        //                                       child: Center(
                        //                                         child: ' Guest favourite'.poppins(
                        //                                           color: greenBg,
                        //                                           fontSize: 15 + 4 * pad,
                        //                                         ),
                        //                                       ),
                        //                                     ),
                        //                                   ),
                        //                                 ],
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     );
                        //                   },
                        //                 ),
                        //               ),
                        //             )
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: FractionallySizedBox(
                                widthFactor: 0.9,
                                child: Container(
                                  width: double.infinity,
                                  height: Metrics.isMobile(context) ? 200 : 400,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                  child: AspectRatio(
                                    aspectRatio: Metrics.isMobile(context) ? 8 / 6 : 6 / 2,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          // child: Container(),
                                          child: Container(
                                            alignment: Alignment.topRight,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      main_img == '' ? '${MyConstant().domain}img/${assetmodels[0].corver_img}' : '$main_img',
                                                    ))),
                                            child: main_img == ''
                                                ? Container()
                                                : InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        main_img = '';
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_rounded,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                          ),
                                          // Image.network(
                                          //   main_img == '' ? '${assetmodels[0].corver_img}' : main_img,
                                          //   // 'https://s3-alpha-sig.figma.com/img/33e7/8912/bbfb42ca5051f5492bcbda4a216dccc6?Expires=1716768000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=hddtucuDPySfPy9TYtKRK-kcquj4x-19PrT84oV8tG84ldiFB3wtiqQdl7voK7S~vvLzbZavsvfyQXI5pg1e-9rzfMdlDcqgF17hkx59LGstr~LX2LwQfLuM-~5ZVZlmPjjMTddvMPGwIf-FMv7Cmck9GfCZuJsSUlnFqVONYngvyl85BS-it8MJwknzLeKxa10QmTsl6j9IbPr~45NsfHmntsSRJFRal6KzKRnZZVXcC8EgNXwGWMBGzsNJUoGcmilKNJATJjds0z5MsSEV285RJqMJb1eApzgURLX0HwoYxvb0HT0buqRFepSKADJmlOhRLyLXA19XqjhEuhOsew__',
                                          //   fit: BoxFit.cover,
                                          //   alignment: Alignment.center,
                                          // ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          flex: Metrics.isMobile(context) ? 1 : 2,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: GridView.builder(
                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                  // crossAxisCount: Metrics.isMobile(context)
                                                  //     ? 1
                                                  //     : Metrics.isCompact(context)
                                                  //         ? 2
                                                  //         : Metrics.isTablet(context)
                                                  //             ? 3
                                                  //             : 4,
                                                  crossAxisCount: Metrics.isMobile(context) ? 1 : 2,
                                                  // childAspectRatio: 1 / (1),
                                                  crossAxisSpacing: 5,
                                                  mainAxisSpacing: 5,
                                                ),
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: imgassetAllmodels.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                      onTap: () async {
                                                        setState(() {
                                                          main_img = '${MyConstant().domain}img/${imgassetAllmodels[index].img}';
                                                        });
                                                      },
                                                      child: Image(
                                                        image: NetworkImage('${MyConstant().domain}img/${imgassetAllmodels[index].img}'),
                                                        fit: BoxFit.cover,
                                                      ));
                                                  // }
                                                }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            if (Metrics.isMobile(context) || Metrics.isTablet(context) || Metrics.isCompact(context))
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.25),
                                      offset: const Offset(0, 4),
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          '15,000 thb'.poppins(color: black, fontWeight: FontWeight.w600, fontSize: 20),
                                          '/ month'.poppins(color: black, fontWeight: FontWeight.w500, fontSize: 18),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey, width: 1)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return Center(
                                                            child: FractionallySizedBox(
                                                                widthFactor: Metrics.isMobile(context) ? 1 : 0.5,
                                                                child: selectdate('s')),
                                                          );
                                                        });
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.centerLeft,
                                                    padding: EdgeInsets.all(8.0),
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                      right: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                      bottom: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    )),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        'CHECK-IN'.toUpperCase().poppins(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600,
                                                            textAlign: TextAlign.start),
                                                        Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                            child: '${sdate}'.poppins(
                                                              color: Color.fromRGBO(107, 114, 128, 1),
                                                              textAlign: TextAlign.start,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      rangedate = true;
                                                    });
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return Center(
                                                            child: FractionallySizedBox(
                                                                widthFactor: Metrics.isMobile(context) ? 1 : 0.5,
                                                                child: selectdate('l')),
                                                          );
                                                        });
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.centerLeft,
                                                    padding: EdgeInsets.all(8.0),
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                      bottom: BorderSide(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                    )),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        'CHECKOUT'.toUpperCase().poppins(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600,
                                                            textAlign: TextAlign.start),
                                                        Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                            child: '${ldate}'.poppins(
                                                              color: Color.fromRGBO(107, 114, 128, 1),
                                                              textAlign: TextAlign.start,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                'GUESTS'.toUpperCase().poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    textAlign: TextAlign.start),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                  child: '2 guests'.poppins(
                                                      color: Color.fromRGBO(107, 114, 128, 1),
                                                      textAlign: TextAlign.start),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.symmetric(vertical: 16),
                                        padding: EdgeInsets.all(16),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Color.fromRGBO(222, 49, 81, 1)),
                                        child: 'Send us an inquiry'.poppins(
                                            color: white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: 'You won’t be charged yet'.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Color.fromRGBO(107, 114, 128, 1)),
                                    ),
                                    Container(
                                      height: 2,
                                      color: Color.fromRGBO(229, 231, 235, 1),
                                      margin: EdgeInsets.all(8.0),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          'Total'.poppins(
                                              textAlign: TextAlign.start, fontSize: 20, fontWeight: FontWeight.w600),
                                          '\$701'.poppins(
                                              textAlign: TextAlign.end, fontSize: 20, fontWeight: FontWeight.w600),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            Center(
                              child: FractionallySizedBox(
                                widthFactor: 0.9,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 5,
                                        child: FractionallySizedBox(
                                          widthFactor: 0.9,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              'Entire rental unit hosted by Ghazal'.poppins(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600,
                                                  textAlign: TextAlign.start),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: '${assetmodels[0].guests} guests'
                                                        .poppins(fontWeight: FontWeight.w500, fontSize: 10),
                                                  ),
                                                  Icon(
                                                    Icons.circle,
                                                    size: 2,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: '${assetmodels[0].bedroom} bedroom'
                                                        .poppins(fontWeight: FontWeight.w500, fontSize: 10),
                                                  ),
                                                  Icon(
                                                    Icons.circle,
                                                    size: 2,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: '${assetmodels[0].bed} bed'
                                                        .poppins(fontWeight: FontWeight.w500, fontSize: 10),
                                                  ),
                                                  Icon(
                                                    Icons.circle,
                                                    size: 2,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: '${assetmodels[0].bathroom} bath'
                                                        .poppins(fontWeight: FontWeight.w500, fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 20),
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              Column(
                                                children: [
                                                  for (int index_special = 0;
                                                      index_special < specialknow_models.length;
                                                      index_special++)
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(16.0),
                                                            child: Icon(
                                                              IconData(
                                                                  int.parse(
                                                                      '${specialknow_models[index_special].icon}'),
                                                                  fontFamily: 'MaterialIcons'),
                                                              color: black,
                                                              size: 30,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                '${specialknow_models[index_special].name}'.poppins(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w600,
                                                                    textAlign: TextAlign.start),
                                                                Padding(
                                                                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                                  child: '${specialknow_models[index_special].content}'
                                                                      .poppins(
                                                                    color: Color.fromRGBO(107, 114, 128, 1),
                                                                    textAlign: TextAlign.start,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              // Padding(
                                              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              //   child: Row(
                                              //     crossAxisAlignment: CrossAxisAlignment.center,
                                              //     mainAxisAlignment: MainAxisAlignment.start,
                                              //     children: [
                                              //       Padding(
                                              //         padding: const EdgeInsets.all(16.0),
                                              //         child: Icon(
                                              //           Icons.auto_awesome_outlined,
                                              //           color: black,
                                              //           size: 30,
                                              //         ),
                                              //       ),
                                              //       Expanded(
                                              //         child: Column(
                                              //           crossAxisAlignment: CrossAxisAlignment.start,
                                              //           children: [
                                              //             'Enhanced Clean'.poppins(
                                              //                 fontSize: 16,
                                              //                 fontWeight: FontWeight.w600,
                                              //                 textAlign: TextAlign.start),
                                              //             Padding(
                                              //               padding: const EdgeInsets.symmetric(vertical: 6.0),
                                              //               child:
                                              //                   'This Host committed to Airbnb’s 5-step enhanced cleaning process. Show more'
                                              //                       .poppins(
                                              //                 color: Color.fromRGBO(107, 114, 128, 1),
                                              //                 textAlign: TextAlign.start,
                                              //               ),
                                              //             )
                                              //           ],
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              // Padding(
                                              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              //   child: Row(
                                              //     crossAxisAlignment: CrossAxisAlignment.center,
                                              //     mainAxisAlignment: MainAxisAlignment.start,
                                              //     children: [
                                              //       Padding(
                                              //         padding: const EdgeInsets.all(16.0),
                                              //         child: Icon(
                                              //           Icons.door_back_door_outlined,
                                              //           color: black,
                                              //           size: 30,
                                              //         ),
                                              //       ),
                                              //       Expanded(
                                              //         child: Column(
                                              //           crossAxisAlignment: CrossAxisAlignment.start,
                                              //           children: [
                                              //             'Self check-in'.poppins(
                                              //                 fontSize: 16,
                                              //                 fontWeight: FontWeight.w600,
                                              //                 textAlign: TextAlign.start),
                                              //             Padding(
                                              //               padding: const EdgeInsets.symmetric(vertical: 6.0),
                                              //               child: 'Check yourself in with the keypad.'.poppins(
                                              //                 color: Color.fromRGBO(107, 114, 128, 1),
                                              //                 textAlign: TextAlign.start,
                                              //               ),
                                              //             )
                                              //           ],
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 20),
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              '${assetmodels[0].content}'
                                                  .poppins(textAlign: TextAlign.center, fontWeight: FontWeight.w400),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                child: Row(
                                                  children: [
                                                    'Show more'.poppins(decoration: TextDecoration.underline),
                                                    Icon(Icons.keyboard_arrow_right)
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 20),
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 20),
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                child: 'Enhanced Clean'.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    textAlign: TextAlign.start),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      for (int index = 0; index < place_list.length; index++)
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Icon(IconData(
                                                                  int.parse('${place_list[index].icon}'),
                                                                  fontFamily: 'MaterialIcons')),
                                                            ),
                                                            '${place_list[index].name}'.poppins(fontSize: 12)
                                                          ],
                                                        ),
                                                      // Row(
                                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                                      //   children: [
                                                      //     Padding(
                                                      //       padding: const EdgeInsets.all(8.0),
                                                      //       child: Icon(Icons.grass_sharp),
                                                      //     ),
                                                      //     'Garden view'.poppins(fontSize: 12)
                                                      //   ],
                                                      // ),
                                                      // Row(
                                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                                      //   children: [
                                                      //     Padding(
                                                      //       padding: const EdgeInsets.all(8.0),
                                                      //       child: Icon(Icons.wifi),
                                                      //     ),
                                                      //     'Wifi'.poppins(fontSize: 12)
                                                      //   ],
                                                      // ),
                                                      // Row(
                                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                                      //   children: [
                                                      //     Padding(
                                                      //       padding: const EdgeInsets.all(8.0),
                                                      //       child: Icon(Icons.adjust_sharp),
                                                      //     ),
                                                      //     'Free washer - in building'.poppins(fontSize: 12)
                                                      //   ],
                                                      // ),
                                                      // Row(
                                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                                      //   children: [
                                                      //     Padding(
                                                      //       padding: const EdgeInsets.all(8.0),
                                                      //       child: Icon(Icons.air),
                                                      //     ),
                                                      //     'Central air conditioning'.poppins(fontSize: 12)
                                                      //   ],
                                                      // ),
                                                      // Row(
                                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                                      //   children: [
                                                      //     Padding(
                                                      //       padding: const EdgeInsets.all(8.0),
                                                      //       child: Icon(Icons.kitchen_outlined),
                                                      //     ),
                                                      //     'Refrigerator'.poppins(fontSize: 12)
                                                      //   ],
                                                      // ),
                                                    ],
                                                  )),
                                                  // Expanded(
                                                  //     child: Column(
                                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  //   children: [
                                                  //     Row(
                                                  //       mainAxisAlignment: MainAxisAlignment.start,
                                                  //       children: [
                                                  //         Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Icon(Icons.microwave_rounded),
                                                  //         ),
                                                  //         'Kitchen'.poppins(fontSize: 12)
                                                  //       ],
                                                  //     ),
                                                  //     Row(
                                                  //       mainAxisAlignment: MainAxisAlignment.start,
                                                  //       children: [
                                                  //         Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Icon(Icons.wifi),
                                                  //         ),
                                                  //         'Wifi'.poppins(fontSize: 12)
                                                  //       ],
                                                  //     ),
                                                  //     Row(
                                                  //       mainAxisAlignment: MainAxisAlignment.start,
                                                  //       children: [
                                                  //         Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Icon(Icons.pets),
                                                  //         ),
                                                  //         'Pets allowed'.poppins(fontSize: 12)
                                                  //       ],
                                                  //     ),
                                                  //     Row(
                                                  //       mainAxisAlignment: MainAxisAlignment.start,
                                                  //       children: [
                                                  //         Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Icon(Icons.local_fire_department),
                                                  //         ),
                                                  //         'Dryer'.poppins(fontSize: 12)
                                                  //       ],
                                                  //     ),
                                                  //     Row(
                                                  //       mainAxisAlignment: MainAxisAlignment.start,
                                                  //       children: [
                                                  //         Padding(
                                                  //           padding: const EdgeInsets.all(8.0),
                                                  //           child: Icon(Icons.pedal_bike),
                                                  //         ),
                                                  //         'Bicycles'.poppins(fontSize: 12)
                                                  //       ],
                                                  //     ),
                                                  //   ],
                                                  // ))
                                                ],
                                              ),
                                              // InkWell(
                                              //   mouseCursor: SystemMouseCursors.click,
                                              //   child: Container(
                                              //     margin: EdgeInsets.symmetric(vertical: 16.0),
                                              //     padding: EdgeInsets.all(10.0),
                                              //     decoration: BoxDecoration(
                                              //         border: Border.all(width: 1, color: black),
                                              //         borderRadius: BorderRadius.circular(8)),
                                              //     child: 'Show all 37 amenities'
                                              //         .poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                              //   ),
                                              // ),
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 20),
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        )),
                                    if (Metrics.isDesktop(context))
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.25),
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 20,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      '15,000 thb'.poppins(
                                                          color: black, fontWeight: FontWeight.w600, fontSize: 20),
                                                      '/ month'.poppins(
                                                          color: black, fontWeight: FontWeight.w500, fontSize: 18),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(color: Colors.grey, width: 1)),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return Center(
                                                                        child: FractionallySizedBox(
                                                                            widthFactor:
                                                                                Metrics.isMobile(context) ? 1 : 0.5,
                                                                            child: selectdate('s')),
                                                                      );
                                                                    });
                                                              },
                                                              child: Container(
                                                                alignment: Alignment.centerLeft,
                                                                padding: EdgeInsets.all(8.0),
                                                                decoration: BoxDecoration(
                                                                    border: Border(
                                                                  right: BorderSide(
                                                                    width: 1,
                                                                    color: Colors.grey,
                                                                  ),
                                                                  bottom: BorderSide(
                                                                    width: 1,
                                                                    color: Colors.grey,
                                                                  ),
                                                                )),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    'CHECK-IN'.toUpperCase().poppins(
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w600,
                                                                        textAlign: TextAlign.start),
                                                                    Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(vertical: 6.0),
                                                                        child: '${sdate}'.poppins(
                                                                          color: Color.fromRGBO(107, 114, 128, 1),
                                                                          textAlign: TextAlign.start,
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  rangedate = true;
                                                                });
                                                                showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return Center(
                                                                        child: FractionallySizedBox(
                                                                            widthFactor:
                                                                                Metrics.isMobile(context) ? 1 : 0.5,
                                                                            child: selectdate('l')),
                                                                      );
                                                                    });
                                                              },
                                                              child: Container(
                                                                alignment: Alignment.centerLeft,
                                                                padding: EdgeInsets.all(8.0),
                                                                decoration: BoxDecoration(
                                                                    border: Border(
                                                                  bottom: BorderSide(
                                                                    width: 1,
                                                                    color: Colors.grey,
                                                                  ),
                                                                )),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    'CHECKOUT'.toUpperCase().poppins(
                                                                        fontSize: 12,
                                                                        fontWeight: FontWeight.w600,
                                                                        textAlign: TextAlign.start),
                                                                    Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(vertical: 6.0),
                                                                        child: '${ldate}'.poppins(
                                                                          color: Color.fromRGBO(107, 114, 128, 1),
                                                                          textAlign: TextAlign.start,
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        alignment: Alignment.centerLeft,
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            'GUESTS'.toUpperCase().poppins(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w600,
                                                                textAlign: TextAlign.start),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                                                              child: '2 guests'.poppins(
                                                                  color: Color.fromRGBO(107, 114, 128, 1),
                                                                  textAlign: TextAlign.start),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    width: double.infinity,
                                                    margin: EdgeInsets.symmetric(vertical: 16),
                                                    padding: EdgeInsets.all(16),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Color.fromRGBO(222, 49, 81, 1)),
                                                    child: 'Send us an inquiry'.poppins(
                                                        color: white,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 16,
                                                        textAlign: TextAlign.center),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: 'You won’t be charged yet'.poppins(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16,
                                                      color: Color.fromRGBO(107, 114, 128, 1)),
                                                ),
                                                Container(
                                                  height: 2,
                                                  color: Color.fromRGBO(229, 231, 235, 1),
                                                  margin: EdgeInsets.all(8.0),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      'Total'.poppins(
                                                          textAlign: TextAlign.start,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w600),
                                                      '\$701'.poppins(
                                                          textAlign: TextAlign.end,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w600),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                  ],
                                ),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Container(
                            //         child: Column(
                            //           children: [
                            //             const SizedBox(height: 80),
                            //             Align(
                            //               alignment: Alignment.center,
                            //               child: 'Entire rental unit hosted by Ghazal'.poppins(
                            //                 color: brown,
                            //                 fontSize: 25 + 4 * pad,
                            //               ),
                            //             ),
                            //             Padding(
                            //               padding: const EdgeInsets.all(8.0),
                            //               child: Align(
                            //                 alignment: Alignment.center,
                            //                 child:
                            //                     'Location address: 22 Moo 3 Tumbon Changpuak Amphor Muang Chiang Mai 50300'
                            //                         .poppinscenter(
                            //                   color: const Color(0xff896e57),
                            //                   fontWeight: FontWeight.bold,
                            //                   height: 1.5,
                            //                   letterSpacing: 1,
                            //                 ),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //     Container(
                            //       width: 324,
                            //       height: 214,
                            //       decoration: BoxDecoration(
                            //         color: white,
                            //         borderRadius: const BorderRadius.only(
                            //           topLeft: Radius.circular(20),
                            //           topRight: Radius.circular(20),
                            //           bottomLeft: Radius.circular(20),
                            //           bottomRight: Radius.circular(20),
                            //         ),
                            //         boxShadow: [
                            //           BoxShadow(
                            //             color: Colors.grey.withOpacity(0.25),
                            //             offset: const Offset(0, 4),
                            //             blurRadius: 4,
                            //           ),
                            //         ],
                            //       ),
                            //       padding: const EdgeInsets.all(4),
                            //       child: Column(
                            //         children: [
                            //           Row(
                            //             children: [
                            //               Expanded(
                            //                 child: Container(
                            //                   height: 70,
                            //                   decoration: const BoxDecoration(
                            //                     border: Border(
                            //                       bottom: BorderSide(
                            //                         color: Color(0xffdbdbd0),
                            //                         width: 2,
                            //                       ),
                            //                       top: BorderSide(
                            //                         color: Color(0xffdbdbd0),
                            //                         width: 2,
                            //                       ),
                            //                       left: BorderSide(
                            //                         color: Color(0xffdbdbd0),
                            //                         width: 2,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                   child: Center(
                            //                     child: 'Naina Asset'.msMadi(
                            //                       color: orange,
                            //                       fontSize: 36,
                            //                       height: 1.5,
                            //                       fontWeight: FontWeight.w600,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //               Container(
                            //                 width: 96,
                            //                 height: 70,
                            //                 decoration: const BoxDecoration(
                            //                   border: Border(
                            //                     bottom: BorderSide(
                            //                       color: Color(0xffdbdbd0),
                            //                       width: 2,
                            //                     ),
                            //                     top: BorderSide(
                            //                       color: Color(0xffdbdbd0),
                            //                       width: 2,
                            //                     ),
                            //                     left: BorderSide(
                            //                       color: Color(0xffdbdbd0),
                            //                       width: 2,
                            //                     ),
                            //                     right: BorderSide(
                            //                       color: Color(0xffdbdbd0),
                            //                       width: 2,
                            //                     ),
                            //                   ),
                            //                 ),
                            //                 child: Center(
                            //                   child: Column(
                            //                     mainAxisAlignment: MainAxisAlignment.center,
                            //                     children: [
                            //                       'FROM'.poppins(
                            //                         color: Colors.grey,
                            //                         fontWeight: FontWeight.w600,
                            //                         fontSize: 16,
                            //                         letterSpacing: 1,
                            //                         height: 1.25,
                            //                       ),
                            //                       '2024'.poppins(
                            //                         fontWeight: FontWeight.bold,
                            //                         fontSize: 24,
                            //                         letterSpacing: 0.5,
                            //                         height: 1.25,
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //           Expanded(
                            //             child: Row(
                            //               children: [
                            //                 Expanded(
                            //                   child: Container(
                            //                     decoration: const BoxDecoration(
                            //                       border: Border(
                            //                         bottom: BorderSide(
                            //                           color: Color(0xffdbdbd0),
                            //                           width: 2,
                            //                         ),
                            //                         left: BorderSide(
                            //                           color: Color(0xffdbdbd0),
                            //                           width: 2,
                            //                         ),
                            //                         right: BorderSide(
                            //                           color: Color(0xffdbdbd0),
                            //                           width: 2,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                     child: Center(
                            //                       child: Padding(
                            //                         padding: const EdgeInsets.all(10),
                            //                         child: Column(
                            //                           children: [
                            //                             'FROM'.poppins(
                            //                               color: Colors.grey,
                            //                               fontWeight: FontWeight.w600,
                            //                               fontSize: 16,
                            //                               letterSpacing: 1,
                            //                               height: 1.25,
                            //                             ),
                            //                             '2024'.poppins(
                            //                               fontWeight: FontWeight.bold,
                            //                               fontSize: 24,
                            //                               letterSpacing: 0.5,
                            //                               height: 1.25,
                            //                             ),
                            //                           ],
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(height: 34),
                            // const SizedBox(height: 1),
                            // const Divider(),
                            // const SizedBox(height: 1),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Align(
                            //     alignment: Alignment.center,
                            //     child:
                            //         'Come and stay in this superb duplex T2, in the heart of the historic center of Bordeaux. Spacious and bright, in a real Bordeaux building in exposed stone, you will enjoy all the charms of the city thanks to its ideal location. Close to many shops, bars and restaurants, you can access the apartment by tram A and C and bus routes 27 and 44. ...'
                            //             .poppinscenter(
                            //       color: const Color(0xff896e57),
                            //       fontWeight: FontWeight.bold,
                            //       height: 1.5,
                            //       letterSpacing: 1,
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: 34),
                            // const SizedBox(height: 1),
                            // const Divider(),
                            // const SizedBox(height: 1),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: 'What this place offers'.poppins(
                            //     color: brown,
                            //     fontSize: 25 + 4 * pad,
                            //   ),
                            // ),
                            // Container(
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //         flex: 2,
                            //         child: Container(
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: GridView.builder(
                            //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //               crossAxisCount: Metrics.isMobile(context)
                            //                   ? 1
                            //                   : Metrics.isCompact(context)
                            //                       ? 1
                            //                       : Metrics.isTablet(context)
                            //                           ? 2
                            //                           : 2,
                            //               childAspectRatio: _aspectRatio,
                            //               crossAxisSpacing: 24,
                            //               mainAxisSpacing: 24,
                            //             ),
                            //             shrinkWrap: true,
                            //             // physics:
                            //             //     const NeverScrollableScrollPhysics(),
                            //             itemCount: data_place.length,
                            //             itemBuilder: (context, index) {
                            //               final gridItem = decorativeItems[index];

                            //               return Container(
                            //                 decoration: BoxDecoration(
                            //                   color: white,
                            //                   borderRadius: const BorderRadius.only(
                            //                     topLeft: Radius.circular(8),
                            //                     topRight: Radius.circular(8),
                            //                     bottomLeft: Radius.circular(8),
                            //                     bottomRight: Radius.circular(8),
                            //                   ),
                            //                   boxShadow: [
                            //                     BoxShadow(
                            //                       color: Colors.grey.withOpacity(0.25),
                            //                       offset: const Offset(0, 4),
                            //                       blurRadius: 4,
                            //                     ),
                            //                   ],
                            //                 ),
                            //                 padding: const EdgeInsets.all(4),
                            //                 child: Row(
                            //                   children: [
                            //                     Padding(
                            //                       padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            //                       child: Center(
                            //                         child: Icon(IconData(int.parse('${data_place[index]['icons']}'),
                            //                             fontFamily: 'MaterialIcons')),
                            //                       ),
                            //                     ),
                            //                     Expanded(
                            //                       child: Align(
                            //                         alignment: Alignment.centerLeft,
                            //                         child: '${data_place[index]['name']}'.poppins(
                            //                           color: black,
                            //                           fontSize: 16 + 4 * pad,
                            //                         ),
                            //                       ),
                            //                     ),
                            //                   ],
                            //                 ),
                            //               );
                            //             },
                            //           ),
                            //         ),
                            //       ),
                            //       Expanded(child: SizedBox())
                            //     ],
                            //   ),
                            // ),
                            // const SizedBox(height: 34),
                            // const SizedBox(height: 1),
                            // const Divider(),
                            // const SizedBox(height: 1),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: 'What this place offers'.poppins(
                            //     color: brown,
                            //     fontSize: 25 + 4 * pad,
                            //   ),
                            // ),
                            // Center(
                            //   child: FractionallySizedBox(
                            //     widthFactor: 0.8,
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.symmetric(vertical: 16.0),
                            //           child: 'Things to know'.poppins(
                            //               fontSize: 20, fontWeight: FontWeight.w600, textAlign: TextAlign.start),
                            //         ),
                            //         Container(
                            //           width: double.infinity,
                            //           height: 400,
                            //           child: SingleChildScrollView(
                            //             scrollDirection: Axis.horizontal,
                            //             child: Row(
                            //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //               crossAxisAlignment: CrossAxisAlignment.start,
                            //               children: [
                            //                 for (int index = 0; index < ThingsknowType_models.length; index++)
                            //                   // if (Thingsknow_models[0].things_ser == ThingsknowType_models[index].ser)
                            //                   Padding(
                            //                     padding: const EdgeInsets.all(16.0),
                            //                     child: Column(
                            //                       mainAxisAlignment: MainAxisAlignment.start,
                            //                       crossAxisAlignment: CrossAxisAlignment.start,
                            //                       children: [
                            //                         '${ThingsknowType_models[index].name}'.poppins(
                            //                             fontSize: 14,
                            //                             fontWeight: FontWeight.w600,
                            //                             textAlign: TextAlign.start),
                            //                         Padding(
                            //                           padding: const EdgeInsets.all(8.0),
                            //                           child: Column(
                            //                             children: [
                            //                               for (int index1 = 0; index1 < Thingsknow_models.length; index1++)
                            //                                 if (Thingsknow_models[index1].things_ser.toString().trim() ==
                            //                                     ThingsknowType_models[index].ser.toString().trim())
                            //                                   Row(
                            //                                     mainAxisAlignment: MainAxisAlignment.start,
                            //                                     children: [
                            //                                       Padding(
                            //                                         padding: const EdgeInsets.all(8.0),
                            //                                         child: Icon(IconData(
                            //                                             int.parse('${Thingsknow_models[index1].icon}'),
                            //                                             fontFamily: 'MaterialIcons')),
                            //                                       ),
                            //                                       Expanded(
                            //                                         child: '${Thingsknow_models[index1].name}'
                            //                                             .poppins(fontSize: 12),
                            //                                       )
                            //                                     ],
                            //                                   ),
                            //                             ],
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 // Expanded(
                            //                 //     flex: 1,
                            //                 //     child: Column(
                            //                 //       mainAxisAlignment: MainAxisAlignment.start,
                            //                 //       crossAxisAlignment: CrossAxisAlignment.start,
                            //                 //       children: [

                            //                 //         'House rules'.poppins(
                            //                 //             fontSize: 14,
                            //                 //             fontWeight: FontWeight.w600,
                            //                 //             textAlign: TextAlign.start),
                            //                 //         Padding(
                            //                 //           padding: const EdgeInsets.all(8.0),
                            //                 //           child: Column(
                            //                 //             children: [
                            //                 //               Row(
                            //                 //                 mainAxisAlignment: MainAxisAlignment.start,
                            //                 //                 children: [
                            //                 //                   Padding(
                            //                 //                     padding: const EdgeInsets.all(8.0),
                            //                 //                     child: Icon(Icons.access_time),
                            //                 //                   ),
                            //                 //                   'Check-in: After 4:00 PM'.poppins(fontSize: 12)
                            //                 //                 ],
                            //                 //               ),
                            //                 //               Row(
                            //                 //                 mainAxisAlignment: MainAxisAlignment.start,
                            //                 //                 children: [
                            //                 //                   Padding(
                            //                 //                     padding: const EdgeInsets.all(8.0),
                            //                 //                     child: Icon(Icons.access_time),
                            //                 //                   ),
                            //                 //                   'Checkout:  10:00 AM'.poppins(fontSize: 12)
                            //                 //                 ],
                            //                 //               ),
                            //                 //               Row(
                            //                 //                 mainAxisAlignment: MainAxisAlignment.start,
                            //                 //                 children: [
                            //                 //                   Padding(
                            //                 //                     padding: const EdgeInsets.all(8.0),
                            //                 //                     child: Icon(Icons.door_back_door_outlined),
                            //                 //                   ),
                            //                 //                   'Self check-in with lockbox'.poppins(fontSize: 12)
                            //                 //                 ],
                            //                 //               ),
                            //                 //               Row(
                            //                 //                 mainAxisAlignment: MainAxisAlignment.start,
                            //                 //                 children: [
                            //                 //                   Padding(
                            //                 //                     padding: const EdgeInsets.all(8.0),
                            //                 //                     child: Icon(Icons.shopping_cart_outlined),
                            //                 //                   ),
                            //                 //                   'Not suitable for infants (under 2 years)'
                            //                 //                       .poppins(fontSize: 12)
                            //                 //                 ],
                            //                 //               ),
                            //                 //               Row(
                            //                 //                 mainAxisAlignment: MainAxisAlignment.start,
                            //                 //                 children: [
                            //                 //                   Padding(
                            //                 //                     padding: const EdgeInsets.all(8.0),
                            //                 //                     child: Icon(Icons.smoke_free),
                            //                 //                   ),
                            //                 //                   'No smoking'.poppins(fontSize: 12)
                            //                 //                 ],
                            //                 //               ),
                            //                 //               Row(
                            //                 //                 mainAxisAlignment: MainAxisAlignment.start,
                            //                 //                 children: [
                            //                 //                   Padding(
                            //                 //                     padding: const EdgeInsets.all(8.0),
                            //                 //                     child: Icon(Icons.celebration_outlined),
                            //                 //                   ),
                            //                 //                   'No parties or events'.poppins(fontSize: 12)
                            //                 //                 ],
                            //                 //               ),
                            //                 //             ],
                            //                 //           ),
                            //                 //         ),
                            //                 //       ],
                            //                 //     )),
                            //                 // Expanded(
                            //                 //     child: Column(
                            //                 //   mainAxisAlignment: MainAxisAlignment.start,
                            //                 //   crossAxisAlignment: CrossAxisAlignment.start,
                            //                 //   children: [
                            //                 //     'Health & safety'.poppins(
                            //                 //         fontSize: 14, fontWeight: FontWeight.w600, textAlign: TextAlign.start),
                            //                 //     Padding(
                            //                 //       padding: const EdgeInsets.all(8.0),
                            //                 //       child: Column(
                            //                 //         children: [
                            //                 //           Row(
                            //                 //             mainAxisAlignment: MainAxisAlignment.start,
                            //                 //             children: [
                            //                 //               Padding(
                            //                 //                 padding: const EdgeInsets.all(8.0),
                            //                 //                 child: Icon(Icons.auto_awesome_outlined),
                            //                 //               ),
                            //                 //               Text(
                            //                 //                 "Committed to Airbnb's enhanced cleaning\n process.",
                            //                 //                 style: GoogleFonts.poppins(
                            //                 //                   fontSize: 12,
                            //                 //                 ),
                            //                 //                 textAlign: TextAlign.justify,
                            //                 //               ),
                            //                 //             ],
                            //                 //           ),
                            //                 //           Row(
                            //                 //             mainAxisAlignment: MainAxisAlignment.start,
                            //                 //             children: [
                            //                 //               Padding(
                            //                 //                 padding: const EdgeInsets.all(8.0),
                            //                 //                 child: Icon(Icons.clean_hands_outlined),
                            //                 //               ),
                            //                 //               Text(
                            //                 //                 "Airbnb's social-distancing and other\n COVID-19-related guidelines apply",
                            //                 //                 style: GoogleFonts.poppins(
                            //                 //                   fontSize: 12,
                            //                 //                 ),
                            //                 //                 textAlign: TextAlign.justify,
                            //                 //               )
                            //                 //             ],
                            //                 //           ),
                            //                 //           Row(
                            //                 //             mainAxisAlignment: MainAxisAlignment.start,
                            //                 //             children: [
                            //                 //               Padding(
                            //                 //                 padding: const EdgeInsets.all(8.0),
                            //                 //                 child: Icon(Icons.radio_button_on),
                            //                 //               ),
                            //                 //               'Smoke alarm'.poppins(fontSize: 12)
                            //                 //             ],
                            //                 //           ),
                            //                 //           Row(
                            //                 //             mainAxisAlignment: MainAxisAlignment.start,
                            //                 //             children: [
                            //                 //               Padding(
                            //                 //                 padding: const EdgeInsets.all(8.0),
                            //                 //                 child: Icon(Icons.credit_card),
                            //                 //               ),
                            //                 //               Text(
                            //                 //                 "Security Deposit - if you damage the\n home, you may be charged up to \$566",
                            //                 //                 style: GoogleFonts.poppins(
                            //                 //                   fontSize: 12,
                            //                 //                 ),
                            //                 //                 textAlign: TextAlign.justify,
                            //                 //               )
                            //                 //             ],
                            //                 //           ),
                            //                 //           Row(
                            //                 //             mainAxisAlignment: MainAxisAlignment.start,
                            //                 //             children: [
                            //                 //               Padding(
                            //                 //                 padding: const EdgeInsets.all(8.0),
                            //                 //                 child: Icon(Icons.smoke_free),
                            //                 //               ),
                            //                 //               'No smoking'.poppins(fontSize: 12)
                            //                 //             ],
                            //                 //           ),
                            //                 //         ],
                            //                 //       ),
                            //                 //     ),
                            //                 //   ],
                            //                 // )),
                            //                 // Expanded(
                            //                 //     flex: 1,
                            //                 //     child: Column(
                            //                 //       crossAxisAlignment: CrossAxisAlignment.start,
                            //                 //       children: [
                            //                 //         'Cancellation policy'.poppins(
                            //                 //             fontSize: 14,
                            //                 //             fontWeight: FontWeight.w600,
                            //                 //             textAlign: TextAlign.start),
                            //                 //         Padding(
                            //                 //           padding: const EdgeInsets.all(8.0),
                            //                 //           child: Column(
                            //                 //             crossAxisAlignment: CrossAxisAlignment.start,
                            //                 //             mainAxisAlignment: MainAxisAlignment.start,
                            //                 //             children: [
                            //                 //               "Free cancellation before Feb 14"
                            //                 //                   .poppins(fontSize: 12, color: Color.fromRGBO(75, 85, 99, 1)),
                            //                 //               Row(
                            //                 //                 children: [
                            //                 //                   'Show more'.poppins(decoration: TextDecoration.underline),
                            //                 //                   Icon(Icons.keyboard_arrow_right)
                            //                 //                 ],
                            //                 //               ),
                            //                 //             ],
                            //                 //           ),
                            //                 //         ),
                            //                 //       ],
                            //                 //     ))
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //         // Row(
                            //         //   children: [
                            //         //     'Show more'.poppins(decoration: TextDecoration.underline),
                            //         //     Icon(Icons.keyboard_arrow_right)
                            //         //   ],
                            //         // ),
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        )
                      ])),
                  'Thing to Know'.poppins(
                      fontSize: Metrics.isMobile(context) ? 20 : 40,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w600),
                  TypeThings(),
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
  } ////---------------------------------------->

  Widget TypeThings() {
    List<String> imageUrls = ThingsknowType_models.map((data) => data.name.toString()).toList();
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));
    return Column(
      children: [
        const SizedBox(height: 80),
        SizedBox(
          width: double.infinity,
          height: 400 + 100 * pad,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (val) => setState(() => currentPage = val),
            itemCount: ThingsknowType_models.length,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 36 * pad, right: 36 * pad),
                child: AnimatedScale(
                    duration: const Duration(milliseconds: 240),
                    scale: currentPage == index ? 1 : 0.75,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 36 * pad, right: 36 * pad, bottom: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: '${ThingsknowType_models[index].name}'.poppins(
                              color: black,
                              fontSize: 25 + 4 * pad,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            color: white,
                            // border: Border.all(
                            //     color: Color.fromARGB(255, 216, 213, 213),
                            //     width: 1),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color:
                            //         const Color.fromARGB(255, 180, 175, 175)
                            //             .withOpacity(0.5),
                            //     spreadRadius: 3,
                            //     blurRadius: 4,
                            //     offset: Offset(
                            //         0, 4), // changes position of shadow
                            //   ),
                            // ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (int index3 = 0; index3 < Thingsknow_models.length; index3++)
                                if (Thingsknow_models[index3].things_ser.toString().trim() ==
                                    ThingsknowType_models[index].ser.toString().trim())
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                          child: Center(
                                            child: Icon(IconData(int.parse('${Thingsknow_models[index3].icon}'),
                                                fontFamily: 'MaterialIcons')),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: '${Thingsknow_models[index3].name}'.poppins(
                                              color: black,
                                              fontSize: 14 + 4 * pad,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ],
                    )),
              );
            },
          ),
        ),
        const SizedBox(height: 34),
        ImageSliderController(
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
          next: (currentPage != ThingsknowType_models.length - 1)
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
      ],
    );
  }

  selectdate(date) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(20)),
      child: SfDateRangePicker(
        showActionButtons: true,
        showTodayButton: true,
        confirmText: 'OK',
        cancelText: 'Cancel',
        backgroundColor: white,
        selectableDayPredicate: (date) {
          return date.weekday != DateTime.monday &&
              date.weekday != DateTime.wednesday &&
              date.weekday != DateTime.friday;
        },
        minDate: selectsdate != null ? selectsdate : DateTime.now(),
        maxDate: selectsdate?.add(Duration(days: 4)),
        initialSelectedDate: selectldate == null ? selectsdate : null,
        initialSelectedRange: rangedate != false ? PickerDateRange(selectsdate, selectldate) : null,
        // initialSelectedDates: selectldate == null ? null : selectldate,
        headerStyle: DateRangePickerHeaderStyle(backgroundColor: white),
        selectionColor: const Color.fromRGBO(222, 49, 81, 1),
        startRangeSelectionColor: const Color.fromRGBO(222, 49, 81, 1),
        rangeSelectionColor: const Color.fromRGBO(222, 49, 81, 0.5),
        todayHighlightColor: const Color.fromRGBO(222, 49, 81, 0.7),
        endRangeSelectionColor: const Color.fromRGBO(222, 49, 81, 1),
        onCancel: () {
          setState(() {
            selectsdate = null;
            selectldate = null;
            rangedate = false;
          });
          Navigator.of(context).pop();
        },
        showNavigationArrow: true,
        selectionMode: date == 's'
            ? selectldate != null
                ? DateRangePickerSelectionMode.range
                : DateRangePickerSelectionMode.single
            : DateRangePickerSelectionMode.range,
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
          setState(() {
            if (date == 's') {
              if (rangedate == true) {
                selectsdate = args.value.startDate;
                selectldate = args.value.endDate;
              } else {
                selectsdate = args.value;
              }

              // rangedate = args.value;
              // print('$selectsdate-$selectldate');
            } else {
              // rangedate = true;
              // print(args.value);
              // selectsdate = args.value.startDate;
              selectldate = args.value.endDate;
              // selectedDates = args.value;
              // print('$selectsdate-$selectldate');
            }
          });
        },
        onSubmit: (p0) {
          setState(() {
            // print(p0);

            // if (date == 's') {
            //   selectsdate = p0;
            //   print('s$selectsdate');
            if (selectldate == null) {
              rangedate = false;
            }
            Navigator.of(context).pop();
            // } else {
            //   selectldate = p0;
            //   print('l$selectldate');
            //   Navigator.of(context).pop();
            // }
          });
        },
      ),
    );
  }
}
