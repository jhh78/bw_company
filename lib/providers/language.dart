import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {
          'maintenance': "서버 점검중입니다.",
          'maintenanceText': "잠시 후 다시 시도해주세요.",
          'policyUrl': 'https://jhh78.github.io/policys/kr.html',
          'policyAgree': "동의합니다.",
          'appInfoTitle': "이앱은 익명으로 운영되며 개인정보는 수집하지 않습니다.",
          'searchListTitle': "회사리스트",
          'rateIt': "평가하기",
          'info': "정보",
          'purchaseSuccess': "결제가 완료되었습니다.",
          'naviMenu': "메뉴",
          'naviSearch': "검색",
          'naviNotification': "공지사항",
          'policy': "이용규약",
          'exitMember': "회원탈퇴",
          'naviHelp': "도움말",
          'naviSupport': "개발자지원",
          'viewAD': "광고보기",
          'adNotLoaded': "광고가 로드되지 않았습니다.",
          'donate': "기부하기",
          'wrongInformation': "저장된 데이터에 문제가 있습니다.",
          'noticeScreenTitle': "공지사항",
          'helpScreenTitle': "이 앱에 대하여",
          'supportScreenTitle': "개발자 지원",
          'recommendationMessage': "이미 추천한 댓글입니다.",
          'notRecommendedMessage': "이미 비추천한 댓글입니다.",
          'dataNotFound': "데이터가 없습니다.",
          'descriptionCareer': "캐리어",
          'descriptionWorkEnvironment': "업무환경",
          'descriptionSalaryWelfare': "급여,복지",
          'descriptionCompanyCulture': "사내문화",
          'descriptionManagement': "경영진",
          'commentRegisterTitle': "평가 등록",
          'requiredField': "필수항목입니다",
          'registerButton': "등록",
          'addSearchTag': "태그를 추가하세요(임의)",
          "addSearchTagHintText": "검색에 사용될 태그를 입력하세요",
          'searchCompanyHintText': "회사검색",
          'registerCompanyButton': "회사등록",
          'registerCompanyScreenTitle': "회사등록 페이지",
          'registerCompanyScreenNeedCompanyName': "회사명을 입력해주세요",
          'registerCompanyScreenNeedCompanyHomePage': "홈페이지를 입력해주세요 (필수)",
          'registerCompanyScreenNeedCompanyHomePageHelpText': "홈페이지 URL을 입력해주세요",
          'registerCompanyScreenNeedCompanyLocation': "위치를 입력해주세요 (필수)",
          'registerCompanyScreenNeedCompanyLocationHelpText': "Google Map의 위치정보를 입력해주세요",
          'companyRegisterInputFormTitleHintText': "타이틀을 입력하세요 (필수)",
          'companyRegisterInputFormCareerHintText': "커리어에 대하여 입력하세요 (필수)",
          'companyRegisterInputFormWorkingEnvironmentHintText': "업무환경에 대하여 입력하세요 (필수)",
          'companyRegisterInputFormSalaryWelfareHintText': "급여,복지에 대하여 입력하세요 (필수)",
          'companyRegisterInputFormCorporateCultureHintText': "사내문화에 대하여 입력하세요 (필수)",
          'companyRegisterInputFormManagementHintText': "경영진에 대하여 입력하세요 (필수)",

          // Exception
          'errorText': "에러",
          'alreadyExistTag': "이미 등록된 태그입니다.",
          'unknownExcetipn': "알수없는 오류가 발생하였습니다.",
          'needRequiredField': "필수항목을 입력해 주세요",
          'registeredItems': "이미 등록된 항목입니다.",
          'adLoadFailed': "광고 로드에 실패하였습니다.\n잠시 후 다시 시도해주세요.",
          'productLoadFailed': "상품 로드에 실패하였습니다.\n잠시 후 다시 시도해주세요.",
        },
        'ja_JP': {
          'maintenance': "サーバーメンテナンス中です。",
          'maintenanceText': "しばらくしてから再度お試しください。",
          'policyUrl': 'https://jhh78.github.io/policys/jp.html',
          'policyAgree': "同意します。",
          'appInfoTitle': "このアプリは匿名で動作し、個人情報は収集しません。",
          'searchListTitle': "会社一覧",
          'rateIt': "評価する",
          'info': "情報",
          'purchaseSuccess': "支払いが完了しました。",
          'naviMenu': "メニュー",
          'naviSearch': "検索",
          'naviNotification': "お知らせ",
          'policy': "利用規約",
          'exitMember': "会員退会",
          'naviHelp': "ヘルプ",
          'naviSupport': "開発者支援",
          'viewAD': "広告を見る",
          'adNotLoaded': "広告がロードされていません。",
          'donate': "寄付する",
          'wrongInformation': "保存されたデータに問題があります。",
          'noticeScreenTitle': "お知らせ",
          'helpScreenTitle': "このアプリについて",
          'supportScreenTitle': "開発者支援",
          'recommendationMessage': "すでに推薦したコメントです。",
          'notRecommendedMessage': "すでに非推薦したコメントです。",
          'dataNotFound': "データがありません。",
          'descriptionCareer': "キャリア",
          'descriptionWorkEnvironment': "業務環境",
          'descriptionSalaryWelfare': "給与、福利厚生",
          'descriptionCompanyCulture': "社内文化",
          'descriptionManagement': "経営",
          'commentRegisterTitle': "コメント登録",
          'requiredField': "必須項目です",
          'registerButton': "登録",
          'addSearchTag': "タグを追加してください(任意)",
          'addSearchTagHintText': "検索に使用されるタグを入力してください",
          'searchCompanyHintText': "会社検索",
          'registerCompanyButton': "会社登録",
          'registerCompanyScreenTitle': "会社登録ページ",
          'registerCompanyScreenNeedCompanyName': "会社名を入力してください",
          'registerCompanyScreenNeedCompanyHomePage': "ホームページを入力してください (必須)",
          'registerCompanyScreenNeedCompanyHomePageHelpText': "ホームページのURLを入力してください",
          'registerCompanyScreenNeedCompanyLocation': "位置情報を入力してください (必須)",
          'registerCompanyScreenNeedCompanyLocationHelpText': "Google Mapの位置情報を入力してください",
          'companyRegisterInputFormTitleHintText': "タイトルを入力してください（必須）",
          'companyRegisterInputFormCareerHintText': "キャリアについて入力してください（必須）",
          'companyRegisterInputFormWorkingEnvironmentHintText': "業務環境について入力してください（必須）",
          'companyRegisterInputFormSalaryWelfareHintText': "給与、福利厚生について入力してください（必須）",
          'companyRegisterInputFormCorporateCultureHintText': "社内文化について入力してください（必須）",
          'companyRegisterInputFormManagementHintText': "経営について入力してください（必須）",

          // Exception
          'errorText': "エラー",
          'alreadyExistTag': "既に登録されたタグです。",
          'unknownExcetipn': "不明なエラーが発生しました。",
          'needRequiredField': "必須項目を入力してください",
          'registeredItems': "すでに登録されたアイテムです。",
          'adLoadFailed': "広告のロードに失敗しました。\nしばらくしてから再度お試しください。",
          'productLoadFailed': "商品のロードに失敗しました。\nしばらくしてから再度お試しください。",
        },
        'en_US': {
          'maintenance': "Server maintenance is in progress.",
          'maintenanceText': "Please try again later.",
          'policyUrl': 'https://jhh78.github.io/policys/en.html',
          'policyAgree': "I agree.",
          'appInfoTitle': "This app operates anonymously and does not collect any personal information.",
          'searchListTitle': "Company List",
          'rateIt': "Rate it",
          'info': "Information",
          'purchaseSuccess': "Payment has been completed.",
          'naviMenu': "Menu",
          'naviSearch': "Search",
          'naviNotification': "Notification",
          'policy': "policy",
          'exitMember': "Exit Member",
          'naviHelp': "Help",
          'naviSupport': "Developer support",
          'viewAD': "View AD",
          'adNotLoaded': "The ad has not been loaded.",
          'donate': "Donate",
          'wrongInformation': "There is a problem with the saved data.",
          'noticeScreenTitle': "Notice",
          'helpScreenTitle': "About this app",
          'supportScreenTitle': "Developer support",
          'recommendationMessage': "This is a comment that has already been recommended.",
          'notRecommendedMessage': "This is a comment that has already been unrecommended.",
          'dataNotFound': "No data.",
          'descriptionCareer': "Career",
          'descriptionWorkEnvironment': "Work environment",
          'descriptionSalaryWelfare': "Salary, welfare",
          'descriptionCompanyCulture': "Corporate culture",
          'descriptionManagement': "Management",
          'commentRegisterTitle': "Comment Register",
          'requiredField': "This is a required field",
          'registerButton': "Register",
          'addSearchTag': "Add a tag (optional)",
          'addSearchTagHintText': "Enter the tag to be used for search",
          'searchCompanyHintText': "Company search",
          'registerCompanyButton': "Company Register",
          'registerCompanyScreenNeedCompanyName': "Please enter the company name",
          'registerCompanyScreenNeedCompanyHomePage': "Please enter the homepage (required)",
          'registerCompanyScreenNeedCompanyHomePageHelpText': "Please enter the URL of the homepage",
          'registerCompanyScreenNeedCompanyLocation': "Please enter the location (required)",
          'registerCompanyScreenNeedCompanyLocationHelpText': "Please enter the location information of Google Map",
          'registerCompanyScreenTitle': "Company Register Page",
          'companyRegisterInputFormTitleHintText': "Enter the title (required)",
          'companyRegisterInputFormCareerHintText': "Enter about career (required)",
          'companyRegisterInputFormWorkingEnvironmentHintText': "Enter about working environment (required)",
          'companyRegisterInputFormSalaryWelfareHintText': "Enter about salary, welfare (required)",
          'companyRegisterInputFormCorporateCultureHintText': "Enter about corporate culture (required)",
          'companyRegisterInputFormManagementHintText': "Enter about management (required)",

          // Exception
          'errorText': "Error",
          'alreadyExistTag': "The tag is already registered.",
          'unknownExcetipn': "An unknown error has occurred.",
          'needRequiredField': "Please enter the required field",
          'registeredItems': "This item is already registered.",
          'adLoadFailed': "Failed to load ad.\nPlease try again later.",
          'productLoadFailed': "Failed to load product.\nPlease try again later.",
        },
      };
}
