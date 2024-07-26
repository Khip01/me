part of 'values.dart';

class Data {
  static List<ProjectItemData> highlightedCreations = [
    Projects.FLUTTER_PORTFOLIO,
    Projects.COMMENT_SECTION_WEB,
    Projects.RESTAURANT_KHIP01,
  ];

  static List<ProjectItemData> relatedCreations = [
    Projects.FLUTTER_PORTFOLIO,
    Projects.COMMENT_SECTION_WEB,
    Projects.RESTAURANT_KHIP01,
  ];

  static List<ProjectItemData> anotherCreations = [
    Projects.CAFEAPP_KHIPCAFE,
    Projects.SPPPAYMENT_SPPPAY_V2,
    Projects.SPPPAYMENT_SPPPAY,
    Projects.FIRST_WEB_PORTFOLIO,
    Projects.CALCULATOR_GUI_JAVA,
    Projects.ROCK_PAPPER_SCISSORS_GAME,
    Projects.KALKULATOR_BASIC_CPP,
  ];
}

class Projects {
  static ProjectItemData CAFEAPP_KHIPCAFE = ProjectItemData(
    projectId: generateShortUniqueIdFromTimestamp(StringConst.CAFEAPP_KHIPCAFE_DATE_PROJECT_CREATED),
    projectImagePathCover: ImagePath.CAFEAPP_KHIPCAFE_C,
    projectImagePathCoverHash: ImagePath.CAFEAPP_KHIPCAFE_C_HASH,
    projectImagePathList: [
      ImagePath.CAFEAPP_KHIPCAFE_C,
    ],
    projectImagePathListHash: [
      ImagePath.CAFEAPP_KHIPCAFE_C_HASH,
    ],
    projectName: StringConst.CAFEAPP_KHIPCAFE_PROJECT_NAME,
    projectDescription: StringConst.CAFEAPP_KHIPCAFE_PROJECT_DESCRIPTION,
    projectCategories: StringConst.CAFEAPP_KHIPCAFE_PROJECT_CATEGORIES,
    creatorName: StringConst.CAFEAPP_KHIPCAFE_CREATOR_NAME,
    creatorRole: StringConst.CAFEAPP_KHIPCAFE_CREATOR_ROLE,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE,
    ],
    creatorPhotoProfilePathHash: [
      ImagePath.KHIP01_PHOTO_PROFILE_HASH,
    ],
    creatorGithubLink: StringConst.CAFEAPP_KHIPCAFE_CREATOR_GITHUB_LINK,
    timestampDateCreated: StringConst.CAFEAPP_KHIPCAFE_DATE_PROJECT_CREATED,
    isProjectRelated: false,
    isProjectHighlighted: false,
    linkProjectToGithub: StringConst.CAFEAPP_KHIPCAFE_PROJECT_LINK_TO_GITHUB,
    linkDemoWeb: StringConst.CAFEAPP_KHIPCAFE_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.CAFEAPP_KHIPCAFE_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.CAFEAPP_KHIPCAFE_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData SPPPAYMENT_SPPPAY_V2 = ProjectItemData(
    projectId: generateShortUniqueIdFromTimestamp(StringConst.SPPPAYMENT_SPPPAY_V2_DATE_PROJECT_CREATED),
    projectImagePathCover: ImagePath.SPPPAYMENT_SPPPAY_V2_C,
    projectImagePathCoverHash: ImagePath.SPPPAYMENT_SPPPAY_V2_C_HASH,
    projectImagePathList: [
      ImagePath.SPPPAYMENT_SPPPAY_V2_C,
      ImagePath.SPPPAYMENT_SPPPAY_V2_2,
      ImagePath.SPPPAYMENT_SPPPAY_V2_3,
    ],
    projectImagePathListHash: [
      ImagePath.SPPPAYMENT_SPPPAY_V2_C_HASH,
      ImagePath.SPPPAYMENT_SPPPAY_V2_2_HASH,
      ImagePath.SPPPAYMENT_SPPPAY_V2_3_HASH,
    ],
    projectName: StringConst.SPPPAYMENT_SPPPAY_V2_PROJECT_NAME,
    projectDescription: StringConst.SPPPAYMENT_SPPPAY_V2_PROJECT_DESCRIPTION,
    projectCategories: StringConst.SPPPAYMENT_SPPPAY_V2_PROJECT_CATEGORIES,
    creatorName: StringConst.SPPPAYMENT_SPPPAY_V2_CREATOR_NAME,
    creatorRole: StringConst.SPPPAYMENT_SPPPAY_V2_CREATOR_ROLE,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE,
    ],
    creatorPhotoProfilePathHash: [
      ImagePath.KHIP01_PHOTO_PROFILE_HASH,
    ],
    creatorGithubLink: StringConst.SPPPAYMENT_SPPPAY_V2_CREATOR_GITHUB_LINK,
    timestampDateCreated: StringConst.SPPPAYMENT_SPPPAY_V2_DATE_PROJECT_CREATED,
    isProjectRelated: false,
    isProjectHighlighted: false,
    linkProjectToGithub: StringConst.SPPPAYMENT_SPPPAY_V2_PROJECT_LINK_TO_GITHUB,
    linkDemoWeb: StringConst.SPPPAYMENT_SPPPAY_V2_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.SPPPAYMENT_SPPPAY_V2_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.SPPPAYMENT_SPPPAY_V2_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData ROCK_PAPPER_SCISSORS_GAME = ProjectItemData(
    projectId: generateShortUniqueIdFromTimestamp(StringConst.ROCK_PAPPER_SCISSORS_GAME_DATE_PROJECT_CREATED),
    projectImagePathCover: ImagePath.ROCK_PAPPER_SCISSORS_GAME_C,
    projectImagePathCoverHash: ImagePath.ROCK_PAPPER_SCISSORS_GAME_C_HASH,
    projectImagePathList: [
      ImagePath.ROCK_PAPPER_SCISSORS_GAME_C,
      ImagePath.ROCK_PAPPER_SCISSORS_GAME_2,
    ],
    projectImagePathListHash: [
      ImagePath.ROCK_PAPPER_SCISSORS_GAME_C_HASH,
      ImagePath.ROCK_PAPPER_SCISSORS_GAME_2_HASH,
    ],
    projectName: StringConst.ROCK_PAPPER_SCISSORS_GAME_PROJECT_NAME,
    projectDescription: StringConst.ROCK_PAPPER_SCISSORS_GAME_PROJECT_DESCRIPTION,
    projectCategories: StringConst.ROCK_PAPPER_SCISSORS_GAME_PROJECT_CATEGORIES,
    creatorName: StringConst.ROCK_PAPPER_SCISSORS_GAME_CREATOR_NAME,
    creatorRole: StringConst.ROCK_PAPPER_SCISSORS_GAME_CREATOR_ROLE,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE,
    ],
    creatorPhotoProfilePathHash: [
      ImagePath.KHIP01_PHOTO_PROFILE_HASH,
    ],
    creatorGithubLink: StringConst.ROCK_PAPPER_SCISSORS_GAME_CREATOR_GITHUB_LINK,
    timestampDateCreated: StringConst.ROCK_PAPPER_SCISSORS_GAME_DATE_PROJECT_CREATED,
    isProjectRelated: false,
    isProjectHighlighted: false,
    linkProjectToGithub: StringConst.ROCK_PAPPER_SCISSORS_GAME_PROJECT_LINK_TO_GITHUB,
    linkDemoWeb: StringConst.ROCK_PAPPER_SCISSORS_GAME_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.ROCK_PAPPER_SCISSORS_GAME_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.ROCK_PAPPER_SCISSORS_GAME_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData SPPPAYMENT_SPPPAY = ProjectItemData(
    projectId: generateShortUniqueIdFromTimestamp(StringConst.SPPPAYMENT_SPPPAY_DATE_PROJECT_CREATED),
    projectImagePathCover: ImagePath.SPPPAYMENT_SPPPAY_C,
    projectImagePathCoverHash: ImagePath.SPPPAYMENT_SPPPAY_C_HASH,
    projectImagePathList: [
      ImagePath.SPPPAYMENT_SPPPAY_C,
      ImagePath.SPPPAYMENT_SPPPAY_2,
    ],
    projectImagePathListHash: [
      ImagePath.SPPPAYMENT_SPPPAY_C_HASH,
      ImagePath.SPPPAYMENT_SPPPAY_2_HASH,
    ],
    projectName: StringConst.SPPPAYMENT_SPPPAY_PROJECT_NAME,
    projectDescription: StringConst.SPPPAYMENT_SPPPAY_PROJECT_DESCRIPTION,
    projectCategories: StringConst.SPPPAYMENT_SPPPAY_PROJECT_CATEGORIES,
    creatorName: StringConst.SPPPAYMENT_SPPPAY_CREATOR_NAME,
    creatorRole: StringConst.SPPPAYMENT_SPPPAY_CREATOR_ROLE,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE,
    ],
    creatorPhotoProfilePathHash: [
      ImagePath.KHIP01_PHOTO_PROFILE_HASH,
    ],
    creatorGithubLink: StringConst.SPPPAYMENT_SPPPAY_CREATOR_GITHUB_LINK,
    timestampDateCreated: StringConst.SPPPAYMENT_SPPPAY_DATE_PROJECT_CREATED,
    isProjectRelated: false,
    isProjectHighlighted: false,
    linkProjectToGithub: StringConst.SPPPAYMENT_SPPPAY_PROJECT_LINK_TO_GITHUB,
    linkDemoWeb: StringConst.SPPPAYMENT_SPPPAY_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.SPPPAYMENT_SPPPAY_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.SPPPAYMENT_SPPPAY_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData FIRST_WEB_PORTFOLIO = ProjectItemData(
    projectId: generateShortUniqueIdFromTimestamp(StringConst.FIRST_WEB_PORTFOLIO_DATE_PROJECT_CREATED),
    projectImagePathCover: ImagePath.FIRST_WEB_PORTFOLIO_C,
    projectImagePathCoverHash: ImagePath.FIRST_WEB_PORTFOLIO_C_HASH,
    projectImagePathList: [
      ImagePath.FIRST_WEB_PORTFOLIO_C,
      ImagePath.FIRST_WEB_PORTFOLIO_2,
      ImagePath.FIRST_WEB_PORTFOLIO_3,
    ],
    projectImagePathListHash: [
      ImagePath.FIRST_WEB_PORTFOLIO_C_HASH,
      ImagePath.FIRST_WEB_PORTFOLIO_2_HASH,
      ImagePath.FIRST_WEB_PORTFOLIO_3_HASH,
    ],
    projectName: StringConst.FIRST_WEB_PORTFOLIO_PROJECT_NAME,
    projectDescription: StringConst.FIRST_WEB_PORTFOLIO_PROJECT_DESCRIPTION,
    projectCategories: StringConst.FIRST_WEB_PORTFOLIO_PROJECT_CATEGORIES,
    creatorName: StringConst.FIRST_WEB_PORTFOLIO_CREATOR_NAME,
    creatorRole: StringConst.FIRST_WEB_PORTFOLIO_CREATOR_ROLE,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE,
    ],
    creatorPhotoProfilePathHash: [
      ImagePath.KHIP01_PHOTO_PROFILE_HASH,
    ],
    creatorGithubLink: StringConst.FIRST_WEB_PORTFOLIO_CREATOR_GITHUB_LINK,
    timestampDateCreated: StringConst.FIRST_WEB_PORTFOLIO_DATE_PROJECT_CREATED,
    isProjectRelated: false,
    isProjectHighlighted: false,
    linkProjectToGithub: StringConst.FIRST_WEB_PORTFOLIO_PROJECT_LINK_TO_GITHUB,
    linkDemoWeb: StringConst.FIRST_WEB_PORTFOLIO_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.FIRST_WEB_PORTFOLIO_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.FIRST_WEB_PORTFOLIO_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData CALCULATOR_GUI_JAVA = ProjectItemData(
    projectId: generateShortUniqueIdFromTimestamp(StringConst.CALCULATOR_GUI_JAVA_DATE_PROJECT_CREATED),
    projectImagePathCover: ImagePath.CALCULATOR_GUI_JAVA_C,
    projectImagePathCoverHash: ImagePath.CALCULATOR_GUI_JAVA_C_HASH,
    projectImagePathList: [
      ImagePath.CALCULATOR_GUI_JAVA_C,
    ],
    projectImagePathListHash: [
      ImagePath.CALCULATOR_GUI_JAVA_C_HASH,
    ],
    projectName: StringConst.CALCULATOR_GUI_JAVA_PROJECT_NAME,
    projectDescription: StringConst.CALCULATOR_GUI_JAVA_PROJECT_DESCRIPTION,
    projectCategories: StringConst.CALCULATOR_GUI_JAVA_PROJECT_CATEGORIES,
    creatorName: StringConst.CALCULATOR_GUI_JAVA_CREATOR_NAME,
    creatorRole: StringConst.CALCULATOR_GUI_JAVA_CREATOR_ROLE,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE,
    ],
    creatorPhotoProfilePathHash: [
      ImagePath.KHIP01_PHOTO_PROFILE_HASH,
    ],
    creatorGithubLink: StringConst.CALCULATOR_GUI_JAVA_CREATOR_GITHUB_LINK,
    timestampDateCreated: StringConst.CALCULATOR_GUI_JAVA_DATE_PROJECT_CREATED,
    isProjectRelated: false,
    isProjectHighlighted: false,
    linkProjectToGithub: StringConst.CALCULATOR_GUI_JAVA_PROJECT_LINK_TO_GITHUB,
    linkDemoWeb: StringConst.CALCULATOR_GUI_JAVA_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.CALCULATOR_GUI_JAVA_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.CALCULATOR_GUI_JAVA_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData KALKULATOR_BASIC_CPP = ProjectItemData(
    projectId: generateShortUniqueIdFromTimestamp(StringConst.KALKULATOR_BASIC_CPP_DATE_PROJECT_CREATED),
    projectImagePathCover: ImagePath.KALKULATOR_BASIC_CPP_C,
    projectImagePathCoverHash: ImagePath.KALKULATOR_BASIC_CPP_C_HASH,
    projectImagePathList: [
      ImagePath.KALKULATOR_BASIC_CPP_C,
    ],
    projectImagePathListHash: [
      ImagePath.KALKULATOR_BASIC_CPP_C_HASH,
    ],
    projectName: StringConst.KALKULATOR_BASIC_CPP_PROJECT_NAME,
    projectDescription: StringConst.KALKULATOR_BASIC_CPP_PROJECT_DESCRIPTION,
    projectCategories: StringConst.KALKULATOR_BASIC_CPP_PROJECT_CATEGORIES,
    creatorName: StringConst.KALKULATOR_BASIC_CPP_CREATOR_NAME,
    creatorRole: StringConst.KALKULATOR_BASIC_CPP_CREATOR_ROLE,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE,
    ],
    creatorPhotoProfilePathHash: [
      ImagePath.KHIP01_PHOTO_PROFILE_HASH,
    ],
    creatorGithubLink: StringConst.KALKULATOR_BASIC_CPP_CREATOR_GITHUB_LINK,
    timestampDateCreated: StringConst.KALKULATOR_BASIC_CPP_DATE_PROJECT_CREATED,
    isProjectRelated: false,
    isProjectHighlighted: false,
    linkProjectToGithub: StringConst.KALKULATOR_BASIC_CPP_PROJECT_LINK_TO_GITHUB,
    linkDemoWeb: StringConst.KALKULATOR_BASIC_CPP_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.KALKULATOR_BASIC_CPP_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.KALKULATOR_BASIC_CPP_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData FLUTTER_PORTFOLIO = ProjectItemData(
    projectId: generateShortUniqueIdFromTimestamp(StringConst.FLUTTER_PORTFOLIO_DATE_PROJECT_CREATED),
    projectImagePathCover: ImagePath.FLUTTER_PORTFOLIO_C,
    projectImagePathCoverHash: ImagePath.FLUTTER_PORTFOLIO_C_HASH,
    projectImagePathList: [
      ImagePath.FLUTTER_PORTFOLIO_C,
    ],
    projectImagePathListHash: [
      ImagePath.FLUTTER_PORTFOLIO_C_HASH,
    ],
    projectName: StringConst.FLUTTER_PORTFOLIO_PROJECT_NAME,
    projectDescription: StringConst.FLUTTER_PORTFOLIO_PROJECT_DESCRIPTION,
    projectCategories: StringConst.FLUTTER_PORTFOLIO_PROJECT_CATEGORIES,
    creatorName: StringConst.FLUTTER_PORTFOLIO_CREATOR_NAME,
    creatorRole: StringConst.FLUTTER_PORTFOLIO_CREATOR_ROLE,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE,
    ],
    creatorPhotoProfilePathHash: [
      ImagePath.KHIP01_PHOTO_PROFILE_HASH,
    ],
    creatorGithubLink: StringConst.FLUTTER_PORTFOLIO_CREATOR_GITHUB_LINK,
    timestampDateCreated: StringConst.FLUTTER_PORTFOLIO_DATE_PROJECT_CREATED,
    isProjectRelated: true,
    isProjectHighlighted: true,
    linkProjectToGithub: StringConst.FLUTTER_PORTFOLIO_PROJECT_LINK_TO_GITHUB,
    linkDemoWeb: StringConst.FLUTTER_PORTFOLIO_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.FLUTTER_PORTFOLIO_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.FLUTTER_PORTFOLIO_ADDITIONAL_LINK_DESCRIPTION,
    projectHighlightTopic: StringConst.FLUTTER_PORTFOLIO_HIGHLIGHT_TOPIC,
    projectHighlightHeader: StringConst.FLUTTER_PORTFOLIO_HIGHLIGHT_HEADER,
    projectHighlightDescription: StringConst.FLUTTER_PORTFOLIO_HIGHLIGHT_DESCRIPTION,
  );
  static ProjectItemData COMMENT_SECTION_WEB = ProjectItemData(
    projectId: generateShortUniqueIdFromTimestamp(StringConst.COMMENT_SECTION_WEB_DATE_PROJECT_CREATED),
    projectImagePathCover: ImagePath.COMMENT_SECTION_WEB_C,
    projectImagePathCoverHash: ImagePath.COMMENT_SECTION_WEB_C_HASH,
    projectImagePathList: [
      ImagePath.COMMENT_SECTION_WEB_C,
    ],
    projectImagePathListHash: [
      ImagePath.COMMENT_SECTION_WEB_C_HASH,
    ],
    projectName: StringConst.COMMENT_SECTION_WEB_PROJECT_NAME,
    projectDescription: StringConst.COMMENT_SECTION_WEB_PROJECT_DESCRIPTION,
    projectCategories: StringConst.COMMENT_SECTION_WEB_PROJECT_CATEGORIES,
    creatorName: StringConst.COMMENT_SECTION_WEB_CREATOR_NAME,
    creatorRole: StringConst.COMMENT_SECTION_WEB_CREATOR_ROLE,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE,
    ],
    creatorPhotoProfilePathHash: [
      ImagePath.KHIP01_PHOTO_PROFILE_HASH,
    ],
    creatorGithubLink: StringConst.COMMENT_SECTION_WEB_CREATOR_GITHUB_LINK,
    timestampDateCreated: StringConst.COMMENT_SECTION_WEB_DATE_PROJECT_CREATED,
    isProjectRelated: true,
    isProjectHighlighted: true,
    linkProjectToGithub: StringConst.COMMENT_SECTION_WEB_PROJECT_LINK_TO_GITHUB,
    linkDemoWeb: StringConst.COMMENT_SECTION_WEB_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.COMMENT_SECTION_WEB_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.COMMENT_SECTION_WEB_ADDITIONAL_LINK_DESCRIPTION,
    projectHighlightTopic: StringConst.COMMENT_SECTION_WEB_HIGHLIGHT_TOPIC,
    projectHighlightHeader: StringConst.COMMENT_SECTION_WEB_HIGHLIGHT_HEADER,
    projectHighlightDescription: StringConst.COMMENT_SECTION_WEB_HIGHLIGHT_DESCRIPTION,
  );
  static ProjectItemData RESTAURANT_KHIP01 = ProjectItemData(
    projectId: generateShortUniqueIdFromTimestamp(StringConst.RESTAURANT_KHIP01_DATE_PROJECT_CREATED),
    projectImagePathCover: ImagePath.RESTAURANT_KHIP01_C,
    projectImagePathCoverHash: ImagePath.RESTAURANT_KHIP01_C_HASH,
    projectImagePathList: [
      ImagePath.RESTAURANT_KHIP01_C,
      ImagePath.RESTAURANT_KHIP01_2,
      ImagePath.RESTAURANT_KHIP01_3,
    ],
    projectImagePathListHash: [
      ImagePath.RESTAURANT_KHIP01_C_HASH,
      ImagePath.RESTAURANT_KHIP01_2_HASH,
      ImagePath.RESTAURANT_KHIP01_3_HASH,
    ],
    projectName: StringConst.RESTAURANT_KHIP01_PROJECT_NAME,
    projectDescription: StringConst.RESTAURANT_KHIP01_PROJECT_DESCRIPTION,
    projectCategories: StringConst.RESTAURANT_KHIP01_PROJECT_CATEGORIES,
    creatorName: StringConst.RESTAURANT_KHIP01_CREATOR_NAME,
    creatorRole: StringConst.RESTAURANT_KHIP01_CREATOR_ROLE,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE,
    ],
    creatorPhotoProfilePathHash: [
      ImagePath.KHIP01_PHOTO_PROFILE_HASH,
    ],
    creatorGithubLink: StringConst.RESTAURANT_KHIP01_CREATOR_GITHUB_LINK,
    timestampDateCreated: StringConst.RESTAURANT_KHIP01_DATE_PROJECT_CREATED,
    isProjectRelated: true,
    isProjectHighlighted: true,
    linkProjectToGithub: StringConst.RESTAURANT_KHIP01_PROJECT_LINK_TO_GITHUB,
    linkDemoWeb: StringConst.RESTAURANT_KHIP01_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.RESTAURANT_KHIP01_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.RESTAURANT_KHIP01_ADDITIONAL_LINK_DESCRIPTION,
    projectHighlightTopic: StringConst.RESTAURANT_KHIP01_HIGHLIGHT_TOPIC,
    projectHighlightHeader: StringConst.RESTAURANT_KHIP01_HIGHLIGHT_HEADER,
    projectHighlightDescription: StringConst.RESTAURANT_KHIP01_HIGHLIGHT_DESCRIPTION,
  );
}

