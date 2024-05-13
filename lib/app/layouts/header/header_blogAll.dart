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

class Header_Blog extends StatelessWidget {
  const Header_Blog({
    Key? key,
    required GlobalKey<State<StatefulWidget>> headerKey,
  })  : _headerKey = headerKey,
        super(key: key);

  final GlobalKey<State<StatefulWidget>> _headerKey;

  @override
  Widget build(BuildContext context) {
    List<String> links = [
      'Rent',
      // 'Property Management Services',
      'List with Us',
      'About Us',
      // 'Contact Us'
    ];
    return Column(
      children: [
        BaseContainer(
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                    // Image.network(
                    //   'https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/ChatGPT_logo.svg/1200px-ChatGPT_logo.svg.png'
                    //       .icon,
                    //   width: 36,
                    //   height: 36,
                    //   fit: BoxFit.cover,
                    //   filterQuality: FilterQuality.high,
                    //   isAntiAlias: true,
                    // ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Naina Asset'.poppins(
                          color: greenBg,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          height: 1.5,
                        ),
                        'ในนา แอสเสท - บริการดูแลพร็อพเพอร์ตี้มืออาชีพ '
                            .poppins(
                          color: greenBg,
                          fontWeight: FontWeight.w600,
                          fontSize: (Metrics.isDesktop(context) ||
                                  Metrics.isTablet(context))
                              ? 14
                              : 12,
                          height: 1.5,
                        ),
                      ],
                    ),
                  ],
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
    );
  }
}
