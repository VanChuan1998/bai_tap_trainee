import 'package:dio/dio.dart';
import 'package:bai_tap_trainee/repositories/auth_repository.dart';
import 'package:bai_tap_trainee/ui/commons/app_dialog.dart';
import 'package:bai_tap_trainee/ui/pages/main/main_page.dart';
import 'package:bai_tap_trainee/ui/pages/sign_in/sign_in_page.dart';
import 'package:bai_tap_trainee/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../repositories/user_repository.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository authRepo;
  final UserRepository userRepo;

  SplashCubit({
    required this.authRepo,
    required this.userRepo,
  }) : super(const SplashState());

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    final token = await authRepo.getToken();
    if (token == null) {
      Get.offAll(() => const SignInPage());
    } else {
      try {
        //Profile
        await userRepo.getProfile();
        //Todo
        // authService.updateUser(myProfile);
      } catch (error, s) {
        logger.log(error, stackTrace: s);
        //Check 401
        if (error is DioError) {
          if (error.response?.statusCode == 401) {
            //Todo
            // authService.signOut();
            checkLogin();
            return;
          }
        }
        AppDialog.defaultDialog(
          message: "An error happened. Please check your connection!",
          textConfirm: "Retry",
          onConfirm: () {
            checkLogin();
          },
        );
        return;
      }
      Get.offAll(() => const MainPage());
    }
  }
}
