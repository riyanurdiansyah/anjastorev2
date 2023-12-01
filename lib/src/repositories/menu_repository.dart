import 'package:anjastore/src/models/sidebar_m.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MenuRepository {
  Future<List<SidebarM>> getMenus(int role);
}

class MenuRepositoryImpl implements MenuRepository {
  final menuCollection = FirebaseFirestore.instance.collection("menus");

  @override
  Future<List<SidebarM>> getMenus(int role) async {
    List<SidebarM> sidebars = [];
    try {
      final response = await menuCollection.get();
      if (response.docs.isEmpty) {
        return [];
      } else {
        for (var data in response.docs) {
          sidebars.add(SidebarM.fromJson(data.data()));
        }
        sidebars.sort((a, b) => a.title.compareTo(b.title));
        return sidebars.where((e) => e.role.contains(role)).toList();
      }
    } catch (e) {
      return [];
    }
  }
}
