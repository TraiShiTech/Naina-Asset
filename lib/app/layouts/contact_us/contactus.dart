import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:properties/core/core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../widgets/base_container.dart';

import 'You_T.dart';

class Contactus extends StatefulWidget {
  static String videoID = 'egMWlD3fLJ8';
  const Contactus({super.key});

  @override
  State<Contactus> createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  bool isFullScreen = false;
  double Map_Lat = 18.80459744743333;
  double Map_Lng = 98.99387637805485;

  Widget Map() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // color: brown.withOpacity(0.5),
      ),
      child: GoogleMap(
        markers: {
          Marker(
            markerId: const MarkerId("marker1"),
            position: LatLng(Map_Lat, Map_Lng),
            draggable: true,
            onDragEnd: (value) {
              // value is the new position
            },
            // To do: custom marker icon
          ),
          Marker(
            markerId: const MarkerId("marker2"),
            position: LatLng(Map_Lat, Map_Lng),
          ),
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(Map_Lat, Map_Lng),
          zoom: 14,
        ),
        // ToDO: add markers
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: BaseContainer(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: 40 + 50 * normalize(min: 576, max: 1440, data: Metrics.width(context))),
          child: Metrics.isMobile(context)
              ? Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Contact Us',
                      style: GoogleFonts.poppins(
                          fontSize: 28, fontWeight: FontWeight.w600, color: Color.fromRGBO(82, 82, 82, 1)),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child:
                            'With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don\'t worry about contacting us. Because we always have good suggestions.'
                                .poppins(
                                    color: const Color(0xff896e57),
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                    letterSpacing: 1,
                                    textAlign: TextAlign.center),
                      ),
                    ),
                    const SizedBox(height: 90),
                    Container(
                      width: Metrics.width(context),
                      height: 340,
                      // color: Colors.blue,
                      child: VideoPlayerScreen(),
                    ),
                    const SizedBox(height: 90),
                    const SizedBox(height: 10),
                    Text(
                      'Naina Asset Co., Ltd.',
                      style: GoogleFonts.poppins(
                          fontSize: 28, fontWeight: FontWeight.w600, color: Color.fromRGBO(82, 82, 82, 1)),
                    ),
                    const SizedBox(height: 16),
                    'Address \nThe 9 Tha sala\nSuperhighway Road\nT.Sankampaeng A.Muang\nChiang Mai, Thailand\nOffice Hours:\n8.30 - 17.30 Everyday \n(Closed every Sunday)'
                        .poppins(
                      color: const Color(0xff896e57),
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      letterSpacing: 1,
                    ),
                    const SizedBox(height: 16),
                    Container(width: Metrics.width(context), height: 340, child: Map())
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Text(
                        'Contact Us',
                        style: GoogleFonts.poppins(
                            fontSize: 28, fontWeight: FontWeight.w600, color: Color.fromRGBO(82, 82, 82, 1)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child:
                            'With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don\'t worry about contacting us. Because we always have good suggestions.'
                                .poppins(
                                    color: const Color(0xff896e57),
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                    letterSpacing: 1,
                                    textAlign: TextAlign.center),
                      ),
                    ),
                    const SizedBox(height: 90),
                    Container(
                        width: Metrics.width(context),
                        height: 330,
                        // color: Colors.blue,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(alignment: Alignment.center, child: VideoPlayerScreen()),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(),
                            ),
                          ],
                        )),
                    const SizedBox(height: 90),
                    Container(
                        width: Metrics.width(context),
                        height: 330,
                        // color: Colors.blue,
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      'Naina Asset Co., Ltd.',
                                      style: GoogleFonts.poppins(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(82, 82, 82, 1)),
                                    ),
                                    const SizedBox(height: 16),
                                    'Address \nThe 9 Tha sala\nSuperhighway Road\nT.Sankampaeng A.Muang\nChiang Mai, Thailand\n\nOffice Hours:\n8.30 - 17.30 Everyday \n(Closed every Sunday)'
                                        .poppins(
                                      color: const Color(0xff896e57),
                                      fontWeight: FontWeight.w500,
                                      height: 1.5,
                                      letterSpacing: 1,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: AspectRatio(aspectRatio: 1 / 1, child: Map()),
                              ),
                            ],
                          ),
                        )),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     SvgPicture.asset(
                    //       'Amazon.svg'.icon,
                    //       height: 40,
                    //     ),
                    //     SvgPicture.asset(
                    //       'Autodesk.svg'.icon,
                    //       height: 40,
                    //     ),
                    //     SvgPicture.asset(
                    //       'Google.svg'.icon,
                    //       height: 40,
                    //     ),
                    //     SvgPicture.asset(
                    //       'Paypal.svg'.icon,
                    //       height: 40,
                    //     ),
                    //     SvgPicture.asset(
                    //       'Webflow.svg'.icon,
                    //       height: 40,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
        ),
      ),
    );
  }
}
