import 'package:get/get.dart';
import 'package:password_generator/models/dbfunctions/password_manage.dart';

class HomeController extends GetxController {
  final slidervalue = 10.0.obs;

  final upper = false.obs;
  final lower = false.obs;
  final numbers = false.obs;
  final symbol = false.obs;

  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
    getSavedPassowrds();
  }
}
