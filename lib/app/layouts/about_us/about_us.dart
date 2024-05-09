import 'package:flutter/material.dart';
import 'package:properties/core/core.dart';

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
          const SizedBox(height: 20),

          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: 'Our full management service includes:'.poppins(
              color: white,
              fontSize: 25 + 4 * pad,
            ),
          ),
          const SizedBox(height: 20),
          // AboutUsInfo(pad: pad),
          const AboutUsImageSlider(),

    
       

          const SizedBox(height: 20),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
