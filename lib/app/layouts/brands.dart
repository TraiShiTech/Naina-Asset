import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:properties/core/core.dart';

import '../../core/utils/methods.dart';
import '../../core/utils/metrics.dart';
import '../widgets/base_container.dart';
import '../with_us.dart';

class Brands extends StatelessWidget {
  const Brands({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 976, max: 1440, data: Metrics.width(context));
    return BaseContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 40 +
                50 *
                    normalize(
                        min: 576, max: 1440, data: Metrics.width(context))),
        child: Metrics.isMobile(context)
            ? Column(
                children: [
                  SvgPicture.asset(
                    'Amazon.svg'.icon,
                    height: 40,
                  ),
                  const SizedBox(height: 32),
                  SvgPicture.asset(
                    'Autodesk.svg'.icon,
                    height: 40,
                  ),
                  const SizedBox(height: 32),
                  SvgPicture.asset(
                    'Google.svg'.icon,
                    height: 40,
                  ),
                  const SizedBox(height: 32),
                  SvgPicture.asset(
                    'Paypal.svg'.icon,
                    height: 40,
                  ),
                  const SizedBox(height: 32),
                  SvgPicture.asset(
                    'Webflow.svg'.icon,
                    height: 40,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WistUs(),
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          height: 70,
                          decoration: BoxDecoration(
                            color: brown,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Center(
                            child: 'List with Us '.poppins(
                              color: white,
                              fontSize: 15 + 4 * pad,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(50.0 * pad),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(
                            'Amazon.svg'.icon,
                            height: 40,
                          ),
                          SvgPicture.asset(
                            'Autodesk.svg'.icon,
                            height: 40,
                          ),
                          SvgPicture.asset(
                            'Google.svg'.icon,
                            height: 40,
                          ),
                          SvgPicture.asset(
                            'Paypal.svg'.icon,
                            height: 40,
                          ),
                          SvgPicture.asset(
                            'Webflow.svg'.icon,
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
