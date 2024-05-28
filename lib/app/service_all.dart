import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:properties/Constant/Myconstant.dart';
import 'package:properties/app/layouts/footer/footer.dart';
import 'package:properties/app/layouts/header/header_rent.dart';
import 'package:properties/core/core.dart';
import 'package:properties/core/models/img_serviceinfo_model.dart';
import 'package:properties/core/models/servic_data_model.dart';
import 'package:properties/core/models/service_type_model.dart';
import 'package:http/http.dart' as http;
import 'package:properties/core/theme/app_colors.dart';
import 'package:properties/core/utils/methods.dart';
import 'package:properties/core/utils/metrics.dart';

class Service_All extends StatefulWidget {
  const Service_All({super.key, required this.ser});
  final String ser;

  @override
  State<Service_All> createState() => _Service_AllState();
}

class _Service_AllState extends State<Service_All> {
  final GlobalKey _headerKey = GlobalKey();
///////----------------------------------------------->
  @override
  void initState() {
    read_GC_ServiceIMG(widget.ser);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

///////----------------------------------------------->
  List<Service_TypeModel> service_TypeModels = [];
  List<ServiceData_Model> service_dataModels = [];
  List<Imgserviceinfo_model> imgserviceinfo_models_Type_C = [];
  List<Imgserviceinfo_model> imgserviceinfo_models_Type_S = [];
  Future<Null> read_GC_ServiceIMG(index) async {
    String ser_ = '${service_TypeModels[index].ser}';
    setState(() {
      imgserviceinfo_models_Type_C.clear();
      imgserviceinfo_models_Type_S.clear();
    });
    String url = '${MyConstant().domain}/GC_Service_Info_Image.php?isAdd=true&ser=$ser_';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      print(result);

      for (var map in result) {
        Imgserviceinfo_model imgserviceinfo_modelss = Imgserviceinfo_model.fromJson(map);
        if (imgserviceinfo_modelss.img_type.toString() == 'C') {
          setState(() {
            imgserviceinfo_models_Type_C.add(imgserviceinfo_modelss);
          });
        } else if (imgserviceinfo_modelss.img_type.toString() == 'S') {
          setState(() {
            imgserviceinfo_models_Type_S.add(imgserviceinfo_modelss);
          });
        }
      }
    } catch (e) {}
  }

  ///////----------------------------------------------->  List<ServiceData_Model> service_dataModels = [];
  Future<Null> read_GC_ServiceType() async {
    String ser_service = '1';
    if (service_dataModels.length != 0) {
      service_dataModels.clear();
    }

    String url = '${MyConstant().domain}/GC_Services_dataAll.php?isAdd=true&ser=$ser_service';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        ServiceData_Model service_dataModelss = ServiceData_Model.fromJson(map);
        setState(() {
          service_dataModels.add(service_dataModelss);
        });
      }
    } catch (e) {}
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
              // controller: _baseController,
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
                    child: '#Service information#'.poppins(
                      color: Color.fromRGBO(71, 69, 69, 1),
                      fontSize: 25 + 4 * pad,
                    ),
                  ),
                  const SizedBox(height: 80),
                  FractionallySizedBox(
                    widthFactor: 0.8,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int index = 0; index < imgserviceinfo_models_Type_C.length; index++)
                            Image.network('${MyConstant().domain}img/${imgserviceinfo_models_Type_C[index].img}')
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: '${service_dataModels[0].content}'.poppinscenter(
                        color: const Color(0xff896e57),
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: '${service_dataModels[0].content_sub1}'.poppinscenter(
                        color: const Color(0xff896e57),
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: '${service_dataModels[0].content_sub2}'.poppinscenter(
                        color: const Color(0xff896e57),
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: '${service_dataModels[0].content_sub3}'.poppinscenter(
                        color: const Color(0xff896e57),
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  GridView.builder(
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
                      childAspectRatio: 9 / (6),
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: imgserviceinfo_models_Type_S.length, // Number of items in the grid
                    itemBuilder: (BuildContext context, int index) {
                      // if (managementTypeModels.isEmpty) {
                      //   read_GC_ManagementType();
                      // }

                      final img = '${MyConstant().domain}img/${imgserviceinfo_models_Type_S[index].img.toString()}';
                      // final title = '${managementTypeModels[index].name}';
                      // if (ManagementModels[index1]
                      //     .ser_type!
                      //     .split(',')
                      //     .where((element) => element == managementTypeModels[index].ser)
                      //     .isNotEmpty)
                      return Image.network(
                        img,
                        fit: BoxFit.cover,
                      );
                    },
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