class ProjectItemData {
  final String projectId;
  final String projectImagePathCover;
  final String projectImagePathCoverHash; // Hash
  final List<String> projectImagePathList;
  final List<String> projectImagePathListHash; // Hash
  final String projectName;
  final String projectDescription;
  final List<String> projectCategories;
  final List<String> creatorName;
  final List<String> creatorRole;
  final List<String> creatorPhotoProfilePath;
  final List<String> creatorPhotoProfilePathHash; // Hash
  final List<String> creatorGithubLink;
  final int timestampDateCreated;
  final bool isProjectRelated;
  final bool isProjectHighlighted;
  final String? projectHighlightHeader;
  final String? projectHighlightDescription;
  final String? projectHighlightTopic;
  final String linkProjectToGithub;
  final String linkDemoWeb;
  final String additionalLink;
  final String additionalLinkDescription;

  ProjectItemData({
    required this.projectId,
    required this.projectImagePathCover,
    required this.projectImagePathCoverHash, // Hash
    required this.projectImagePathList,
    required this.projectImagePathListHash, // Hash
    required this.projectName,
    required this.projectDescription,
    required this.projectCategories,
    required this.creatorName,
    required this.creatorRole,
    required this.creatorPhotoProfilePath,
    required this.creatorPhotoProfilePathHash, // Hash
    required this.creatorGithubLink,
    required this.timestampDateCreated,
    required this.isProjectRelated,
    required this.isProjectHighlighted,
    this.projectHighlightHeader,
    this.projectHighlightDescription,
    this.projectHighlightTopic,
    required this.linkProjectToGithub,
    required this.linkDemoWeb,
    required this.additionalLink,
    required this.additionalLinkDescription,
  });
}