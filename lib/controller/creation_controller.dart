import 'dart:collection';
// import 'dart:isolate';

import 'package:firebase_database/firebase_database.dart';

class CreationController{

  final database = FirebaseDatabase.instance;

  Future<Map<String, dynamic>> getCreationsMap() async {
    // Isolate process (Unfortunatelly doesn't support for Flutter Web) :(
    // final data = await Isolate.run(() async {
    //   final snapshot = await database.ref().child('creations').get();
    //
    //   if (!snapshot.exists) {
    //     return <String, dynamic>{};
    //   }
    //
    //   Map<String, dynamic> result = Map<String, dynamic>.from(snapshot.value as Map);
    //   return result;
    // });
    //
    // return data;
    final snapshot = await database.ref().child('creations').get();

    if (!snapshot.exists) {
      return <String, dynamic>{};
    }

    Map<String, dynamic> result = Map<String, dynamic>.from(snapshot.value as Map);
    return result;
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