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
    historyItemDataId: generateShortUniqueIdFromStrings([
      StringConst.HAWARI_TIGER_ENGINE_TITLE,
      StringConst.HAWARI_TIGER_ENGINE_DESC,
    ]),
    historyTitle: StringConst.HAWARI_TIGER_ENGINE_TITLE,
    historyYear: StringConst.HAWARI_TIGER_ENGINE_YEAR,
    historyTag: StringConst.HAWARI_TIGER_ENGINE_TAG,
    historyDescription: StringConst.HAWARI_TIGER_ENGINE_DESC,
  );

  static HistoryItemData MALANG_STATE_POLYTECHNIC = HistoryItemData(
    historyItemDataId: generateShortUniqueIdFromStrings([
      StringConst.MALANG_STATE_POLYTECHNIC_TITLE,
      StringConst.MALANG_STATE_POLYTECHNIC_DESC,
    ]),
    historyTitle: StringConst.MALANG_STATE_POLYTECHNIC_TITLE,
    historyYear: StringConst.MALANG_STATE_POLYTECHNIC_YEAR,
    historyTag: StringConst.MALANG_STATE_POLYTECHNIC_TAG,
    historyDescription: StringConst.MALANG_STATE_POLYTECHNIC_DESC,
    historyDocumentations: [
      Documentations.DICODING_LEARN_TO_MAKE_FLUTTER_APPS_FOR_BEGINEERS,
      Documentations.DICODING_GETTING_STARTED_PROGRAMMING_WITH_DART,
    ],
  );

  static HistoryItemData VOC_HIGH_SCHOOL = HistoryItemData(
    historyItemDataId: generateShortUniqueIdFromStrings([
      StringConst.VOC_HIGH_SCHOOL_TITLE,
      StringConst.VOC_HIGH_SCHOOL_DESC,
    ]),
    historyTitle: StringConst.VOC_HIGH_SCHOOL_TITLE,
    historyYear: StringConst.VOC_HIGH_SCHOOL_YEAR,
    historyTag: StringConst.VOC_HIGH_SCHOOL_TAG,
    historyDescription: StringConst.VOC_HIGH_SCHOOL_DESC,
    historyDocumentations: [
      Documentations.IT_SOFTWARE_SOLUTIONS_FOR_BUSINESS,
      Documentations.COMPETENCY_TEST_FOR_SOFTWARE_ENGINEERING_EXPERTISE,
      Documentations.PROFESSIONAL_CERTIFICATION_INSTITUTE_EXAM,
      Documentations.TEST_OF_ENGLISH_FOR_INTERNATIONAL_COMMUNICATION,
    ],
  );
}

class HistoryItemData {
  final String historyItemDataId;
  final String historyTitle;
  final String historyYear;
  final List<String> historyTag;
  final String historyDescription;
  final List<HistoryItemDocumentation>? historyDocumentations;

  HistoryItemData({
    required this.historyItemDataId,
    required this.historyTitle,
    required this.historyYear,
    required this.historyTag,
    required this.historyDescription,
    this.historyDocumentations,
  });
}

class Documentations {
  static HistoryItemDocumentation DICODING_LEARN_TO_MAKE_FLUTTER_APPS_FOR_BEGINEERS =
    HistoryItemDocumentation(
      docType:  StringConst.DICODING_LEARN_TO_MAKE_FLUTTER_APPS_FOR_BEGINEERS_DOCTYPE,
      docTitle: StringConst.DICODING_LEARN_TO_MAKE_FLUTTER_APPS_FOR_BEGINEERS_DOCTITLE,
      docDesc: StringConst.DICODING_LEARN_TO_MAKE_FLUTTER_APPS_FOR_BEGINEERS_DOCDESC,
      docImageList: StringConst.DICODING_LEARN_TO_MAKE_FLUTTER_APPS_FOR_BEGINEERS_DOCIMAGELIST,
      docImageListHash: StringConst.DICODING_LEARN_TO_MAKE_FLUTTER_APPS_FOR_BEGINEERS_DOCIMAGELIST_HASH,
      docFileLink: StringConst.DICODING_LEARN_TO_MAKE_FLUTTER_APPS_FOR_BEGINEERS_DOCFILELINK,
      docRelatedProjects: [
        Projects.RESTAURANT_KHIP01,
      ],
    );

  static HistoryItemDocumentation DICODING_GETTING_STARTED_PROGRAMMING_WITH_DART =
    HistoryItemDocumentation(
      docType: StringConst.DICODING_GETTING_STARTED_PROGRAMMING_WITH_DART_DOCTYPE,
      docTitle: StringConst.DICODING_GETTING_STARTED_PROGRAMMING_WITH_DART_DOCTITLE,
      docDesc: StringConst.DICODING_GETTING_STARTED_PROGRAMMING_WITH_DART_DOCDESC,
      docImageList: StringConst.DICODING_GETTING_STARTED_PROGRAMMING_WITH_DART_DOCIMAGELIST,
      docImageListHash: StringConst.DICODING_GETTING_STARTED_PROGRAMMING_WITH_DART_DOCIMAGELIST_HASH,
      docFileLink: StringConst.DICODING_GETTING_STARTED_PROGRAMMING_WITH_DART_DOCFILELINK,
    );

