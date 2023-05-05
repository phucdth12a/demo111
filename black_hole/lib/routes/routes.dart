import 'package:black_hole/screens/login/binding/login_binding.dart';
import 'package:black_hole/screens/login/login_screen.dart';
import 'package:black_hole/screens/pref/binding/pref_binding.dart';
import 'package:black_hole/screens/pref/pref_screen.dart';
import 'package:black_hole/screens/root/binding/root_binding.dart';
import 'package:black_hole/screens/root/root_screen.dart';
import 'package:get/route_manager.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String pref = '/pref';

  static List<GetPage<dynamic>> getPages = [
    GetPage(
        name: login, page: () => const LoginScreen(), binding: LoginBinding()),
    GetPage(name: home, page: () => const RootScreen(), binding: RootBinding()),
    GetPage(name: pref, page: () => const PrefScreen(), binding: PrefBiding()),
  ];
}
