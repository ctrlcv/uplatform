import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uplatform/page/booking/booking_detail_page.dart';
import 'package:uplatform/page/booking/booking_education_page.dart';
import 'package:uplatform/page/booking/booking_education_step01_page.dart';
import 'package:uplatform/page/booking/booking_education_step02_page.dart';
import 'package:uplatform/page/booking/booking_finish_page.dart';
import 'package:uplatform/page/booking/booking_payment_page.dart';
import 'package:uplatform/page/booking/booking_restaurant_page.dart';
import 'package:uplatform/page/booking/booking_restaurant_step01_page.dart';
import 'package:uplatform/page/booking/booking_restaurant_step02_page.dart';
import 'package:uplatform/page/booking/booking_space_page.dart';
import 'package:uplatform/page/booking/booking_space_step01_page.dart';
import 'package:uplatform/page/booking/booking_space_step02_page.dart';
import 'package:uplatform/page/booking/booking_type_page.dart';
import 'package:uplatform/page/booking/payment_page.dart';
import 'package:uplatform/page/common/address_search_page.dart';
import 'package:uplatform/page/common/alarm_list_page.dart';
import 'package:uplatform/page/common/change_password_page.dart';
import 'package:uplatform/page/common/faq_detail_page.dart';
import 'package:uplatform/page/common/find_address_page.dart';
import 'package:uplatform/page/common/notice_detail_page.dart';
import 'package:uplatform/page/common/phone_certification.dart';
import 'package:uplatform/page/common/qna_detail_page.dart';
import 'package:uplatform/page/common/qna_input_page.dart';
import 'package:uplatform/page/common/search_address_page.dart';
import 'package:uplatform/page/expert/apply_detail_page.dart';
import 'package:uplatform/page/expert/expert_edit_profile_page.dart';
import 'package:uplatform/page/expert/expert_home_page.dart';
import 'package:uplatform/page/expert/income_detail_page.dart';
import 'package:uplatform/page/expert/income_list_page.dart';
import 'package:uplatform/page/expert/request_detail_page.dart';
import 'package:uplatform/page/expert/request_finish_page.dart';
import 'package:uplatform/page/expert/transfer_to_normal_page.dart';
import 'package:uplatform/page/home/home_clean_space_detail_page.dart';
import 'package:uplatform/page/home/home_edit_profile_page.dart';
import 'package:uplatform/page/home/home_education_detail_page.dart';
import 'package:uplatform/page/home/home_page.dart';
import 'package:uplatform/page/home/home_recruit_member_page.dart';
import 'package:uplatform/page/home/home_restaurant_detail_page.dart';
import 'package:uplatform/page/home/payment_list_page.dart';
import 'package:uplatform/page/home/transfer_to_expert_page.dart';
import 'package:uplatform/page/menu/exit_uplatform_page.dart';
import 'package:uplatform/page/menu/serice_terms_page.dart';
import 'package:uplatform/page/signin/find_id_fail_page.dart';
import 'package:uplatform/page/signin/find_id_finish_page.dart';
import 'package:uplatform/page/signin/find_id_page.dart';
import 'package:uplatform/page/signin/find_password_finish_page.dart';
import 'package:uplatform/page/signin/find_password_page.dart';
import 'package:uplatform/page/signin/login_email_page.dart';
import 'package:uplatform/page/signin/new_password_page.dart';
import 'package:uplatform/page/signin/permission_page.dart';
import 'package:uplatform/page/signin/terms_page.dart';
import 'package:uplatform/page/signup/signup_account_type_page.dart';
import 'package:uplatform/page/signup/signup_expert_by_sns_page.dart';
import 'package:uplatform/page/signup/signup_expert_by_uplatform_page.dart';
import 'package:uplatform/page/signup/signup_finish.dart';
import 'package:uplatform/page/signup/signup_member_type_page.dart';
import 'package:uplatform/page/signup/signup_normal_by_sns_page.dart';
import 'package:uplatform/page/signup/signup_normal_by_uplatform_page.dart';
import 'package:uplatform/page/signup/signup_terms_page.dart';
import 'package:uplatform/page/start_page.dart';

