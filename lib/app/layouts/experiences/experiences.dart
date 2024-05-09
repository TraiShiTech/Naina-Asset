import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/methods.dart';
import '../../../core/utils/metrics.dart';
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
      child: Column(
        children: [
          AboutUsInfo(pad: pad),
          BaseContainer(
            child: Column(
              children: [
                const SizedBox(height: 10),
                if (isBigScreen)
                  for (int index1 = 0; index1 < 2; index1++)
                    SizedBox(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              const ExperiencesImage(),
                              SizedBox(width: 60 * pad),
                              ExperiencesInfo(
                                  pad: pad, isBigScreen: isBigScreen),
                            ],
                          ),
                        ],
                      ),
                    ),
                if (!isBigScreen)
                  for (int index1 = 0; index1 < 2; index1++)
                    Column(
                      children: [
                        const SizedBox(height: 40),
                        Row(
                          children: const [
                            ExperiencesImage(),
                          ],
                        ),
                        const SizedBox(height: 36),
                        Row(
                          children: [
                            ExperiencesInfo(pad: pad, isBigScreen: isBigScreen),
                          ],
                        ),
                      ],
                    ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
