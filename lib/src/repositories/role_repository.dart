import 'package:anjastore/src/models/role_m.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RoleRepository {
  Future<List<RoleM>> getRoles();
}

class RoleRepositoryImpl implements RoleRepository {
  final roleCollection = FirebaseFirestore.instance.collection("roles");
  @override
  Future<List<RoleM>> getRoles() async {
    List<RoleM> roles = [];
    try {
      final response = await roleCollection.get();

      for (var data in response.docs) {
        roles.add(RoleM.fromJson(data.data()));
      }
      return roles;
    } catch (e) {
      return [];
    }
  }
}