//TODO : env 파일 분리
const kakaoClientKey = 'abf73a9bacb2a13333de82cd87a8ecaf';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  KakaoSdk.init(
    nativeAppKey: kakaoClientKey,
    loggingEnabled: true,
  );

  runApp(
    (UniversalPlatform.isWeb)
        ? Container(
            color: const Color(0xFF818181),
            child: const Center(
              child: SizedBox(
                width: 800,
                child: MyApp(),
              ),
            ),
          )
        : const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        title: 'shinyo',
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/', page: () => const StartPage()),
          //----------------------------------------------------------------------------------------------
          GetPage(name: StartPage.routeName, page: () => const StartPage()),
          GetPage(name: PermissionPage.routeName, page: () => const PermissionPage()),
          GetPage(name: LoginEmailPage.routeName, page: () => const LoginEmailPage()),
          GetPage(name: FindIdPage.routeName, page: () => const FindIdPage()),
          GetPage(name: FindIdFinishPage.routeName, page: () => const FindIdFinishPage()),
          GetPage(name: FindIdFailPage.routeName, page: () => const FindIdFailPage()),
          GetPage(name: FindPasswordPage.routeName, page: () => const FindPasswordPage()),
          //----------------------------------------------------------------------------------------------
          GetPage(name: TermsPage.routeName, page: () => const TermsPage()),
          GetPage(name: SignUpAccountTypePage.routeName, page: () => const SignUpAccountTypePage()),
          GetPage(name: SignUpMemberTypePage.routeName, page: () => const SignUpMemberTypePage()),
          GetPage(name: SignUpTermsPage.routeName, page: () => const SignUpTermsPage()),
          GetPage(name: SignUpNormalByUPlatformPage.routeName, page: () => const SignUpNormalByUPlatformPage()),
          GetPage(name: SignUpNormalBySnsPage.routeName, page: () => const SignUpNormalBySnsPage()),
          GetPage(name: SignUpExpertByUPlatformPage.routeName, page: () => const SignUpExpertByUPlatformPage()),
          GetPage(name: SignUpExpertBySnsPage.routeName, page: () => const SignUpExpertBySnsPage()),
          GetPage(name: SignUpFinish.routeName, page: () => const SignUpFinish()),
          //----------------------------------------------------------------------------------------------
          GetPage(name: HomePage.routeName, page: () => const HomePage()),
          GetPage(name: HomeRestaurantDetailPage.routeName, page: () => const HomeRestaurantDetailPage()),
          GetPage(name: HomeCleanSpaceDetailPage.routeName, page: () => const HomeCleanSpaceDetailPage()),
          GetPage(name: HomeEducationDetailPage.routeName, page: () => const HomeEducationDetailPage()),
          GetPage(name: HomeRecruitMemberPage.routeName, page: () => const HomeRecruitMemberPage()),
          GetPage(name: HomeEditProfilePage.routeName, page: () => const HomeEditProfilePage()),
          GetPage(name: TransferToExpertPage.routeName, page: () => const TransferToExpertPage()),
          //----------------------------------------------------------------------------------------------
          GetPage(name: BookingEducationPage.routeName, page: () => const BookingEducationPage()),
          GetPage(name: BookingEducationStep01Page.routeName, page: () => const BookingEducationStep01Page()),
          GetPage(name: BookingEducationStep02Page.routeName, page: () => const BookingEducationStep02Page()),
          GetPage(name: BookingRestaurantPage.routeName, page: () => const BookingRestaurantPage()),
          GetPage(name: BookingRestaurantStep01Page.routeName, page: () => const BookingRestaurantStep01Page()),
          GetPage(name: BookingRestaurantStep02Page.routeName, page: () => const BookingRestaurantStep02Page()),
          GetPage(name: BookingSpacePage.routeName, page: () => const BookingSpacePage()),
          GetPage(name: BookingSpaceStep01Page.routeName, page: () => const BookingSpaceStep01Page()),
          GetPage(name: BookingSpaceStep02Page.routeName, page: () => const BookingSpaceStep02Page()),
          GetPage(name: BookingTypePage.routeName, page: () => const BookingTypePage()),
          GetPage(name: BookingDetailPage.routeName, page: () => const BookingDetailPage()),
          GetPage(name: BookingFinishPage.routeName, page: () => const BookingFinishPage()),
          GetPage(name: BookingPaymentPage.routeName, page: () => const BookingPaymentPage()),
          //----------------------------------------------------------------------------------------------
          GetPage(name: ExpertHomePage.routeName, page: () => const ExpertHomePage()),
          GetPage(name: ExpertEditProfilePage.routeName, page: () => const ExpertEditProfilePage()),
          GetPage(name: RequestDetailPage.routeName, page: () => const RequestDetailPage()),
          GetPage(name: RequestFinishPage.routeName, page: () => const RequestFinishPage()),
          GetPage(name: ApplyDetailPage.routeName, page: () => const ApplyDetailPage()),
          GetPage(name: IncomeListPage.routeName, page: () => const IncomeListPage()),
          GetPage(name: IncomeDetailPage.routeName, page: () => const IncomeDetailPage()),
          GetPage(name: TransferToNormalPage.routeName, page: () => const TransferToNormalPage()),
          //----------------------------------------------------------------------------------------------
          GetPage(name: AddressSearchPage.routeName, page: () => const AddressSearchPage()),
          GetPage(name: PhoneCertification.routeName, page: () => const PhoneCertification()),
          GetPage(name: ChangePasswordPage.routeName, page: () => const ChangePasswordPage()),
          GetPage(name: ExitUPlatformPage.routeName, page: () => const ExitUPlatformPage()),
          GetPage(name: SearchAddressPage.routeName, page: () => const SearchAddressPage()),
          GetPage(name: FindAddressPage.routeName, page: () => const FindAddressPage()),
          GetPage(name: PaymentPage.routeName, page: () => const PaymentPage()),
          GetPage(name: PaymentListPage.routeName, page: () => const PaymentListPage()),
          GetPage(name: NoticeDetailPage.routeName, page: () => const NoticeDetailPage()),
          GetPage(name: FaqDetailPage.routeName, page: () => const FaqDetailPage()),
          GetPage(name: QnaDetailPage.routeName, page: () => const QnaDetailPage()),
          GetPage(name: QnaInputPage.routeName, page: () => const QnaInputPage()),
          GetPage(name: AlarmListPage.routeName, page: () => const AlarmListPage()),
          GetPage(name: ServiceTermsPage.routeName, page: () => const ServiceTermsPage()),
          GetPage(name: NewPasswordPage.routeName, page: () => const NewPasswordPage()),
          GetPage(name: FindPasswordFinishPage.routeName, page: () => const FindPasswordFinishPage()),
        ],
        theme: ThemeData(
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko', 'KR'),
          Locale('en', 'US'),
        ],
        home: const StartPage(),
      ),
    );
  }
}
