import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me/Utility/style_util.dart';
import 'package:me/controller/super_user_controller.dart';
import 'package:me/service/firebase_auth_services.dart';
import 'package:url_launcher/url_launcher.dart';

class SuperUserPage extends StatefulWidget {
  final User user;

  const SuperUserPage({super.key, required this.user});

  @override
  State<SuperUserPage> createState() => _SuperUserPageState();
}

class _SuperUserPageState extends State<SuperUserPage> {
  final SuperUserController _superUserController = SuperUserController();
  final StyleUtil _styleUtil = StyleUtil();

  // final TextEditingController _projectImageBase64Controller = TextEditingController();
  Uint8List? _uint8listProjectImage; // For save the image uint8list temporary
  String? _resultBase64ProjectImage; // For save the image base64 temporary to database
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _projectDescController = TextEditingController();
  final TextEditingController _projectCategoryController =
      TextEditingController();

  final TextEditingController _creatorNameController = TextEditingController();

  // final TextEditingController _creatorPhotoProfileBase64Controller = TextEditingController();
  Uint8List? _uint8listCreatorProfileImage; // For save the image uint8list temporary
  String? _resultBase64CreatorProfileImage; // For save the image base64 temporary to database
  final TextEditingController _creatorGithubLinkController =
      TextEditingController();

  final TextEditingController _dateTimeController = TextEditingController();
  String? _formattedDate;

  final TextEditingController _githubLinkController = TextEditingController();
  final TextEditingController _linkToDemoController = TextEditingController();
  final TextEditingController _additionalLinkController =
      TextEditingController();
  final TextEditingController _additionalLinkDescriptionController =
      TextEditingController();

  FilePickerResult? _pickedFile;

  Map<int, String> _mapCategories = <int, String>{};
  List<String> _listMapCategoriesKey = <String>[];
  bool _imageProjectPreview = false;
  bool _imageCreatorPhotoPreview = false;
  bool _creatorGithubLinkPreview = false;
  bool _linkToGithubPreview = false;
  bool _linkToDemoWebPreview = false;
  bool _additionalLinkPreview = false;
  bool _additionalLinkDescriptionPreview = false;
  List<String> imageFor = ['project', 'creator'];
  int? _timestampProjectCreated;

  void _saveCreation() {
    if (_projectCategoryController.text.isNotEmpty) {
      final text = _projectCategoryController.text;
      _listMapCategoriesKey.add(text);
      _projectCategoryController.clear();
      setState(() {});
    }
  }

  // Open Url
  Future<void> _openUrl(String url) async {
    Uri uri = Uri.parse(url);
    !await launchUrl(uri);
  }

  // Show Snackbar Template
  Future<void> _showSnackbar(String message) async {
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
              color: _styleUtil.c_success_light,
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
  }

  // Clear All Data
  void _clearAllDataProject(){
    setState(() {
      _uint8listProjectImage = Uint8List(0);
      _uint8listCreatorProfileImage = Uint8List(0);

      _resultBase64ProjectImage = null;
      _resultBase64CreatorProfileImage = null;

      _projectNameController.text = "";
      _projectDescController.text = "";
      _projectCategoryController.text = "";
      _creatorNameController.text = "";
      _creatorGithubLinkController.text = "";
      _dateTimeController.text = "";
      _githubLinkController.text = "";
      _linkToDemoController.text = "";
      _additionalLinkController.text = "";
      _additionalLinkDescriptionController.text = "";

      _pickedFile = null;
      _mapCategories.clear();
      _listMapCategoriesKey.clear();

      _imageProjectPreview = false;
      _imageCreatorPhotoPreview = false;
      _creatorGithubLinkPreview = false;
      _linkToGithubPreview = false;
      _linkToDemoWebPreview = false;
      _additionalLinkPreview = false;
      _additionalLinkDescriptionPreview = false;

      _timestampProjectCreated = null;
    });
  }

