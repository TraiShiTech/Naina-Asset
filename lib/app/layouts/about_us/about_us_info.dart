import 'package:flutter/material.dart';
import 'package:properties/core/core.dart';

import '../../widgets/base_container.dart';

class AboutUsInfo extends StatelessWidget {
  const AboutUsInfo({
    Key? key,
    required this.pad,
  }) : super(key: key);

  final double pad;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Column(
        children: [
          const SizedBox(height: 80),
          'NAINA ASSET'.poppins(color: white, fontSize: 52, fontWeight: FontWeight.w600),
          const SizedBox(height: 10),
          'Professional Property Management Services'.poppins(
            color: white,
            fontSize: 25 + 4 * pad,
          ),
          const SizedBox(height: 40),
          if (!Metrics.isMobile(context))
            FractionallySizedBox(
              widthFactor: 0.8,
              child: Container(
                alignment: Alignment.center,
                child:
                    'With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don\'t worry about contacting us. Because we always have good suggestions.'
                        .poppins(
                            fontSize: 14 + 4 * pad,
                            fontWeight: FontWeight.w500,
                            height: 1.75,
                            color: white,
                            textAlign: TextAlign.center),
              ),
            ),
          if (Metrics.isMobile(context))
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 192 * pad),
                        child: 'NAINA ASSET'.poppins(
                          textAlign: TextAlign.center,
                          fontSize: 44 + 20 * pad,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 260.0 * pad),
                        child:
                            'With over 10+ years of experience in real estate industry, we are a real estate development company, which achieves the maximum benefit by meeting the needs of customers and investors. We have a new generation team that understands market trends. When you need the help fornew investors, we have experts to guide you. Don\'t worry about contacting us. Because we always have good suggestions.'
                                .poppins(
                          textAlign: TextAlign.center,
                          fontSize: 14 + 4 * pad,
                          fontWeight: FontWeight.w500,
                          height: 1.75,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
