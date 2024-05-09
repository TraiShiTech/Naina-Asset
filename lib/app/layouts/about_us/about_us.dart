import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/methods.dart';
import '../../../core/utils/metrics.dart';
import 'about_us_image_slider.dart';
import 'about_us_info.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 976, max: 1440, data: Metrics.width(context));

    return Container(
      width: Metrics.width(context),
      // color: BG_AboutUs,
      child: Column(
        children: [
          // AboutUsInfo(pad: pad),
          const AboutUsImageSlider(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