  static HistoryItemDocumentation IT_SOFTWARE_SOLUTIONS_FOR_BUSINESS =
    HistoryItemDocumentation(
      docType: StringConst.IT_SOFTWARE_SOLUTIONS_FOR_BUSINESS_DOCTYPE,
      docTitle: StringConst.IT_SOFTWARE_SOLUTIONS_FOR_BUSINESS_DOCTITLE,
      docDesc: StringConst.IT_SOFTWARE_SOLUTIONS_FOR_BUSINESS_DOCDESC,
      docImageList: StringConst.IT_SOFTWARE_SOLUTIONS_FOR_BUSINESS_DOCIMAGELIST,
      docImageListHash: StringConst.IT_SOFTWARE_SOLUTIONS_FOR_BUSINESS_DOCIMAGELIST_HASH,
      docFileLink: StringConst.IT_SOFTWARE_SOLUTIONS_FOR_BUSINESS_DOCFILELINK,
    );

  static HistoryItemDocumentation COMPETENCY_TEST_FOR_SOFTWARE_ENGINEERING_EXPERTISE =
    HistoryItemDocumentation(
      docType: StringConst.COMPETENCY_TEST_FOR_SOFTWARE_ENGINEERING_EXPERTISE_DOCTYPE,
      docTitle: StringConst.COMPETENCY_TEST_FOR_SOFTWARE_ENGINEERING_EXPERTISE_DOCTITLE,
      docDesc: StringConst.COMPETENCY_TEST_FOR_SOFTWARE_ENGINEERING_EXPERTISE_DOCDESC,
      docImageList: StringConst.COMPETENCY_TEST_FOR_SOFTWARE_ENGINEERING_EXPERTISE_DOCIMAGELIST,
      docImageListHash: StringConst.COMPETENCY_TEST_FOR_SOFTWARE_ENGINEERING_EXPERTISE_DOCIMAGELIST_HASH,
      docFileLink: StringConst.COMPETENCY_TEST_FOR_SOFTWARE_ENGINEERING_EXPERTISE_DOCFILELINK,
      docRelatedProjects: [
        Projects.CAFEAPP_KHIPCAFE,
      ],
    );

  static HistoryItemDocumentation PROFESSIONAL_CERTIFICATION_INSTITUTE_EXAM =
    HistoryItemDocumentation(
      docType: StringConst.PROFESSIONAL_CERTIFICATION_INSTITUTE_EXAM_DOCTYPE,
      docTitle: StringConst.PROFESSIONAL_CERTIFICATION_INSTITUTE_EXAM_DOCTITLE,
      docDesc: StringConst.PROFESSIONAL_CERTIFICATION_INSTITUTE_EXAM_DOCDESC,
      docImageList: StringConst.PROFESSIONAL_CERTIFICATION_INSTITUTE_EXAM_DOCIMAGELIST,
      docImageListHash: StringConst.PROFESSIONAL_CERTIFICATION_INSTITUTE_EXAM_DOCIMAGELIST_HASH,
      docFileLink: StringConst.PROFESSIONAL_CERTIFICATION_INSTITUTE_EXAM_DOCFILELINK,
    );

  static HistoryItemDocumentation TEST_OF_ENGLISH_FOR_INTERNATIONAL_COMMUNICATION =
    HistoryItemDocumentation(
      docType: StringConst.TEST_OF_ENGLISH_FOR_INTERNATIONAL_COMMUNICATION_DOCTYPE,
      docTitle: StringConst.TEST_OF_ENGLISH_FOR_INTERNATIONAL_COMMUNICATION_DOCTITLE,
      docDesc: StringConst.TEST_OF_ENGLISH_FOR_INTERNATIONAL_COMMUNICATION_DOCDESC,
      docImageList: StringConst.TEST_OF_ENGLISH_FOR_INTERNATIONAL_COMMUNICATION_DOCIMAGELIST,
      docImageListHash: StringConst.TEST_OF_ENGLISH_FOR_INTERNATIONAL_COMMUNICATION_DOCIMAGELIST_HASH,
      docFileLink: StringConst.TEST_OF_ENGLISH_FOR_INTERNATIONAL_COMMUNICATION_DOCFILELINK,
    );
}

class HistoryItemDocumentation {
  final String docType;
  final String docTitle;
  final String docDesc;
  final List<String> docImageList;
  final List<String> docImageListHash;
  final String docFileLink;
  final List<ProjectItemData>? docRelatedProjects;

  HistoryItemDocumentation({
    required this.docType,
    required this.docTitle,
    required this.docDesc,
    required this.docImageList,
    required this.docImageListHash,
    required this.docFileLink,
    this.docRelatedProjects,
  });
}
