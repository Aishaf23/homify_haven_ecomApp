import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';
// Import the User model

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> fetchUsers() async {
    QuerySnapshot snapshot = await _firestore.collection('users').get();
    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
