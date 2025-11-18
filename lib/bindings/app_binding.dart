import 'package:get/get.dart';
import 'package:protfolio/controllers/navigation_controller.dart';
import 'package:protfolio/controllers/portfolio_controller.dart';
import 'package:protfolio/controllers/contact_controller.dart';

class AppBinding implements Binding {
  @override
  List<Bind<dynamic>> dependencies() {
    Get.put(PortfolioController(), permanent: true);
    Get.put(NavigationController(), permanent: true);
    Get.put(ContactController(), permanent: true);

    return [];
  }
}
