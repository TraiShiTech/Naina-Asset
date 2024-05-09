import 'package:flutter/material.dart';
import 'package:properties/core/core.dart';

import '../../../core/utils/metrics.dart';

class FooterBottomLicence extends StatelessWidget {
  const FooterBottomLicence({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: Metrics.isMobile(context)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        '© 2024'.poppins(
          color: white,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
        ' Naina Asset Co., Ltd. & Dzentric Co.,Ltd. '.poppins(
          color: Colors.red[900],
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
        ' All rights reserved.'.poppins(
          color: white,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
      ],
    );
  }
}
