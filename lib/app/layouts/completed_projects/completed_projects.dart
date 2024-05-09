import 'package:flutter/material.dart';

import '../../../core/models/completed_project_item_model.dart';
import '../../../core/utils/methods.dart';
import '../../../core/utils/metrics.dart';
import '../../widgets/base_container.dart';
import 'completed_project_item/completed_project_item.dart';
import 'completed_projects_header.dart';
import 'completed_projects_tabs.dart';

class CompletedProjects extends StatelessWidget {
  const CompletedProjects({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));

    return BaseContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 44 + 36 * pad),
          CompletedProjectsHeader(pad: pad),
          const SizedBox(height: 36),
          CompletedProjectsTabs(pad: pad),
          ...List.generate(completedProjects.length, (index) {
            final item = completedProjects[index];
            return CompletedProjectItem(
              item: item,
              isImageLeft: index % 2 == 0,
            );
          }),
          SizedBox(height: 44 + 36 * pad),
        ],
      ),
    );
  }
}
