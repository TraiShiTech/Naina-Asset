import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:properties/core/core.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/methods.dart';
import '../../../core/utils/metrics.dart';
import '../../widgets/base_container.dart';

class ReviewAsset extends StatefulWidget {
  const ReviewAsset({super.key});

  @override
  State<ReviewAsset> createState() => _ReviewAssetState();
}

class _ReviewAssetState extends State<ReviewAsset> {
  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 976, max: 1440, data: Metrics.width(context));
    final isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);

    return Container(
      width: Metrics.width(context),
      height: 300 + 100 * pad,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
        // border: Border.all(
        //     color: const Color.fromARGB(255, 163, 161, 161), width: 1),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.start,
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 50.0 * pad, right: 50.0 * pad),
                    // padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Metrics.isMobile(context)
                            ? 1
                            : Metrics.isCompact(context)
                                ? 2
                                : Metrics.isTablet(context)
                                    ? 2
                                    : 3,
                        childAspectRatio: 3 / 1,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 0,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        // final gridItem = decorativeItems[index];

                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 12 + 12 * pad),
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
                              child: AspectRatio(
                                aspectRatio: 3 / 1,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      color: Colors.grey[350],
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          'Property '.poppins(
                                            color: brown,
                                            fontSize: 15 + 4 * pad,
                                          ),
                                          const SizedBox(height: 10),
                                          'Logements.'.poppins(
                                            textAlign: TextAlign.center,
                                            fontSize: 12 + 4 * pad,
                                            // fontWeight: FontWeight.w500,
                                            height: 1.75,
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                            // AspectRatio(
                            //   aspectRatio: 2 / 1,
                            //   child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(20),
                            //     child: Image.network(
                            //       'https://images.unsplash.com/photo-1611967164521-abae8fba4668?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
                            Positioned(
                                top: 15,
                                left: -50,
                                child: CircleAvatar(
                                  backgroundColor: brown2,
                                  radius: 50,
                                  // child: Image.asset(
                                  //   'Clock.png'.image,
                                  //   // width: 80,
                                  //   // height: 80,
                                  // ),
                                )),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