  // base64 to Uint8List
  // Uint8List _processImageFromBase64(String base64Image){
  //   try{
  //     final Uint8List bytesImage = const Base64Decoder().convert(base64Image.replaceAll(RegExp(r'\s+'), ''));
  //     return bytesImage;
  //   } catch (e) {
  //     final Uint8List bytesImage = Uint8List(0);
  //     return bytesImage;
  //   }
  // }

  void _openImageAndSaveToBase64(String imageForWho) async {
    _pickedFile = await FilePicker.platform.pickFiles();
    if (_pickedFile != null) {
      try {
        setState(() {
          if (imageForWho == imageFor[0]) {
            _uint8listProjectImage = _pickedFile!.files.first.bytes;
            _imageProjectPreview = true;
          } else if (imageForWho == imageFor[1]) {
            _uint8listCreatorProfileImage = _pickedFile!.files.first.bytes;
            _imageCreatorPhotoPreview = true;
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print("Error Image[DEBUG MODE: KHIP01]: $e");
        }
      }
    }
  }

  @override
  void initState() {
    _dateTimeController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuthServices.userSignOut();
                  },
                  child: const Text("Logout kang"),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 15),
                  width: double.maxFinite,
                  child: const Text(
                    "Project Image base64",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              // TextField(
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black, width: 10),
              //     ),
              //   ),
              //   controller: _projectImageBase64Controller,
              //   onSubmitted: (_) {
              //     setState(() {
              //       // _savedProjectImage = _processImageFromBase64(_projectImageBase64Controller.text);
              //       if(_projectImageBase64Controller.text.isNotEmpty || _projectImageBase64Controller.text != ""){
              //         _imageProjectPreview = true;
              //       }
              //     });
              //   },
              // ),
              SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _openImageAndSaveToBase64(imageFor[0]),
                  child: const Center(child: Text("Upload Image")),
                ),
              ),
              Visibility(
                visible: _imageProjectPreview,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 10, top: 15),
                      width: double.maxFinite,
                      child: const Text(
                        "preview",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Image.memory(
                                _uint8listProjectImage ?? Uint8List(0),
                                width: 1125,
                                fit: BoxFit.fitWidth,
                                errorBuilder: (context, object, stackTrace) {
                              return const SizedBox(
                                child:
                                    Center(child: Text("X no images found X")),
                              );
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Image.memory(
                                _uint8listProjectImage ?? Uint8List(0),
                                width: 491,
                                fit: BoxFit.fitWidth,
                                errorBuilder: (context, object, stackTrace) {
                              return const SizedBox(
                                child:
                                    Center(child: Text("X no images found X")),
                              );
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Image.memory(
                                _uint8listProjectImage ?? Uint8List(0),
                                width: 359,
                                fit: BoxFit.fitWidth,
                                errorBuilder: (context, object, stackTrace) {
                              return const SizedBox(
                                child:
                                    Center(child: Text("X no images found X")),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 15),
                  width: double.maxFinite,
                  child: const Text(
                    "Project Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 10),
                  ),
                ),
                controller: _projectNameController,
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 15),
                  width: double.maxFinite,
                  child: const Text(
                    "Project Description",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 10),
                  ),
                ),
                controller: _projectDescController,
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 15),
                  width: double.maxFinite,
                  child: const Text(
                    "Project Categories",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Container(
                margin: EdgeInsets.only(
                    bottom: (_listMapCategoriesKey.isEmpty ||
                            _listMapCategoriesKey == [])
                        ? 20
                        : 0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 10),
                    ),
                  ),
                  controller: _projectCategoryController,
                  onSubmitted: (_) => _saveCreation(),
                ),
              ),
              Visibility(
                visible: (_listMapCategoriesKey.isEmpty ||
                        _listMapCategoriesKey == [])
                    ? false
                    : true,
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  height: 40,
                  child: ListView.builder(
                    itemCount: _listMapCategoriesKey.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final key = _listMapCategoriesKey[index];
                      return Container(
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.only(right: 15),
                        // padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                              child: Center(
                                child: Text(key),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              height: double.maxFinite,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  padding: const EdgeInsets.all(0),
                                  elevation: 0,
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _listMapCategoriesKey
                                        .remove(_listMapCategoriesKey[index]);
                                  });
                                },
                                child: const Center(
                                    child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 15),
                  width: double.maxFinite,
                  child: const Text(
                    "Creator Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 10),
                  ),
                ),
                controller: _creatorNameController,
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 15),
                  width: double.maxFinite,
                  child: const Text(
                    "Creator Photo Profile base64",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              // TextField(
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(color: Colors.black, width: 10),
              //     ),
              //   ),
              //   controller: _creatorPhotoProfileBase64Controller,
              //   onSubmitted: (_){
              //     setState(() {
              //       // _savedProjectImage = _processImageFromBase64(_projectImageBase64Controller.text);
              //       if(_creatorPhotoProfileBase64Controller.text.isNotEmpty || _creatorPhotoProfileBase64Controller.text != ""){
              //         _imageCreatorPhotoPreview = true;
              //       }
              //     });
              //   },
              // ),

              SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _openImageAndSaveToBase64(imageFor[1]),
                  child: const Center(child: Text("Upload Image")),
                ),
              ),
              Visibility(
                visible: _imageCreatorPhotoPreview,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 10, top: 15),
                      width: double.maxFinite,
                      child: const Text(
                        "preview",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.memory(
                                    _uint8listCreatorProfileImage ??
                                        Uint8List(0),
                                    width: 60,
                                    height: 60, errorBuilder:
                                        (context, object, stackTrace) {
                                  return const SizedBox(
                                    height: 60,
                                    child: Center(
                                        child: Text("X no images found X")),
                                  );
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.memory(
                                    _uint8listCreatorProfileImage ??
                                        Uint8List(0),
                                    width: 32,
                                    height: 32, errorBuilder:
                                        (context, object, stackTrace) {
                                  return const SizedBox(
                                    height: 60,
                                    child: Center(
                                        child: Text("X no images found X")),
                                  );
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.memory(
                                    _uint8listCreatorProfileImage ??
                                        Uint8List(0),
                                    width: 24,
                                    height: 24, errorBuilder:
                                        (context, object, stackTrace) {
                                  return const SizedBox(
                                    height: 60,
                                    child: Center(
                                        child: Text("X no images found X")),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 15),
                  width: double.maxFinite,
                  child: const Text(
                    "Creator Github Link",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Padding(
                padding: EdgeInsets.only(
                    bottom: (_creatorGithubLinkPreview) ? 10 : 30),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 10),
                    ),
                  ),
                  controller: _creatorGithubLinkController,
                  onSubmitted: (_) =>
                      setState(() => _creatorGithubLinkPreview = true),
                ),
              ),
              Visibility(
                visible: _creatorGithubLinkPreview,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: _linkPreviewWidget(_creatorGithubLinkController.text),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 15),
                  width: double.maxFinite,
                  child: const Text(
                    "Date Created",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 10),
                    ),
                    icon: Icon(Icons.date_range_outlined),
                    labelText: "Enter Date",
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: (_dateTimeController.text != "")
                          ? DateTime.parse(_dateTimeController.text)
                          : DateTime.now(),
                      firstDate: DateTime(2015),
                      lastDate: DateTime(DateTime.now().year + 1),
                    );

                    if (pickedDate != null) {
                      if (kDebugMode) {
                        print("Picked Date: $pickedDate");
                      }

                      _formattedDate =
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(pickedDate);
                      if (kDebugMode) {
                        print("Formated Date: $_formattedDate");
                      }

                      setState(() {
                        _dateTimeController.text = _formattedDate!;
                      });
                    }
                  },
                  controller: _dateTimeController,
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 15),
                  width: double.maxFinite,
                  child: const Text(
                    "Link to Github",
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                padding:
                    EdgeInsets.only(bottom: (_linkToGithubPreview) ? 10 : 0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 10),
                    ),
                  ),
                  controller: _githubLinkController,
                  onSubmitted: (_) =>
                      setState(() => _linkToGithubPreview = true),
                ),
              ),
              Visibility(
                visible: _linkToGithubPreview,
                child: _linkPreviewWidget(_githubLinkController.text),
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 15),
                  width: double.maxFinite,
                  child: const Text(
                    "Link to Demo Web",
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                padding:
                    EdgeInsets.only(bottom: (_linkToDemoWebPreview) ? 10 : 0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 10),
                    ),
                  ),
                  controller: _linkToDemoController,
                  onSubmitted: (_) =>
                      setState(() => _linkToDemoWebPreview = true),
                ),
              ),
              Visibility(
                visible: _linkToDemoWebPreview,
                child: _linkPreviewWidget(_linkToDemoController.text),
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 15),
                  width: double.maxFinite,
                  child: const Text(
                    "Additional Link",
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                padding:
                    EdgeInsets.only(bottom: (_additionalLinkPreview) ? 10 : 0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 10),
                    ),
                  ),
                  controller: _additionalLinkController,
                  onSubmitted: (_) =>
                      setState(() => _additionalLinkPreview = true),
                ),
              ),
              Visibility(
                visible: _additionalLinkPreview,
                child: _linkPreviewWidget(_additionalLinkController.text),
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 15),
                  width: double.maxFinite,
                  child: const Text(
                    "Additional Link Description",
                    style: TextStyle(fontSize: 20),
                  )),
              Padding(
                padding: EdgeInsets.only(
                    bottom: (_additionalLinkDescriptionPreview) ? 10 : 30),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 10),
                    ),
                  ),
                  controller: _additionalLinkDescriptionController,
                  onSubmitted: (_) =>
                      setState(() => _additionalLinkDescriptionPreview = true),
                ),
              ),
              Visibility(
                visible: _additionalLinkDescriptionPreview,
                child: SizedBox(
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 6, 67, 116),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(bottom: 30),
                      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              "Preview: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Text(
                              "${_additionalLinkController.text} ",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "(${_additionalLinkDescriptionController.text})",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: ElevatedButton(
                  onPressed: _submitNewProject,
                  child: const Text("Submit Kang"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _linkPreviewWidget(String link) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 6, 67, 116),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 5),
                child: Text(
                  "Link Preview: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () async => await _openUrl(link),
                child: Text(
                  link,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitNewProject() async {
    // Preparation
    try {
      // Project image: uint8list -> string base64
      _resultBase64ProjectImage =
          base64Encode(_uint8listProjectImage as List<int>);
      // Creator Photo Profile image: uint8list -> string base64
      _resultBase64CreatorProfileImage =
          base64Encode(_uint8listCreatorProfileImage as List<int>);
      // Save Categories -> map, to be consumsed by the database
      _mapCategories.clear();
      for (int indexKey = 0; indexKey < _listMapCategoriesKey.length; indexKey++) {
        _mapCategories[indexKey] = _listMapCategoriesKey[indexKey];
      }
      // DateTime -> timestamp, to be consumed by the databse
      _timestampProjectCreated = DateTime.parse(_formattedDate!).millisecond;
    } catch (e) {
      if (kDebugMode) print("ERROR when Submit [DEBUG KHIP01]: $e");
      return;
    }

    _superUserController.createNewProject(
        _resultBase64ProjectImage!,
        _creatorNameController.text,
        _projectDescController.text,
        _mapCategories,
        _creatorNameController.text,
        _resultBase64CreatorProfileImage!,
        _creatorGithubLinkController.text,
        _timestampProjectCreated!,
        _githubLinkController.text,
        _linkToDemoController.text,
        _additionalLinkController.text,
        _additionalLinkDescriptionController.text,
    );

    await _showSnackbar("Data Added Successfully!");

    _clearAllDataProject();
  }
}
