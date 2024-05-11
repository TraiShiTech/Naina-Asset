import 'package:flutter/material.dart';
import 'package:properties/core/core.dart';

import '../../core/models/how_it_work_card_model.dart';
import '../../core/theme/app_colors.dart';

class HowItWorksCardItem extends StatefulWidget {
  const HowItWorksCardItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final HowItWorkCardModel item;

  @override
  State<HowItWorksCardItem> createState() => _HowItWorksCardItemState();
}

class _HowItWorksCardItemState extends State<HowItWorksCardItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        onEnter: (val) => setState(() => isHover = true),
        onExit: (val) => setState(() => isHover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: isHover ? white : white.withOpacity(0),
            boxShadow: [
              BoxShadow(
                color: isHover
                    ? textPrimary.withOpacity(0.15)
                    : textPrimary.withOpacity(0),
                offset: const Offset(0, 6),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(0),
                    ),
                    color: brown,
                    border: Border.all(
                        color: const Color.fromARGB(255, 163, 161, 161),
                        width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      Icon(
                        widget.item.icon,
                        color: greenBg,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    widget.item.title.poppins(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    const SizedBox(height: 5),
                    widget.item.subtitle.poppins(
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: greenBorder,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
