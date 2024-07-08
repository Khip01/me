import 'package:me/values/values.dart';

ProjectItemData? findProjectById(String? id){
  if (id == null) return null;
  // Combine All Creations
  List<ProjectItemData> allCreationsData = [...Data.highlightedCreations, ...Data.relatedCreations, ...Data.anotherCreations];

  for (int i = 0; i < allCreationsData.length; i++) {
    if (allCreationsData[i].projectId.contains(id)) return allCreationsData[i];
  }
  return null;
}