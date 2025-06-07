import 'package:get/get.dart';

class MyController extends GetxController {
  Map<dynamic, dynamic> profiledata = {}.obs;
  Map<dynamic, dynamic> admindata = {}.obs;
  Map<String, dynamic> registerdata = {};
  RxBool isAdmin = false.obs;
}
