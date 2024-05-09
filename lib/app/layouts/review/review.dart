import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/methods.dart';
import '../../../core/utils/metrics.dart';
import '../../widgets/base_container.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 976, max: 1440, data: Metrics.width(context));
    final isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);

    return Container(
      width: Metrics.width(context),
      // color: BG_AboutUs,
      child: Column(
        children: [
          BaseContainer(
            child: Column(
              children: [
                const SizedBox(height: 90),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
