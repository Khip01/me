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
    Projects.ROCK_PAPPER_SCISSORS_GAME,
    Projects.SPPPAYMENT_SPPPAY,
    Projects.FIRST_WEB_PORTFOLIO,
    Projects.CALCULATOR_GUI_JAVA,
    Projects.KALKULATOR_BASIC_CPP,
  ];
}

class Projects {
  static ProjectItemData CAFEAPP_KHIPCAFE = ProjectItemData(
      projectImagePath: ImagePath.CAFEAPP_KHIPCAFE_C,
      projectName: StringConst.CAFEAPP_KHIPCAFE_PROJECT_NAME,
      projectDescription: StringConst.CAFEAPP_KHIPCAFE_PROJECT_DESCRIPTION,
      projectCategories: StringConst.CAFEAPP_KHIPCAFE_PROJECT_CATEGORIES,
      creatorName: StringConst.CAFEAPP_KHIPCAFE_CREATOR_NAME,
      creatorPhotoProfilePath: [
        ImagePath.KHIP01_PHOTO_PROFILE
      ],
      creatorGithubLink: [
        StringConst.CAFEAPP_KHIPCAFE_CREATOR_GITHUB_LINK
      ],
      timestampDateCreated: StringConst.CAFEAPP_KHIPCAFE_DATE_PROJECT_CREATED,
      isProjectRelated: false,
      isProjectHighlighted: false,
      linkProjectToGithub: StringConst.CAFEAPP_KHIPCAFE_CREATOR_GITHUB_LINK,
      linkDemoWeb: StringConst.CAFEAPP_KHIPCAFE_PROJECT_LINK_TO_DEMO_WEB,
      additionalLink: StringConst.CAFEAPP_KHIPCAFE_ADDITIONAL_LINK,
      additionalLinkDescription: StringConst.CAFEAPP_KHIPCAFE_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData SPPPAYMENT_SPPPAY_V2 = ProjectItemData(
    projectImagePath: ImagePath.SPPPAYMENT_SPPPAY_V2_C,
    projectName: StringConst.SPPPAYMENT_SPPPAY_V2_PROJECT_NAME,
    projectDescription: StringConst.SPPPAYMENT_SPPPAY_V2_PROJECT_DESCRIPTION,
    projectCategories: StringConst.SPPPAYMENT_SPPPAY_V2_PROJECT_CATEGORIES,
    creatorName: StringConst.SPPPAYMENT_SPPPAY_V2_CREATOR_NAME,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE
    ],
    creatorGithubLink: [
      StringConst.SPPPAYMENT_SPPPAY_V2_CREATOR_GITHUB_LINK
    ],
    timestampDateCreated: StringConst.SPPPAYMENT_SPPPAY_V2_DATE_PROJECT_CREATED,
    isProjectRelated: false,
    isProjectHighlighted: false,
    linkProjectToGithub: StringConst.SPPPAYMENT_SPPPAY_V2_CREATOR_GITHUB_LINK,
    linkDemoWeb: StringConst.SPPPAYMENT_SPPPAY_V2_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.SPPPAYMENT_SPPPAY_V2_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.SPPPAYMENT_SPPPAY_V2_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData ROCK_PAPPER_SCISSORS_GAME = ProjectItemData(
    projectImagePath: ImagePath.ROCK_PAPPER_SCISSORS_GAME_C,
    projectName: StringConst.ROCK_PAPPER_SCISSORS_GAME_PROJECT_NAME,
    projectDescription: StringConst.ROCK_PAPPER_SCISSORS_GAME_PROJECT_DESCRIPTION,
    projectCategories: StringConst.ROCK_PAPPER_SCISSORS_GAME_PROJECT_CATEGORIES,
    creatorName: StringConst.ROCK_PAPPER_SCISSORS_GAME_CREATOR_NAME,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE
    ],
    creatorGithubLink: [
      StringConst.ROCK_PAPPER_SCISSORS_GAME_CREATOR_GITHUB_LINK
    ],
    timestampDateCreated: StringConst.ROCK_PAPPER_SCISSORS_GAME_DATE_PROJECT_CREATED,
    isProjectRelated: false,
    isProjectHighlighted: false,
    linkProjectToGithub: StringConst.ROCK_PAPPER_SCISSORS_GAME_CREATOR_GITHUB_LINK,
    linkDemoWeb: StringConst.ROCK_PAPPER_SCISSORS_GAME_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.ROCK_PAPPER_SCISSORS_GAME_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.ROCK_PAPPER_SCISSORS_GAME_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData SPPPAYMENT_SPPPAY = ProjectItemData(
    projectImagePath: ImagePath.SPPPAYMENT_SPPPAY_C,
    projectName: StringConst.SPPPAYMENT_SPPPAY_PROJECT_NAME,
    projectDescription: StringConst.SPPPAYMENT_SPPPAY_PROJECT_DESCRIPTION,
    projectCategories: StringConst.SPPPAYMENT_SPPPAY_PROJECT_CATEGORIES,
    creatorName: StringConst.SPPPAYMENT_SPPPAY_CREATOR_NAME,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE
    ],
    creatorGithubLink: [
      StringConst.SPPPAYMENT_SPPPAY_CREATOR_GITHUB_LINK
    ],
    timestampDateCreated: StringConst.SPPPAYMENT_SPPPAY_DATE_PROJECT_CREATED,
    isProjectRelated: false,
    isProjectHighlighted: false,
    linkProjectToGithub: StringConst.SPPPAYMENT_SPPPAY_CREATOR_GITHUB_LINK,
    linkDemoWeb: StringConst.SPPPAYMENT_SPPPAY_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.SPPPAYMENT_SPPPAY_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.SPPPAYMENT_SPPPAY_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData FIRST_WEB_PORTFOLIO = ProjectItemData(
    projectImagePath: ImagePath.FIRST_WEB_PORTFOLIO_C,
    projectName: StringConst.FIRST_WEB_PORTFOLIO_PROJECT_NAME,
    projectDescription: StringConst.FIRST_WEB_PORTFOLIO_PROJECT_DESCRIPTION,
    projectCategories: StringConst.FIRST_WEB_PORTFOLIO_PROJECT_CATEGORIES,
    creatorName: StringConst.FIRST_WEB_PORTFOLIO_CREATOR_NAME,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE
    ],
    creatorGithubLink: [
      StringConst.FIRST_WEB_PORTFOLIO_CREATOR_GITHUB_LINK
    ],
    timestampDateCreated: StringConst.FIRST_WEB_PORTFOLIO_DATE_PROJECT_CREATED,
    isProjectRelated: false,
    isProjectHighlighted: false,
    linkProjectToGithub: StringConst.FIRST_WEB_PORTFOLIO_CREATOR_GITHUB_LINK,
    linkDemoWeb: StringConst.FIRST_WEB_PORTFOLIO_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.FIRST_WEB_PORTFOLIO_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.FIRST_WEB_PORTFOLIO_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData CALCULATOR_GUI_JAVA = ProjectItemData(
    projectImagePath: ImagePath.CALCULATOR_GUI_JAVA_C,
    projectName: StringConst.CALCULATOR_GUI_JAVA_PROJECT_NAME,
    projectDescription: StringConst.CALCULATOR_GUI_JAVA_PROJECT_DESCRIPTION,
    projectCategories: StringConst.CALCULATOR_GUI_JAVA_PROJECT_CATEGORIES,
    creatorName: StringConst.CALCULATOR_GUI_JAVA_CREATOR_NAME,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE
    ],
    creatorGithubLink: [
      StringConst.CALCULATOR_GUI_JAVA_CREATOR_GITHUB_LINK
    ],
    timestampDateCreated: StringConst.CALCULATOR_GUI_JAVA_DATE_PROJECT_CREATED,
    isProjectRelated: false,
    isProjectHighlighted: false,
    linkProjectToGithub: StringConst.CALCULATOR_GUI_JAVA_CREATOR_GITHUB_LINK,
    linkDemoWeb: StringConst.CALCULATOR_GUI_JAVA_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.CALCULATOR_GUI_JAVA_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.CALCULATOR_GUI_JAVA_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData KALKULATOR_BASIC_CPP = ProjectItemData(
    projectImagePath: ImagePath.KALKULATOR_BASIC_CPP_C,
    projectName: StringConst.KALKULATOR_BASIC_CPP_PROJECT_NAME,
    projectDescription: StringConst.KALKULATOR_BASIC_CPP_PROJECT_DESCRIPTION,
    projectCategories: StringConst.KALKULATOR_BASIC_CPP_PROJECT_CATEGORIES,
    creatorName: StringConst.KALKULATOR_BASIC_CPP_CREATOR_NAME,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE
    ],
    creatorGithubLink: [
      StringConst.KALKULATOR_BASIC_CPP_CREATOR_GITHUB_LINK
    ],
    timestampDateCreated: StringConst.KALKULATOR_BASIC_CPP_DATE_PROJECT_CREATED,
    isProjectRelated: false,
    isProjectHighlighted: false,
    linkProjectToGithub: StringConst.KALKULATOR_BASIC_CPP_CREATOR_GITHUB_LINK,
    linkDemoWeb: StringConst.KALKULATOR_BASIC_CPP_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.KALKULATOR_BASIC_CPP_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.KALKULATOR_BASIC_CPP_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData FLUTTER_PORTFOLIO = ProjectItemData(
    projectImagePath: ImagePath.FLUTTER_PORTFOLIO_C,
    projectName: StringConst.FLUTTER_PORTFOLIO_PROJECT_NAME,
    projectDescription: StringConst.FLUTTER_PORTFOLIO_PROJECT_DESCRIPTION,
    projectCategories: StringConst.FLUTTER_PORTFOLIO_PROJECT_CATEGORIES,
    creatorName: StringConst.FLUTTER_PORTFOLIO_CREATOR_NAME,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE
    ],
    creatorGithubLink: [
      StringConst.FLUTTER_PORTFOLIO_CREATOR_GITHUB_LINK
    ],
    timestampDateCreated: StringConst.FLUTTER_PORTFOLIO_DATE_PROJECT_CREATED,
    isProjectRelated: true,
    isProjectHighlighted: true,
    linkProjectToGithub: StringConst.FLUTTER_PORTFOLIO_CREATOR_GITHUB_LINK,
    linkDemoWeb: StringConst.FLUTTER_PORTFOLIO_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.FLUTTER_PORTFOLIO_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.FLUTTER_PORTFOLIO_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData COMMENT_SECTION_WEB = ProjectItemData(
    projectImagePath: ImagePath.COMMENT_SECTION_WEB_C,
    projectName: StringConst.COMMENT_SECTION_WEB_PROJECT_NAME,
    projectDescription: StringConst.COMMENT_SECTION_WEB_PROJECT_DESCRIPTION,
    projectCategories: StringConst.COMMENT_SECTION_WEB_PROJECT_CATEGORIES,
    creatorName: StringConst.COMMENT_SECTION_WEB_CREATOR_NAME,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE
    ],
    creatorGithubLink: [
      StringConst.COMMENT_SECTION_WEB_CREATOR_GITHUB_LINK
    ],
    timestampDateCreated: StringConst.COMMENT_SECTION_WEB_DATE_PROJECT_CREATED,
    isProjectRelated: true,
    isProjectHighlighted: true,
    linkProjectToGithub: StringConst.COMMENT_SECTION_WEB_CREATOR_GITHUB_LINK,
    linkDemoWeb: StringConst.COMMENT_SECTION_WEB_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.COMMENT_SECTION_WEB_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.COMMENT_SECTION_WEB_ADDITIONAL_LINK_DESCRIPTION,
  );
  static ProjectItemData RESTAURANT_KHIP01 = ProjectItemData(
    projectImagePath: ImagePath.RESTAURANT_KHIP01_C,
    projectName: StringConst.RESTAURANT_KHIP01_PROJECT_NAME,
    projectDescription: StringConst.RESTAURANT_KHIP01_PROJECT_DESCRIPTION,
    projectCategories: StringConst.RESTAURANT_KHIP01_PROJECT_CATEGORIES,
    creatorName: StringConst.RESTAURANT_KHIP01_CREATOR_NAME,
    creatorPhotoProfilePath: [
      ImagePath.KHIP01_PHOTO_PROFILE
    ],
    creatorGithubLink: [
      StringConst.RESTAURANT_KHIP01_CREATOR_GITHUB_LINK
    ],
    timestampDateCreated: StringConst.RESTAURANT_KHIP01_DATE_PROJECT_CREATED,
    isProjectRelated: true,
    isProjectHighlighted: true,
    linkProjectToGithub: StringConst.RESTAURANT_KHIP01_CREATOR_GITHUB_LINK,
    linkDemoWeb: StringConst.RESTAURANT_KHIP01_PROJECT_LINK_TO_DEMO_WEB,
    additionalLink: StringConst.RESTAURANT_KHIP01_ADDITIONAL_LINK,
    additionalLinkDescription: StringConst.RESTAURANT_KHIP01_ADDITIONAL_LINK_DESCRIPTION,
  );
}

class ProjectItemData {
  final String projectImagePath;
  final String projectName;
  final String projectDescription;
  final List<String> projectCategories;
  final List<String> creatorName;
  final List<String> creatorPhotoProfilePath;
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
    required this.projectImagePath,
    required this.projectName,
    required this.projectDescription,
    required this.projectCategories,
    required this.creatorName,
    required this.creatorPhotoProfilePath,
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