import '../../app/modules/leave_request_module/leave_request_page.dart';
import '../../app/modules/leave_request_module/leave_request_bindings.dart';
import '../../app/modules/reports_pages_module/reports_pages_page.dart';
import '../../app/modules/reports_pages_module/reports_pages_bindings.dart';
import '../../app/modules/onduty_report_module/onduty_report_page.dart';
import '../../app/modules/onduty_report_module/onduty_report_bindings.dart';
import '../../app/modules/permistion_report_module/permistion_report_page.dart';
import '../../app/modules/permistion_report_module/permistion_report_bindings.dart';
import '../../app/modules/attendance_report_module/attendance_report_page.dart';
import '../../app/modules/attendance_report_module/attendance_report_bindings.dart';
import '../../app/modules/onduty_master_module/onduty_master_page.dart';
import '../../app/modules/onduty_master_module/onduty_master_bindings.dart';
import '../../app/modules/permision_master_module/permision_master_page.dart';
import '../../app/modules/permision_master_module/permision_master_bindings.dart';
import '../../app/modules/attendance_page_module/attendance_page_page.dart';
import '../../app/modules/attendance_page_module/attendance_page_bindings.dart';
import '../../app/modules/login_page_module/login_page_page.dart';
import '../../app/modules/login_page_module/login_page_bindings.dart';
import '../../app/modules/dash_bard_module/dash_bard_page.dart';
import '../../app/modules/dash_bard_module/dash_bard_bindings.dart';
import '../../app/modules/splash_screen_module/splash_screen_bindings.dart';
import '../../app/modules/splash_screen_module/splash_screen_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';


abstract class AppPages {
  static var initialpage = Routes.SPLASH_SCREEN;
  static final pages = [
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => SplashScreenPage(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.DASH_BARD,
      page: () => DashBardPage(),
      binding: DashBardBinding(),
    ),
    GetPage(
      name: Routes.LOGIN_PAGE,
      page: () => LoginPagePage(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: Routes.ATTENDANCE_PAGE,
      page: () => AttendancePagePage(),
      binding: AttendancePageBinding(),
    ),
    GetPage(
      name: Routes.PERMISION_MASTER,
      page: () => PermisionMasterPage(),
      binding: PermisionMasterBinding(),
    ),
    GetPage(
      name: Routes.ONDUTY_MASTER,
      page: () => OndutyMasterPage(),
      binding: OndutyMasterBinding(),
    ),
    GetPage(
      name: Routes.ATTENDANCE_REPORT,
      page: () => AttendanceReportPage(),
      binding: AttendanceReportBinding(),
    ),
    GetPage(
      name: Routes.PERMISTION_REPORT,
      page: () => PermistionReportPage(),
      binding: PermistionReportBinding(),
    ),
    GetPage(
      name: Routes.ONDUTY_REPORT,
      page: () => OndutyReportPage(),
      binding: OndutyReportBinding(),
    ),
    GetPage(
      name: Routes.REPORTS_PAGES,
      page: () => ReportsPagesPage(),
      binding: ReportsPagesBinding(),
    ),
    GetPage(
      name: Routes.LEAVE_REQUEST,
      page: () => LeaveRequestPage(),
      binding: LeaveRequestBinding(),
    ),
  ];
}
