import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// <<<<<<< HEAD
// =======
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
// >>>>>>> main-nav
import 'package:properties/core/core.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/methods.dart';
import '../../../core/utils/metrics.dart';
import '../../asset_all.dart';
import '../../widgets/base_container.dart';
import '../about_us/about_us_info.dart';
import 'experiences_image.dart';
import 'experiences_info.dart';

class Experiences extends StatelessWidget {
  const Experiences({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 976, max: 1440, data: Metrics.width(context));
    final isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);

    return Container(
        width: Metrics.width(context),
        // color: BG_AboutUs,
        child: Column(children: [
          AboutUsInfo(pad: pad),
          BaseContainer(
            child: Column(
              children: [
                const SizedBox(height: 10),
                // if (isBigScreen)
                // for (int index1 = 0; index1 < 2; index1++)
                // SizedBox(
                //   child: Column(
                //     children: [
                //       const SizedBox(height: 40),
                //       Row(
                //         children: [
                //           const ExperiencesImage(),
                //           SizedBox(width: 60 * pad),
                //           ExperiencesInfo(
                //               pad: pad, isBigScreen: isBigScreen),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 400,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AspectRatio(
                                    aspectRatio: 3 / 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        'https://s3-alpha-sig.figma.com/img/caed/5dff/b7414305bcf9e8aafa9f45aa3badf0e7?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=GU6arKOElfm~sBP5E7c1F7nee9ceOUTgKDnK9-wk43vMe9BdLTKNySeeSIuaR-WuQ6DmHdSRMk~UkYaGoOiLBKG1xhewuNVX~jm8Cv72YHhtMs-hw0ufkhbLlzxsp96w0ADbFAjlE-6V84TBFoL-XepusgOA28PA70NqZsXQtbJemW6ilmbGCD7f5k-TWUE~iuyDV8vUbPN1EgU3DqGKVcf01IvhHm8Nal-f1RyIMDkOblhDfr5Jb-H7RPHfURXqBqGgyHi3J~wRlpqnL82azb4IT8kAmAkuAQ~yIFj2-sSxvIC~L3wVjlRaFyN3ZQZhdcM2X9rUbnds1ridhkcT9Q__',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AspectRatio(
                                    aspectRatio: 3 / 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        'https://s3-alpha-sig.figma.com/img/7421/1481/baa69c063899ed27ca89fac6650a969b?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=DeWnQA4C39OVuDak1l~XHBN1G-Yl2Q8YE7zqBkJwbONFV~O2f66uMXgkMG1KQLP2dnbXHhvEAHrw6zEP5GwN~eV-2qMypv59l59QQTqXEmlGJ7UB0lmMp~1~LvyzBDrzfABfX10xDTGtws5QWGuG0pawx271yFEUHIBNtOQmx3SkDhp1VT2Ld2o2uEAwL5R-ierQW6fHiTBcuhylWweSYIwhRB-~yd~eIaTOosHgiFSRLpw6PhrcXsTjQ9RJOifS4VWr7jVfzalwtwVi5Sonywjo4Y9RHLxics6HRErIFcKTlsDUVuDviFEB53yIA31qCm~QUxqKZhKEZSCnyI0ySA__',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        '15',
                                        style: TextStyle(
                                            fontSize: 70,
                                            color: Color.fromRGBO(193, 186, 124, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Years of Experiences in Real Estate Industry',
                                        style: TextStyle(
                                            color: white,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1,
                                            fontSize: isBigScreen == Metrics.isDesktop(context) ? 25 : 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        '45%',
                                        style: TextStyle(
                                            fontSize: 70,
                                            color: Color.fromRGBO(193, 186, 124, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Increase in booking from individual listing',
                                        style: TextStyle(
                                            color: white,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1,
                                            fontSize: isBigScreen == Metrics.isDesktop(context) ? 25 : 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        '62%',
                                        style: TextStyle(
                                            fontSize: 70,
                                            color: Color.fromRGBO(193, 186, 124, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Reduction in Fixed Costs by homeowners',
                                        style: TextStyle(
                                            color: white,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1,
                                            fontSize: isBigScreen == Metrics.isDesktop(context) ? 25 : 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          margin: EdgeInsets.only(bottom: 12 + 12 * pad),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(245, 251, 174, 1),
                            borderRadius: BorderRadius.circular(50),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.25),
                            //     offset: const Offset(0, 4),
                            //     blurRadius: 4,
                            //   ),
                            // ],
                          ),
                          child: 'More information'.poppins(
                            color: Color.fromRGBO(81, 77, 77, 1),
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            fontSize: 12,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
// <<<<<<< HEAD
                      // const SizedBox(height: 36),
                      // Row(
                      //   children: [
                      //     ExperiencesInfo(pad: pad, isBigScreen: isBigScreen),
                      //   ],
                      // ),
                      //   ],
                      // ),
                      // const SizedBox(height: 40),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => AssetAll(),
                      //       ),
                      //     );
                      //   },
                      //   child: Container(
                      //     width: 200,
                      //     height: 70,
                      //     decoration: BoxDecoration(
                      //       color: brown,
                      //       borderRadius: const BorderRadius.only(
                      //         topLeft: Radius.circular(20),
                      //         topRight: Radius.circular(20),
                      //         bottomLeft: Radius.circular(20),
                      //         bottomRight: Radius.circular(20),
                      //       ),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.grey.withOpacity(0.25),
                      //           offset: const Offset(0, 4),
                      //           blurRadius: 4,
                      //         ),
                      //       ],
                      //     ),
                      //     child: Center(
                      //       child: 'More Information'.poppins(
                      //         color: white,
                      //         fontSize: 15 + 4 * pad,
                      //       ),
                      //     ),
                      //   ),
                      // ),
// =======
//                       ),
//                     ],
//                   ),
//                 ),
                      // if (!isBigScreen)
                      // for (int index1 = 0; index1 < 2; index1++)
                      //   Column(
                      //     children: [
                      //       const SizedBox(height: 40),
                      //       Row(
                      //         children: const [
                      //           ExperiencesImage(),
                      //         ],
                      //       ),
                      //       const SizedBox(height: 36),
                      //       Row(
                      //         children: [
                      //           ExperiencesInfo(pad: pad, isBigScreen: isBigScreen),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
// >>>>>>> main-nav
                      const SizedBox(height: 36),
                      Row(
                        children: [
                          ExperiencesInfo(pad: pad, isBigScreen: isBigScreen),
                        ],
                      ),
                      const SizedBox(height: 40),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssetAll(),
                            ),
                          );
                        },
                        child: Container(
                          width: 200,
                          height: 70,
                          decoration: BoxDecoration(
                            color: brown,
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
                          child: Center(
                            child: 'More Information'.poppins(
                              color: white,
                              fontSize: 15 + 4 * pad,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
