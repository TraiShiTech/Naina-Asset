import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
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
