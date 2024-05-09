import 'package:flutter/material.dart';
import 'package:properties/core/core.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/methods.dart';
import '../../../core/utils/metrics.dart';
import '../../widgets/base_container.dart';
import 'footer_bottom_licence.dart';
import 'footer_bottom_social_buttons.dart';

class FooterBottom extends StatelessWidget {
  const FooterBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));
    return Container(
      width: Metrics.width(context),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: brown2,
            // color: greenBorder,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          BaseContainer(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: Metrics.isMobile(context)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  'Naina Asset Co., Ltd.'.msMadi(
                    fontSize: 36 + 24 * pad,
                    color: greenBorder,
                  ),
                  // 'ในนา แอสเสท'.stixTwoText(
                  //   fontSize: 30 + 24 * pad,
                  //   fontWeight: FontWeight.bold,
                  //   letterSpacing: -0.5,
                  // ),
                  'ในนา แอสเสท'.stixTwoText(
                    fontSize: 30 + 24 * pad,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          BaseContainer(
            child: SizedBox(
              height: 100,
              child: !Metrics.isMobile(context)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        FooterBottomLicence(),
                        FooterBottomSocialButtons(),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        FooterBottomSocialButtons(),
                        FooterBottomLicence(),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
