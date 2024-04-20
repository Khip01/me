import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';

class CreationController{

  final database = FirebaseDatabase.instance;

  Query getCreationsSnapshot() {
    return database.ref().child('creations');
  }

  Map<String, dynamic> sortCreationsHighlight(Map<String, dynamic> creations){
    Map<String, dynamic> sortedCreations = {};
    // Sort Highlighted Only
    creations.forEach((key, value) {
      if(value["isHighlighted"]){
        sortedCreations[key] = value;
      }
    });
    // Sort Date Time Descending (Newest to Oldest) using SplayTree
    sortedCreations = SplayTreeMap<String, dynamic>.from(
      sortedCreations,
      (key1, key2) => sortedCreations[key2]["date_project_created"].compareTo(sortedCreations[key1]["date_project_created"])
    );
    return sortedCreations;
  }

  Map<String, dynamic> sortCreationsRelatedProject(Map<String, dynamic> creations){
    Map<String, dynamic> sortedCreations = {};
    creations.forEach((key, value) {
      if(value["isRelated"]){
        sortedCreations[key] = value;
      }
    });
    // Sort Date Time Descending (Newest to Oldest) using SplayTree
    sortedCreations = SplayTreeMap<String, dynamic>.from(
      sortedCreations,
      (key1, key2) => sortedCreations[key2]["date_project_created"].compareTo(sortedCreations[key1]["date_project_created"])
    );
    return sortedCreations;
  }

  Map<String, dynamic> sortAnotherCreations(Map<String, dynamic> creations){
    Map<String, dynamic> sortedCreations = {};
    creations.forEach((key, value) {
      if(!value["isRelated"] || !value["isHighlighted"]){
        sortedCreations[key] = value;
      }
    });
    // Sort Date Time Descending (Newest to Oldest) using SplayTree
    sortedCreations = SplayTreeMap<String, dynamic>.from(
      sortedCreations,
      (key1, key2) => sortedCreations[key2]["date_project_created"].compareTo(sortedCreations[key1]["date_project_created"])
    );
    return sortedCreations;
  }

}