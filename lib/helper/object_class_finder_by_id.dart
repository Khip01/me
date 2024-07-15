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

HistoryItemData? findHistoryById(String? id){
  if (id == null) return null;
  // Combine All Creations
  List<HistoryItemData> allHistoriesData = [...History.historyDataWork, ...History.historyDataEdu];

  for (int i = 0; i < allHistoriesData.length; i++) {
    if (allHistoriesData[i].historyItemDataId.contains(id)) return allHistoriesData[i];
  }
  return null;
}