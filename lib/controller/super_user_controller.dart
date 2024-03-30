import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class SuperUserController {

  Future<void> createNewProject (
    String projectImage,
    String projectName,
    String projectDescription,
    Map<String, bool> projectCategories,
    String creatorName,
    String creatorPhotoProfile,
    String creatorGithubLink,
    DateTime dateProjectCreated,
    String? linkToGithub,
    String? linkToDemoWeb,
    String? additionalLink,
    String? additionalLinkDescription,
  ) async {
    // init timestamp for the date time
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    int timeStampDateProjectCreated = DateTime.parse(dateFormat.format(dateProjectCreated).toString()).millisecond;

    final postProjectData = {
      "project_image": projectImage,
      "project_name": projectName,
      "project_description": projectDescription,
      "project_categories": projectCategories,
      "creator_name": creatorName,
      "creator_photo_profile": creatorPhotoProfile,
      "creator_github_link": creatorGithubLink,
      "date_project_created": dateProjectCreated,
      "link_to_github":  linkToGithub,
      "link_to_demo_web":  linkToDemoWeb,
      "additional_link":  additionalLink,
      "additional_link_description":  additionalLinkDescription,
    };

    // Get a key for a new Post.
    final newPostKey = FirebaseDatabase.instance.ref().child('creations').push().key;

    // Write the new post's data simultaneously in the posts list and the
    // user's post list.
    final Map<String, Map> updates = {};
    updates['/creations/$newPostKey'] = postProjectData;

    return FirebaseDatabase.instance.ref().update(updates);
  }

}