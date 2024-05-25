import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:properties/Constant/Myconstant.dart';
import 'package:properties/core/core.dart';
import 'package:properties/core/models/partner_model.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/methods.dart';
import '../../../core/utils/metrics.dart';
import '../../widgets/base_container.dart';
import 'footer_bottom_licence.dart';
import 'package:http/http.dart' as http;
import 'footer_bottom_social_buttons.dart';

class FooterBottom extends StatefulWidget {
  final Color bg;
  const FooterBottom({
    Key? key,
    required this.bg,
  }) : super(key: key);

  @override
  State<FooterBottom> createState() => _FooterBottomState();
}

class _FooterBottomState extends State<FooterBottom> {
  List<PartnerModel> partnerModels = [];

  @override
  void initState() {
    read_GC_Partner();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));
    // return Container(
    //   width: Metrics.width(context),
    //   decoration: BoxDecoration(
    //     border: Border(
    //       top: BorderSide(
    //         color: brown2,
    //         // color: greenBorder,
    //       ),
    //     ),
    //   ),
    //   child: Column(
    //     children: [
    //       const SizedBox(height: 24),
    //       BaseContainer(
    //         child: Align(
    //           alignment: Alignment.centerLeft,
    //           child: Column(
    //             mainAxisAlignment: Metrics.isMobile(context)
    //                 ? MainAxisAlignment.center
    //                 : MainAxisAlignment.start,
    //             children: [
    //               'Naina Asset Co., Ltd.'.msMadi(
    //                 fontSize: 36 + 24 * pad,
    //                 color: greenBorder,
    //               ),
    //               // 'ในนา แอสเสท'.stixTwoText(
    //               //   fontSize: 30 + 24 * pad,
    //               //   fontWeight: FontWeight.bold,
    //               //   letterSpacing: -0.5,
    //               // ),
    //               'ในนา แอสเสท'.stixTwoText(
    //                 fontSize: 30 + 24 * pad,
    //                 fontWeight: FontWeight.bold,
    //                 letterSpacing: -0.5,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       const SizedBox(height: 24),
    //       BaseContainer(
    //         child: SizedBox(
    //           height: 100,
    //           child: !Metrics.isMobile(context)
    //               ? Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: const [
    //                     FooterBottomLicence(),
    //                     FooterBottomSocialButtons(),
    //                   ],
    //                 )
    //               : Column(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: const [
    //                     FooterBottomSocialButtons(),
    //                     FooterBottomLicence(),
    //                   ],
    //                 ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Container(
      color: widget.bg,
      padding: EdgeInsets.all(Metrics.isMobile(context) ? 25 : 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Naina Asset Co., Ltd.',
            style: GoogleFonts.poppins(color: Color.fromRGBO(39, 39, 39, 1), fontSize: 20),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                'nanainaasset.9@gmail.com\ncall : +66 93 189 9950 https://www.facebook.com/naina.asset',
                style: TextStyle(fontSize: 20),
              )),
              if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                Expanded(
                    child: ClipRect(
                  clipBehavior: Clip.antiAlias,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int index = 0; index < partnerModels.length; index++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              // 'https://s3-alpha-sig.figma.com/img/d398/2c58/95fecb47b2fdefc784f0aa67d73fc4ac?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Q86JzBR4DkeoItjgtZrj1uEzJIBwxXeOmDjEYomTZrnuCjiVeeQaidOVlEJoWVw9uusk4QVk6UaIwCSxq~H6LYvbhJ7XG2FePMc25UFfph4r4tZSWA4PdPZ0vR3UQdhsFr0AFatYrmBlfyJIzGu3Eyqhnz5hZ865VN2ROlF2LItI1MyuQC2bogGwdrNOyJNb05W0X0LxqMQRnnUBcCBtUATjg21BLUFSRC6HLgSPJhzdAHI31Qlh6fsziAi51hDTJunHF6ljL8IR0UCY3LGyN3hKPIKXvwdRdPLP92x-4gdVpZKaL1QnVWHFDtqeYD7BArp9K1R9X-Wy~-VyKx3rxw__',
                              '${partnerModels[index].corver_img}', width: 40,
                              height: 40,
                            ),
                          ),
                      ],
                    ),
                  ),
                )),
            ],
          ),
          if (Metrics.isMobile(context))
            ClipRect(
              clipBehavior: Clip.antiAlias,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int index = 0; index < partnerModels.length; index++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        // 'https://s3-alpha-sig.figma.com/img/d398/2c58/95fecb47b2fdefc784f0aa67d73fc4ac?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Q86JzBR4DkeoItjgtZrj1uEzJIBwxXeOmDjEYomTZrnuCjiVeeQaidOVlEJoWVw9uusk4QVk6UaIwCSxq~H6LYvbhJ7XG2FePMc25UFfph4r4tZSWA4PdPZ0vR3UQdhsFr0AFatYrmBlfyJIzGu3Eyqhnz5hZ865VN2ROlF2LItI1MyuQC2bogGwdrNOyJNb05W0X0LxqMQRnnUBcCBtUATjg21BLUFSRC6HLgSPJhzdAHI31Qlh6fsziAi51hDTJunHF6ljL8IR0UCY3LGyN3hKPIKXvwdRdPLP92x-4gdVpZKaL1QnVWHFDtqeYD7BArp9K1R9X-Wy~-VyKx3rxw__',
                        '${MyConstant().domain}img/ ${partnerModels[index].corver_img}', width: 40,
                        height: 40,
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
