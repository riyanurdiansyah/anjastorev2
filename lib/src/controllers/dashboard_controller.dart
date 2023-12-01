import 'package:anjastore/src/models/role_m.dart';
import 'package:anjastore/src/models/sidebar_m.dart';
import 'package:anjastore/src/repositories/auth_repository.dart';
import 'package:anjastore/src/repositories/menu_repository.dart';
import 'package:anjastore/src/repositories/role_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../utils/app_constanta_empty.dart';
import '../models/user_m.dart';

class DashboardController extends GetxController {
  final AuthRepository authRepository = AuthRepositoryImpl();

  final RoleRepository roleRepository = RoleRepositoryImpl();

  final MenuRepository menuRepository = MenuRepositoryImpl();

  final Rx<UserM> user = userEmpty.obs;

  final RxList<SidebarM> menus = <SidebarM>[].obs;

  final RxList<RoleM> roles = <RoleM>[].obs;

  final Rx<bool> isLoading = true.obs;

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 1), () async {
      await getRoles();
      await getUser();
      await getMenus();
      await changeLoading(false);
    });
    super.onInit();
  }

  Future changeLoading(bool newValue) async {
    isLoading.value = newValue;
  }

  Future getMenus() async {
    menus.value = await menuRepository.getMenus(user.value.role);
  }

  Future getRoles() async {
    roles.value = await roleRepository.getRoles();
  }

  Future getUser() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final response = await authRepository.getUser(uid);
    if (response != null) {
      user.value = response;
    }
  }
}
