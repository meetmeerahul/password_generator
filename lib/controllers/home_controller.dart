import 'package:get/get.dart';
import 'package:password_generator/models/dbfunctions/password_manage.dart';
import 'package:password_generator/models/password_model.dart';

class HomeController extends GetxController {
  final slidervalue = 10.0.obs;

  final upper = false.obs;
  final lower = false.obs;
  final numbers = false.obs;
  final symbol = false.obs;
  RxList<PasswordModel> savedPasswords = <PasswordModel>[].obs;

  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
    getSavedPassowrds();
  }
}
