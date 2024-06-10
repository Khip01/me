part of 'values.dart';

class History {
  static List<HistoryItemData> historyDataWork = [
    Histories.HAWARI_TIGER_ENGINE,
  ];

  static List<HistoryItemData> historyDataEdu = [
    Histories.MALANG_STATE_POLYTECHNIC,
    Histories.VOC_HIGH_SCHOOL,
  ];
}

class Histories {
  static HistoryItemData HAWARI_TIGER_ENGINE = HistoryItemData(
    historyTitle: StringConst.HAWARI_TIGER_ENGINE_TITLE,
    historyYear: StringConst.HAWARI_TIGER_ENGINE_YEAR,
    historyTag: StringConst.HAWARI_TIGER_ENGINE_TAG,
    historyDescription: StringConst.HAWARI_TIGER_ENGINE_DESC,
  );

  static HistoryItemData MALANG_STATE_POLYTECHNIC = HistoryItemData(
    historyTitle: StringConst.MALANG_STATE_POLYTECHNIC_TITLE,
    historyYear: StringConst.MALANG_STATE_POLYTECHNIC_YEAR,
    historyTag: StringConst.MALANG_STATE_POLYTECHNIC_TAG,
    historyDescription: StringConst.MALANG_STATE_POLYTECHNIC_DESC,
  );

  static HistoryItemData VOC_HIGH_SCHOOL = HistoryItemData(
    historyTitle: StringConst.VOC_HIGH_SCHOOL_TITLE,
    historyYear: StringConst.VOC_HIGH_SCHOOL_YEAR,
    historyTag: StringConst.VOC_HIGH_SCHOOL_TAG,
    historyDescription: StringConst.VOC_HIGH_SCHOOL_DESC,
  );
}

class HistoryItemData {
  final String historyTitle;
  final String historyYear;
  final List<String> historyTag;
  final String historyDescription;

  HistoryItemData({
    required this.historyTitle,
    required this.historyYear,
    required this.historyTag,
    required this.historyDescription,
  });
}