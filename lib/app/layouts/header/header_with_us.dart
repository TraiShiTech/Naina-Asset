import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:properties/core/core.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/metrics.dart';
import '../../components/appbar/appbar.dart';
import '../../widgets/base_container.dart';
import '../../widgets/icon_btn.dart';
import '../experiences/experiences_image.dart';
import '../experiences/experiences_info.dart';
import '../experiences/experiences_info_item.dart';
import 'header_left.dart';
import 'header_right.dart';

class Header_WithUs extends StatelessWidget {
  const Header_WithUs({
    Key? key,
    required GlobalKey<State<StatefulWidget>> headerKey,
  })  : _headerKey = headerKey,
        super(key: key);

  final GlobalKey<State<StatefulWidget>> _headerKey;

  @override
  Widget build(BuildContext context) {
    List<String> links = [
      'Property',
      'Check in',
      'Check out',
    ];
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));
    final bool isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);
    final pad1 = isBigScreen ? 0.0 : normalize(min: 576, max: 976, data: Metrics.width(context));

    return Container(
      child: Column(
        children: [
          Container(
            key: _headerKey,
            width: Metrics.width(context),
            // height: 720,
            // color: greenBorder,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/property_service/08.jpg'),
                //  NetworkImage(
                //     "https://drive.google.com/file/d/128N1Li3SURnZ_sn8DUsbCU-A6YKecTip/view"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
                    color: white,
                    child: Column(
                      children: [
                        BaseContainer(
                          child: SizedBox(
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://s3-alpha-sig.figma.com/img/5da3/4bc4/1fbe5a4bd62aa21042bda5592db20d39?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=geKrfG~kUGFIFaThNK326NB9Xq-JXVPXqv69fq2oQWE0VhdxWskf354YLvNhQIm3EYT7zvTsMgDa5YStFmeYsFLS814xjFEKXVgLwjOxHlkPe1IeLMZppAMlrqx4v8ncGKbxTLCORQl7Er60asGy1b70hV21bYVYNHOldpvm3n6A8Cgt6rEhdrz1L4jpxv8Ye9RdJCgpb7OVElv6G8lvvnof0oUPTld4j1raiV8EpyuLJp4EhUuEsT-Mg2LgfJLuAeuIhc7xh-8UhOX7vV7YhuPAnHNz6ufW5tB6hQQw9BEqXBEh205iMqvnxp9TAuSUVdUBsWbathZzvvL~QL7Bcw__"),
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.high,
                                            isAntiAlias: true,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            'Naina Asset'.poppins(
                                              color: greenBg,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  (Metrics.isDesktop(context) || Metrics.isTablet(context)) ? 24 : 14,
                                              height: 1.5,
                                            ),
                                            'ในนา แอสเสท - บริการดูแลพร็อพเพอร์ตี้มืออาชีพ '.poppins(
                                              color: greenBg,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  (Metrics.isDesktop(context) || Metrics.isTablet(context)) ? 14 : 10,
                                              height: 1.5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                                      Container(
                                        height: 30,
                                        width: 3,
                                        color: greenBg.withOpacity(0.5),
                                        margin: const EdgeInsets.symmetric(horizontal: 24),
                                      ),
                                    if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                                      ...List.generate(links.length, (index) {
                                        final link = links[index];

                                        return Padding(
                                          padding: EdgeInsets.only(left: index != 0 ? 24 : 0),
                                          child: TextButton(
                                            onPressed: () {},
                                            child: link.poppins(
                                              fontWeight: FontWeight.w500,
                                              color: greenBg,
                                              fontSize: 16,
                                              height: 1.5,
                                            ),
                                          ),
                                        );
                                      }),
                                    if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                                      Container(
                                        height: 30,
                                        width: 3,
                                        color: greenBg.withOpacity(0.5),
                                        margin: const EdgeInsets.symmetric(horizontal: 24),
                                      ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: greenBg,
                                        ))
                                    // if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                                    //   Padding(
                                    //     padding: const EdgeInsets.only(left: 8.0),
                                    //     child: IconBtn(
                                    //       icon: FontAwesomeIcons.bars,
                                    //       onTap: () {},
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: Metrics.width(context),
                          height: 1,
                          // color: greenlight,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
