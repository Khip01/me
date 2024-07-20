import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:me/component/components.dart';
import 'package:me/provider/image_preview_provider.dart';
import 'package:me/provider/theme_provider.dart';
import 'package:me/Utility/style_util.dart';
import 'package:me/utility/icon_util.dart';
import 'package:me/values/values.dart';
import 'package:me/widget/cover_image_sliding_creation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/image_preview.dart';
import '../widget/list_image_section.dart';

class CreationDetailPage extends ConsumerStatefulWidget {
  final ProjectItemData selectedProject;
  final String? pagePopTo; // Page Name that will be landed after pop

  const CreationDetailPage({
    super.key,
    required this.selectedProject,
    required this.pagePopTo,
  });

  @override
  ConsumerState<CreationDetailPage> createState() => _CreationDetailPageState();
}

class _CreationDetailPageState extends ConsumerState<CreationDetailPage> {
  // General
  final StyleUtil _styleUtil = StyleUtil();
  final IconUtil _iconUtil = IconUtil();

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
        body: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  _coverSectionSelectedCreation(),
                  _contentBodySelectedCreation(),
                ],
              ),
            ),
            ImagePreview(
              images: widget.selectedProject.projectImagePathList,
              isPreviewMode: ref.watch(isPreviewMode),
            ),
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
      onTapPopRoute: (){
        if (widget.pagePopTo != null){
          context.go(widget.pagePopTo!);
        } else {
          context.goNamed("creation");
        }
      },
    );
  }

  Widget _contentBodySelectedCreation() {
    return Container(
      padding: contentCardPaddingAround(context),
      width: MediaQuery.sizeOf(context).width,
      color: (ref.watch(isDarkMode)) ? _styleUtil.c_33 : _styleUtil.c_255,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 93 +  (getIsMobileSize(context) ? 71 : 0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      ListImageSection(
                        images: widget.selectedProject.projectImagePathList,
                        listViewHeight: 360 - (getIsMobileSize(context) ? 101 : getIsTabletSize(context) ? 51: 0) - 16,
                        imageHeight: 310 - (getIsMobileSize(context) ? 101 : getIsTabletSize(context) ? 51: 0) - 16,
                        imageWidth: contentHighlightWidth(context) - 32,
                        listViewCustomPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                        childImageBuilder: <Widget>(image) {
                         return Image.asset(image, fit: BoxFit.cover);
                        },
                      ),
                      DetailCreationAdditionalInfo(
                        timestampDetailDateCreated: widget.selectedProject.timestampDateCreated,
                        detailProjectData: widget.selectedProject,
                      ),
                      RelatedAboutCreationBottom(
                        requirementData: RelatedSectionObject(
                          creationsData: widget.selectedProject,
                          isShowed: getIsDesktopMdAndBelowSize(context),
                        ),
                      ),
                    ],
                  ),
                ),
                RelatedAboutCreationSide(
                  requirementData: RelatedSectionObject(
                    creationsData: widget.selectedProject,
                    isShowed: !getIsDesktopMdAndBelowSize(context),
                  ),
                ),
              ],
            ),
          ),
          _footerTechnology(),
        ],
      ),
    );
  }

  Widget _footerTechnology(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 39),
      child: Center(
        child: SizedBox(
          width: 125,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Built with  ", style: TextStyle(fontFamily: 'Lato', fontSize: 12, color: _styleUtil.c_170),),
              Tooltip(message: "Flutter Framework", child: Image.asset(_iconUtil.flutterLogo)),
              Text("  and  ", style: TextStyle(fontFamily: 'Lato', fontSize: 12, color: _styleUtil.c_170),),
              Tooltip(message: "Firebase RTDB", child: Image.asset(_iconUtil.firebaseLogoNew)),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailCreationAdditionalInfo extends ConsumerStatefulWidget {
  final int timestampDetailDateCreated;
  final ProjectItemData detailProjectData;

  const DetailCreationAdditionalInfo({
    super.key,
    required this.timestampDetailDateCreated,
    required this.detailProjectData,
  });

  @override
  ConsumerState<DetailCreationAdditionalInfo> createState() => _DetailCreationAdditionalInfoState();
}

class _DetailCreationAdditionalInfoState extends ConsumerState<DetailCreationAdditionalInfo> {
  final StyleUtil _styleUtil = StyleUtil();

  // Open Url
  Future<void> _openUrl(String url) async {
    Uri uri = Uri.parse(url);
    !await launchUrl(uri);
  }

  // Show Snackbar Template
  Future<void> _showSnackbar(String message, String url) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 30),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 5,
              color: (ref.watch(isDarkMode)) ? _styleUtil.c_success_dark : _styleUtil.c_success_light,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 14.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.check_circle,
                        color: _styleUtil.c_255,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        letterSpacing: 1,
                        fontFamily: "Lato",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _styleUtil.c_255,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    await _openUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    DateTime itemDate = DateTime.fromMillisecondsSinceEpoch(widget.timestampDetailDateCreated);
    DateFormat dateFormatter = DateFormat("MMM dd, yyyy");

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: _creatorSection(
            widget.detailProjectData.creatorPhotoProfilePath,
            widget.detailProjectData.creatorName,
            widget.detailProjectData.creatorRole,
            widget.detailProjectData.creatorGithubLink,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: _createdOnSection(dateFormatter.format(itemDate)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: _creationTagSection(),
        ),
      ],
    );
  }

  Widget _creatorSection(List<String> creatorImageProfile, List<String> creatorName, List<String> creatorRole, List<String> creatorLinkProfile){
    return SizedBox(
      width: double.maxFinite,
      child: Wrap(
        spacing: 24,
        runSpacing: 12,
        direction: Axis.horizontal,
        children: List.generate(creatorImageProfile.length, (int index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async => await _showSnackbar("User Profile Opened Successfully!", creatorLinkProfile[index]),
                    child: SizedBox(
                      height: 42,
                      width: 42,
                      child: ClipOval(
                        child: Image.asset(creatorImageProfile[index]),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: SelectionContainer.disabled(
                        child: GestureDetector(
                          onTap: () async => await _showSnackbar("User Profile Opened Successfully!", creatorLinkProfile[index]),
                          child: Text(creatorName[index], style: TextStyle(fontFamily: 'Lato', fontSize: 16, fontWeight: FontWeight.w700, color: (ref.watch(isDarkMode)) ? _styleUtil.c_238 : _styleUtil.c_61),),
                        ),
                      ),
                    ),
                    Text(creatorRole[index], style: TextStyle(fontFamily: 'Lato', fontSize: 16, color: (ref.watch(isDarkMode)) ? _styleUtil.c_170 : _styleUtil.c_61),),
                  ],
                ),
              ),
            ],
          );
        }, growable: true),
      ),
    );
  }

  Widget _createdOnSection(String formatedDate){
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Created on", style: TextStyle(fontFamily: 'Lato', fontSize: 16, fontWeight: FontWeight.w700, color: (ref.watch(isDarkMode)) ? _styleUtil.c_238 : _styleUtil.c_61),),
          Text(formatedDate, style: TextStyle(fontFamily: 'Lato', fontSize: 16, color: (ref.watch(isDarkMode)) ? _styleUtil.c_170 : _styleUtil.c_61),),
        ],
      ),
    );
  }

  Widget _creationTagSection(){
    return SizedBox(
      width: double.maxFinite,
      child: Wrap(
        spacing: 7, // spacing horizontally
        runSpacing: 7, // spacing vertically
        children: List.generate(widget.detailProjectData.projectCategories.length, (index){
          return DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _styleUtil.c_238,
                width: 1,
              ),
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 7),
              child: Text(widget.detailProjectData.projectCategories[index], style: TextStyle(fontFamily: 'Lato', fontSize: 16, color: (ref.watch(isDarkMode)) ? _styleUtil.c_238 : _styleUtil.c_61),),
            ),
          );
        }, growable: true),
      ),
    );
  }
}

