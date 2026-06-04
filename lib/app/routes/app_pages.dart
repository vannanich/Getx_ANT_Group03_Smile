import 'package:flutter_application_1/app/auth/login_screen/login_screen_binding.dart';
import 'package:flutter_application_1/app/auth/sign_up_screen/sign_up_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/d_complete_form/d_complete_form_binding.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/d_complete_form/d_complete_form_view.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/d_homescreen/d_homescreen_binding.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/d_homescreen/d_homescreen_view.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/d_homescreen/d_today_appoitment/d_today_appoitment_binding.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/d_homescreen/d_today_appoitment/d_today_appoitment_view.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/scan_id/scan_doctor_id/scan_doctor_id_binding.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/scan_id/scan_doctor_id/scan_doctor_id_view.dart';
import 'package:flutter_application_1/app/modules/screen/buildstreak/buildstreak_binding.dart';
import 'package:flutter_application_1/app/modules/screen/buildstreak/buildstreak_view.dart';
import 'package:flutter_application_1/app/modules/screen/chat_ai_screen/chat_ai_screen_binding.dart';
import 'package:flutter_application_1/app/modules/screen/chat_ai_screen/chat_ai_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/book_appointment/book_appointment_binding.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/book_appointment/book_appointment_view.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/chat_with_doctor/chat_with_doctor_binding.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/chat_with_doctor/chat_with_doctor_view.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/schedule/schedule_binding.dart';
import 'package:flutter_application_1/app/modules/screen/doctor_feature/schedule/schedule_view.dart';
import 'package:flutter_application_1/app/modules/screen/home_screen/home_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/mood_screen/mood_screen/mood_screen_view.dart';
import 'package:flutter_application_1/app/auth/login_screen/login_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/mood_selection/mood_selection_binding.dart';
import 'package:flutter_application_1/app/modules/screen/mood_selection/mood_selection_view.dart';
import 'package:flutter_application_1/app/modules/screen/onboarding/onboarding/onboarding_view.dart';
import 'package:flutter_application_1/app/modules/screen/onboarding_2/onboarding_2/onboarding_2_view.dart';
import 'package:flutter_application_1/app/modules/screen/onboarding_3/onboarding_3/onboarding_3_view.dart';
import 'package:flutter_application_1/app/modules/screen/quote_screen/quote_screen/quote_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/readbookscreen/book_download_screen/book_download_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/readbookscreen/detail_book_screen/detail_book_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/readbookscreen/read_book_screen/read_book_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/readbookscreen/save_book_screen/save_book_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/selected_role_screen/select_role_screen_view.dart';
import 'package:flutter_application_1/app/modules/screen/sleeping_mood/sleeping_mood_binding.dart';
import 'package:flutter_application_1/app/modules/screen/sleeping_mood/sleeping_mood_view.dart';
import 'package:flutter_application_1/app/modules/screen/splash_screen.dart';
import 'package:flutter_application_1/app/modules/screen/survey/survey_1/survey_1_view.dart';
import 'package:flutter_application_1/app/modules/screen/survey/survey_2/survey_2_view.dart';
import 'package:flutter_application_1/app/modules/screen/survey/survey_3/survey_3_view.dart';
import 'package:flutter_application_1/app/modules/screen/survey/survey_4/survey_4_view.dart';
import 'package:flutter_application_1/app/modules/screen/survey/survey_5/survey_5_view.dart';
import 'package:flutter_application_1/app/modules/screen/video_screen/video_screen_view.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.homescreen,
      page: () => HomeScreenView(),
      binding: HomeScreenViewBinding(),
      transition: Transition.circularReveal,
      transitionDuration: Duration(milliseconds: 1200),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingView(),
      binding: OnboardingViewBinding(),
      transition: Transition.circularReveal,
      transitionDuration: Duration(milliseconds: 1200),
    ),
    GetPage(
      name: AppRoutes.onboarding_2,
      page: () => Onboarding2View(),
      binding: Onboarding2ViewBinding(),
      transition: Transition.circularReveal,
      transitionDuration: Duration(milliseconds: 1200),
    ),
    GetPage(
      name: AppRoutes.onboarding_3,
      page: () => Onboarding3View(),
      binding: Onboarding3ViewBinding(),
      transition: Transition.circularReveal,
      transitionDuration: Duration(milliseconds: 900),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreenView(),
      binding: LoginScreenBinding(),
      transition: Transition.fade,
      transitionDuration: Duration(milliseconds: 900),
    ),
    GetPage(
      name: AppRoutes.survey_1,
      page: () => Survey1View(),
      binding: Survey1ViewBinding(),
      transition: Transition.native,
      transitionDuration: Duration(milliseconds: 900),
    ),
    GetPage(
      name: AppRoutes.survey_2,
      page: () => Survey2View(),
      binding: Survey2ViewBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 900),
    ),
    GetPage(
      name: AppRoutes.survey_3,
      page: () => Survey3View(),
      binding: Survey3ViewBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 900),
    ),
    GetPage(
      name: AppRoutes.survey_4,
      page: () => Survey4View(),
      binding: Survey4ViewBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 900),
    ),
    GetPage(
      name: AppRoutes.survey_5,
      page: () => Survey5View(),
      binding: Survey5ViewBinding(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 900),
    ),

    // chat AI
    GetPage(
      name: AppRoutes.chatAI,
      page: () => AiChatView(),
      binding: AiChatBinding(),
    ),

    //read book screen
    GetPage(
      name: AppRoutes.readbook,
      page: () => ReadBookScreenView(),
      binding: ReadBookScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.detailbook,
      page: () => DetailBookScreenView(),
      binding: DetailBookScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.savebook,
      page: () => SaveBookScreenView(),
      binding: SaveBookScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.bookdownload,
      page: () => BookDownloadScreenView(),
      binding: BookDownloadScreenViewBinding(),
    ),
    //Mood screen
    GetPage(
      name: AppRoutes.moodSelection,
      page: () => MoodSelectorScreen(),
      binding: MoodSelectionViewBinding(),
    ),
    GetPage(
      name: AppRoutes.moodscreen,
      page: () => MoodScreenView(),
      binding: MoodScreenBinding(),
    ),
    //Quote screen
    GetPage(
      name: AppRoutes.quotescreen,
      page: () => QuoteScreenView(),
      binding: QuoteScreenBinding(),
    ),
    //Video screen
    GetPage(
      name: AppRoutes.videoscreen,
      page: () => VideoScreenView(),
      binding: VideoScreenViewBinding(),
    ),
    GetPage(
      name: AppRoutes.chatWithDoctor,
      page: () => ChatWithDoctorView(),
      binding: ChatWithDoctorBinding(),
    ),
    GetPage(
      name: AppRoutes.bookAppointment,
      page: () =>DoctorAppointmentView (),
      binding: DoctorAppointmentBinding (),
    ),
    GetPage(
      name: AppRoutes.schedule,
      page: () =>ScheduleView (),
      binding: ScheduleBinding (),
    ),
    GetPage(
      name: AppRoutes.sleepingMood,
      page: () => SleepModeView(),
      binding: SleepModeBinding(),
    ),
    GetPage(
      name: AppRoutes.selectRoleScreen,
      page: () => SelectRoleScreenView(),
      binding: SelectRoleScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.streakScreen,
      page: () => BuildstreakView(),
      binding: BuildstreakViewBinding (),
    ),
    GetPage(
      name: AppRoutes.scanId,
      page: () => ScanDoctorIdView(),
      binding: ScanDoctorIdBinding (),
    ),
    GetPage(
      name: AppRoutes.dCompleteForm,
      page: () => DCompleteFormView(),
      binding: DCompleteFormBinding (),
    ),
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => SplashScreen(),
      // binding: DCompleteFormBinding (),
    ),
    GetPage(
      name: AppRoutes.dHomescreen,
      page: () => DHomescreenView(),
      binding: DHomescreenBinding (),
    ),
    GetPage(
      name: AppRoutes.dTodayAppoitment,
      page: () => DTodayAppoitmentView(),
      binding: DTodayAppoitmentBinding (),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => SignUpScreenView(),
      binding: SignUpScreenViewBinding (),
    ),
  ];
}
