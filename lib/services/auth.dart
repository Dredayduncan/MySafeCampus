// import 'package:ashesicom/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  // Instance variables
  final _firebaseAuth = FirebaseAuth.instance; //Firebase instance

  //Track authentication changes
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  //Getting Current user
  User? get currentUser => FirebaseAuth.instance.currentUser;

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try{
      final userCredential = await _firebaseAuth.signInWithCredential(
          EmailAuthProvider.credential(email: email, password: password)
      );

      return userCredential.user;
    }
    catch (e){
      return null;
    }
  }
  // Update the notification token
  Future<dynamic> updateData({userID, token}){
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    return users.doc(userID).update({
      "pushToken": token
    })
        .then((value) => true)
        .catchError((error) => false);
  }


  // // Sign up with email and password
  // Future<User?>createUserWithEmailAndPassword({required String email, required password, required username, required contact}) async {
  //   final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password
  //   );
  //
  //   // try {
  //   //   Database(authID: userCredential.user!.uid).userSignUp(
  //   //     uid: userCredential.user?.uid,
  //   //     username: username,
  //   //     contact: contact
  //   //   );
  //   // } catch (e) {
  //   //   return null;
  //   // }
  //
  //   return userCredential.user;
  // }

  //Log the user out of the application
  Future<void> signOut() async {
    //Sign out of firebase
    await _firebaseAuth.signOut();
  }
}