class RelatedAboutCreationSide extends ConsumerStatefulWidget {
  final RelatedSectionObject requirementData;

  const RelatedAboutCreationSide({
    super.key,
    required this.requirementData,
  });

  @override
  ConsumerState<RelatedAboutCreationSide> createState() => _RelatedAboutCreationSideState();
}

class _RelatedAboutCreationSideState extends ConsumerState<RelatedAboutCreationSide> {
  final IconUtil _iconUtil = IconUtil();
  
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.requirementData.isShowed,
      child: Column(
        children: [
          if (widget.requirementData.creationsData.linkProjectToGithub != "")
            LinkCardItem(
              imgPath: ref.watch(isDarkMode) ? _iconUtil.imgGithubDark : _iconUtil.imgGithubLight,
              title: widget.requirementData.creationsData.projectName,
              desc: "see the repository",
              paddingTop: 28,
              link: widget.requirementData.creationsData.linkProjectToGithub,
              isCompactDeviceMode: getIsMobileSize(context) || getIsTabletSize(context),
            ),
          if (widget.requirementData.creationsData.linkDemoWeb != "")
            LinkCardItem(
              imgPath: ref.watch(isDarkMode) ? _iconUtil.imgBrowserDark : _iconUtil.imgBrowserLight,
              title: "Site",
              desc: "visit the site",
              paddingTop: 14,
              link: widget.requirementData.creationsData.linkDemoWeb,
              isCompactDeviceMode: getIsMobileSize(context) || getIsTabletSize(context),
            ),
          if (widget.requirementData.creationsData.additionalLink != "")
            LinkCardItem(
              imgPath: ref.watch(isDarkMode) ? _iconUtil.imgLinkDark : _iconUtil.imgLinkLight,
              title: "Additional Link",
              desc: widget.requirementData.creationsData.additionalLinkDescription,
              paddingTop: 14,
              link: widget.requirementData.creationsData.additionalLink,
              isCompactDeviceMode: getIsMobileSize(context) || getIsTabletSize(context),
            ),
          // Container(
          //   margin: const EdgeInsets.only(left: 28),
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   height: 500,
          //   width: 300,
          //   child: const Center(child: Text("Related Project, this section is coming soon")),
          // ),
        ],
      ),
    );
  }
}

