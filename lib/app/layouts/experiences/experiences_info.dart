import 'package:flutter/material.dart';
import 'package:properties/core/core.dart';

import 'experiences_info_item.dart';

class ExperiencesInfo extends StatefulWidget {
  const ExperiencesInfo({
    Key? key,
    required this.pad,
    required this.isBigScreen,
  }) : super(key: key);

  final double pad;
  final bool isBigScreen;
  @override
  State<ExperiencesInfo> createState() => _ExperiencesInfoState();
}

class _ExperiencesInfoState extends State<ExperiencesInfo> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: widget.isBigScreen
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          '15'.msMadi(
            color: orange,
            fontSize: 52,
          ),
          'Years of Experiences in Real Estate Industry.'.stixTwoText(
            textAlign: widget.isBigScreen ? TextAlign.left : TextAlign.center,
            color: white,
            fontSize: 25,
            height: 1.5,
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ExperiencesInfoItem(
                  pad: widget.pad, count: '10', title: 'Years of experiences'),
              ExperiencesInfoItem(
                  pad: widget.pad, count: '220+', title: 'Completed Projects'),
              ExperiencesInfoItem(
                  pad: widget.pad, count: '4.5', title: 'Overall Ratings'),
            ],
          ),
        ],
      ),
    );
  }
}
