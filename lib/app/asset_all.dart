import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:properties/app/layouts/header/header_asset_all.dart';
import 'package:properties/app/widgets/base_container.dart';
import 'package:properties/app/widgets/how_it_work_card_item.dart';
import 'package:properties/core/core.dart';

import 'components/appbar/appbar.dart';
import 'layouts/asset_as/asset_management.dart';
import 'layouts/footer/footer.dart';

class AssetAll extends ConsumerStatefulWidget {
  const AssetAll({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AssetAllState();
}

class _AssetAllState extends ConsumerState<AssetAll> {
  int limit = 2; // The maximum number of items you want
  int offset = 0; // The starting index of items you want
  int endIndex = 0;
///////----------------------------------------------->
  late ScrollController _baseController;

  final GlobalKey _headerKey = GlobalKey();

///////----------------------------------------------->
  @override
  void initState() {
    _baseController = ScrollController();
    _baseController.addListener(() {
      if (_baseController.offset > 500) {
        ref.read(scrollProvider.notifier).change(true);
      } else {
        ref.read(scrollProvider.notifier).change(false);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _baseController.dispose();
    super.dispose();
  }

///////----------------------------------------------->
  Future scrollToItem(GlobalKey key) async {
    await Scrollable.ensureVisible(key.currentContext!, duration: const Duration(milliseconds: 480));
  }

///////----------------------------------------------->
  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));

    final isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);
    final pad1 = isBigScreen ? 0.0 : normalize(min: 576, max: 976, data: Metrics.width(context));
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        width: Metrics.width(context),
        height: Metrics.height(context),
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _baseController,
              child: Column(
                children: [
                  Header_AssetAll(headerKey: _headerKey),
                  const SizedBox(height: 80),
                  Align(
                    alignment: Alignment.center,
                    child: 'Naina Asset: Professional Rental Property Manager'.poppins(
                      color: brown,
                      fontSize: 25 + 4 * pad,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: '10+ years of experience in hospitality and real estate experience.'.poppinscenter(
                        color: const Color(0xff896e57),
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    child: Column(
                      children: [
                        if (isBigScreen)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              cards.length,
                              (index) => HowItWorksCardItem(
                                item: cards[index],
                              ),
                            ),
                          ),
                        if (Metrics.isCompact(context))
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              2,
                              (index) => HowItWorksCardItem(
                                item: cards[index],
                              ),
                            ),
                          ),
                        if (Metrics.isCompact(context))
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              2,
                              (index) => HowItWorksCardItem(
                                item: cards[index + 2],
                              ),
                            ),
                          ),
                        if (Metrics.isMobile(context))
                          Column(
                            children: List.generate(
                              cards.length,
                              (index) => Row(
                                children: [
                                  HowItWorksCardItem(
                                    item: cards[index],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 80),
                  BaseContainer(
                      child: Column(
                          crossAxisAlignment:
                              Metrics.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                          children: [Asset_Management()])),
                  // Container(
                  //     width: Metrics.width(context),
                  //     decoration: BoxDecoration(
                  //       borderRadius: const BorderRadius.only(
                  //         topLeft: Radius.circular(0),
                  //         topRight: Radius.circular(0),
                  //         bottomLeft: Radius.circular(0),
                  //         bottomRight: Radius.circular(0),
                  //       ),
                  //       // color: white,
                  //       // border: Border.all(
                  //       //     color: const Color.fromARGB(255, 163, 161, 161), width: 1),
                  //       gradient: LinearGradient(
                  //         colors: [
                  //           white,
                  //           Colors.grey[50]!.withOpacity(0.5),
                  //           Colors.grey[100]!.withOpacity(0.5),
                  //           white,
                  //         ],
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.bottomCenter,
                  //       ),
                  //     ),
                  //     child: Asset_Management()),
                  // const SizedBox(height: 80),
                  // BaseContainer(
                  //     child: Column(
                  //         crossAxisAlignment: Metrics.isMobile(context)
                  //             ? CrossAxisAlignment.center
                  //             : CrossAxisAlignment.start,
                  //         children: [])),
                  const SizedBox(height: 80),
                  const Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