class RelatedAboutCreationBottom extends ConsumerStatefulWidget{
  final RelatedSectionObject requirementData;

  const RelatedAboutCreationBottom({
    super.key,
    required this.requirementData,
  });

  @override
  ConsumerState<RelatedAboutCreationBottom> createState() => _RelatedAboutCreationBottomState();
}

class _RelatedAboutCreationBottomState extends ConsumerState<RelatedAboutCreationBottom> {
  final IconUtil _iconUtil = IconUtil();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.requirementData.isShowed,
      child: Padding(
        padding: const EdgeInsets.only(top: 45),
        child: SizedBox(
          width: double.maxFinite,
          child: _linkCardWidgetDecider(MediaQuery.sizeOf(context).width <= 850),
        ),
      ),
    );
  }

  Widget _linkCardWidgetDecider(bool isVeryCompactDeviceMode){
    if (isVeryCompactDeviceMode) { // 1 Column List Link Card
      return ListView(
        shrinkWrap: true,
        physics: const  NeverScrollableScrollPhysics(),
        children: [
          if (widget.requirementData.creationsData.linkProjectToGithub != "")
            LinkCardItem(
              imgPath: ref.watch(isDarkMode) ? _iconUtil.imgGithubDark : _iconUtil.imgGithubLight,
              title: widget.requirementData.creationsData.projectName,
              desc: "see the repository",
              customSnackbarTitle: "Github Repo",
              cardWidth: double.maxFinite,
              paddingTop: 0,
              paddingLeft: 0,
              link: widget.requirementData.creationsData.linkProjectToGithub,
              isCompactDeviceMode: getIsMobileSize(context) || getIsTabletSize(context),
            ),
          if (widget.requirementData.creationsData.linkDemoWeb != "")
            LinkCardItem(
              imgPath: ref.watch(isDarkMode) ? _iconUtil.imgBrowserDark : _iconUtil.imgBrowserLight,
              title: "Site",
              desc: "visit the site",
              cardWidth: double.maxFinite,
              paddingTop: 14,
              paddingLeft: 0,
              link: widget.requirementData.creationsData.linkDemoWeb,
              isCompactDeviceMode: getIsMobileSize(context) || getIsTabletSize(context),
            ),
          if (widget.requirementData.creationsData.additionalLink != "")
            LinkCardItem(
              imgPath: ref.watch(isDarkMode) ? _iconUtil.imgLinkDark : _iconUtil.imgLinkLight,
              title: "Additional Link",
              desc: widget.requirementData.creationsData.additionalLinkDescription,
              cardWidth: double.maxFinite,
              paddingTop: 14,
              paddingLeft: 0,
              link: widget.requirementData.creationsData.additionalLink,
              isCompactDeviceMode: getIsMobileSize(context) || getIsTabletSize(context),
            ),
        ],
      );
    } else { // 2 Column List Link card
      return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 28,
        crossAxisSpacing: 28,
        shrinkWrap: true,
        childAspectRatio: 4 / 1,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          if (widget.requirementData.creationsData.linkProjectToGithub != "")
            LinkCardItem(
              imgPath: ref.watch(isDarkMode) ? _iconUtil.imgGithubDark : _iconUtil.imgGithubLight,
              title: widget.requirementData.creationsData.projectName,
              desc: "see the repository",
              cardWidth: double.maxFinite,
              paddingTop: 0,
              paddingLeft: 0,
              link: widget.requirementData.creationsData.linkProjectToGithub,
              isCompactDeviceMode: getIsMobileSize(context) || getIsTabletSize(context),
            ),
          if (widget.requirementData.creationsData.linkDemoWeb != "")
            LinkCardItem(
              imgPath: ref.watch(isDarkMode) ? _iconUtil.imgBrowserDark : _iconUtil.imgBrowserLight,
              title: "Site",
              desc: "visit the site",
              cardWidth: double.maxFinite,
              paddingTop: 0,
              paddingLeft: 0,
              link: widget.requirementData.creationsData.linkDemoWeb,
              isCompactDeviceMode: getIsMobileSize(context) || getIsTabletSize(context),
            ),
          if (widget.requirementData.creationsData.additionalLink != "")
            LinkCardItem(
              imgPath: ref.watch(isDarkMode) ? _iconUtil.imgLinkDark : _iconUtil.imgLinkLight,
              title: "Additional Link",
              desc: widget.requirementData.creationsData.additionalLinkDescription,
              cardWidth: double.maxFinite,
              paddingTop: 0,
              paddingLeft: 0,
              link: widget.requirementData.creationsData.additionalLink,
              isCompactDeviceMode: getIsMobileSize(context) || getIsTabletSize(context),
            ),
        ],
      );
    }
  }
}

