import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:me/component/components.dart';
import 'package:me/provider/theme_provider.dart';
import 'package:me/Utility/style_util.dart';
import 'package:me/values/values.dart';
import 'package:me/widget/cover_image_sliding_creation.dart';


class CreationDetailPage extends ConsumerStatefulWidget {
  final ProjectItemData selectedProject;

  const CreationDetailPage({
    super.key,
    required this.selectedProject,
  });

  @override
  ConsumerState<CreationDetailPage> createState() => _CreationDetailPageState();
}

class _CreationDetailPageState extends ConsumerState<CreationDetailPage> {
  // General
  StyleUtil _styleUtil = StyleUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _coverSectionSelectedCreation(),
            _contentBodySelectedCreation(),
          ],
        ),
      ),
    );
  }

  Widget _coverSectionSelectedCreation(){
    return CoverImageSlidingCreation(
      isCompactDevice: getIsMobileSize(context) || getIsTabletSize(context),
      selectedProject: widget.selectedProject,
      imageCountToBeShown: widget.selectedProject.projectImagePathList.length,
    );
  }

  Widget _contentBodySelectedCreation() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Center(child: Text("You guys caught Me! I'm still working on this part :)", style: TextStyle(color: ref.watch(isDarkMode) ? _styleUtil.c_255 : _styleUtil.c_33),)),
    );
  }
}
