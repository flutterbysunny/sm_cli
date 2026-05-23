import 'package:get/get.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    // TODO: load data
    isLoading.value = false;
  }
}