class LinkCardItem extends ConsumerStatefulWidget {
  final String imgPath;
  final String title;
  final String desc;
  final String? customSnackbarTitle;
  final double? cardWidth;
  final double? paddingTop;
  final double? paddingLeft;
  final String link;
  final bool isCompactDeviceMode;

  const LinkCardItem({
    super.key,
    required this.imgPath,
    required this.title,
    required this.desc,
    this.customSnackbarTitle,
    this.cardWidth,
    this.paddingTop,
    this.paddingLeft,
    required this.link,
    required this.isCompactDeviceMode,
  });

  @override
  ConsumerState<LinkCardItem> createState() => _LinkCardItemState();
}

class _LinkCardItemState extends ConsumerState<LinkCardItem> {
  final StyleUtil _styleUtil = StyleUtil();

  bool cardIsHovered = false;

  // Open Url
  Future<void> _openUrl(String url) async {
    Uri uri = Uri.parse(url);
    !await launchUrl(uri);
  }

  // Show Snackbar Template
  Future<void> _showSnackbar(String message, String url) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 30),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 5,
              color: (ref.watch(isDarkMode)) ? _styleUtil.c_success_dark : _styleUtil.c_success_light,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 14.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.check_circle,
                        color: _styleUtil.c_255,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        letterSpacing: 1,
                        fontFamily: "Lato",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: _styleUtil.c_255,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    await _openUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => await _showSnackbar("${widget.customSnackbarTitle ?? widget.title} Opened Successfully!", widget.link),
      onHover: (val) => setState(() => cardIsHovered = val),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.cardWidth ?? 350,
        margin: EdgeInsets.only(left: widget.paddingLeft ?? 28, top: widget.paddingTop ?? 28),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: ref.watch(isDarkMode) ? _styleUtil.c_170 : _styleUtil.c_238,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
          gradient: gradientColorAnimationDecider(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset(widget.imgPath, width: 36),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color:  (ref.watch(isDarkMode)) ? _styleUtil.c_238 : _styleUtil.c_61,
                    ),
                  ),
                  Text(
                    widget.desc,
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 16,
                        color: (ref.watch(isDarkMode)) ? _styleUtil.c_170 : _styleUtil.c_61
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity:  opacityAnimationDecider(),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(Icons.arrow_forward_ios, color: ref.watch(isDarkMode) ? _styleUtil.c_238 : _styleUtil.c_61),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient gradientColorAnimationDecider(){
    if(widget.isCompactDeviceMode){ // Compact device Mode
      return const LinearGradient(colors: [Colors.transparent, Colors.transparent]);
    }

    if(cardIsHovered){ // Card is Hovered
      return LinearGradient(
        begin: Alignment.center,
        end: Alignment.centerRight,
        colors: [
          Colors.transparent,
          ref.watch(isDarkMode) ? _styleUtil.c_238.withOpacity(0.5) : _styleUtil.c_170.withOpacity(0.1),
        ],
      );
    } else {
      return const LinearGradient(colors: [Colors.transparent, Colors.transparent]);
    }
  }

  double opacityAnimationDecider(){
    if (widget.isCompactDeviceMode) return 1; // Compact device Mode

    return (cardIsHovered) ? 1 : 0; // Determine Card Hover
  }
}

// BLUEPRINT CLASS
class RelatedSectionObject{
  final ProjectItemData creationsData;
  final bool isShowed;

  RelatedSectionObject({
    required this.creationsData,
    required this.isShowed,
  });
}




