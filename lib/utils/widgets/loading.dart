import 'package:get/get.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:video_app/utils/constants/colors.dart';

class ProgressDialog {
  static SimpleFontelicoProgressDialog loading = SimpleFontelicoProgressDialog(
    context: Get.context!,
    barrierDimisable: false,
  );

  void show({String message = "Please wait ..."}) {
    loading.show(
      message: message,
      // indicatorColor: AppColors.backGroundColor,
      type: SimpleFontelicoProgressDialogType.iphone,
      backgroundColor: AppColors.background,
      indicatorColor: AppColors.primary,
    );
  }

  void hide() {
    loading.hide();
  }
}
