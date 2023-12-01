import 'package:anjastore/config/app_route.dart';
import 'package:anjastore/utils/app_constanta_empty.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/app_text_normal.dart';
import '../../../utils/app_color.dart';
import '../../controllers/dashboard_controller.dart';
import '../../models/sidebar_m.dart';

class Siderbar extends StatelessWidget {
  Siderbar({
    super.key,
    required this.route,
  });

  final String route;

  final _dC = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        width: double.infinity,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        elevation: 0,
        child: Material(
          color: colorPrimaryDark,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 25,
                ),
                Obx(() {
                  if (_dC.user.value == userEmpty) {
                    return const SizedBox();
                  }
                  return Center(
                    child: Text(
                      _dC.user.value.name,
                      style: GoogleFonts.caveat(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 8,
                ),
                Obx(() {
                  if (_dC.roles.isEmpty || _dC.user.value == userEmpty) {
                    return const SizedBox();
                  }
                  return Center(
                    child: Text(
                      _dC.roles
                          .firstWhere((e) => e.roleId == _dC.user.value.role)
                          .roleName,
                      style: GoogleFonts.sourceCodePro(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 45,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        children: List.generate(
                          _dC.menus.length,
                          (index) => _buildMenu(_dC.menus[index]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubMenu(List<SidebarM> submenus) {
    return Column(
      children: submenus.map(
        (submenu) {
          return ListTile(
            onTap: () {
              const Uuid uuid = Uuid();

              String randomUuid = uuid.v4();

              debugPrint("Random UUID: $randomUuid");
              debugPrint("Random DATE: ${DateTime.now().toIso8601String()}");
              navigatorKey.currentContext?.goNamed(submenu.route);
            },
            title: AppTextNormal.labelW600(
              submenu.title,
              16,
              Colors.white,
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _buildMenu(SidebarM sidebar) {
    if (sidebar.submenus.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: sidebar.route == route.split("/")[1] ? Colors.white : null,
        ),
        child: ListTile(
          selectedColor: Colors.amber,
          focusColor: Colors.red,
          selectedTileColor: Colors.black,
          onTap: () {
            const Uuid uuid = Uuid();

            String randomUuid = uuid.v4();

            debugPrint("Random UUID: $randomUuid");
            debugPrint("Random DATE: ${DateTime.now().toIso8601String()}");
            navigatorKey.currentContext?.goNamed(sidebar.route);
          },
          title: AppTextNormal.labelW600(
            sidebar.title,
            16,
            sidebar.route == route.split("/")[1]
                ? colorPrimaryDark
                : Colors.white,
          ),
        ),
      );
    }
    sidebar.submenus.sort((a, b) => a.title.compareTo(b.title));
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 6),
      title: AppTextNormal.labelW600(
        sidebar.title,
        16,
        sidebar.route == route.split("/")[1] ? colorPrimaryDark : Colors.white,
      ),
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      children: List.generate(sidebar.submenus.length, (index) {
        if (sidebar.submenus[index].submenus.isEmpty) {
          if (index + 1 == sidebar.submenus.length) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _buildMenu(sidebar.submenus[index]),
            );
          }
          return _buildMenu(sidebar.submenus[index]);
        }
        return _buildSubMenu(sidebar.submenus[index].submenus);
      }),
    );
  }
}
