import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quickdealsadmin/Model/auth.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;

  var user = Rxn<User>();

  AuthController({required this.authRepository}) {

    authRepository.authStateChanges.listen(_onAuthStateChanged);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      user.value = await authRepository.signInWithEmailAndPassword(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    user.value = null;
  }

  void _onAuthStateChanged(User? newUser) {
    user.value = newUser;
  }

  Future<Map<String, dynamic>?> getUserDetails() async {
    if (user.value == null) {
      return {}; // or throw an exception
    }
    return await authRepository.getUserDetails(user.value!.uid);
  }
}
