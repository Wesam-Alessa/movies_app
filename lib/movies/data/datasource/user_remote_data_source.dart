import 'dart:developer';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/error_message_model.dart';
import 'package:movies_app/movies/data/models/user_model.dart';
import 'package:movies_app/movies/domain/usecase/user/get_user_usecase.dart';

abstract class BaseUserRemoteDataSource {
  Future<UserModel> getUser(UserParameters parameters);
  Future<UserModel> signInWithGoogle();
}

class UserRemoteDataSource extends BaseUserRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<UserModel> getUser(UserParameters parameters) async {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final result = await FirebaseAuth.instance.signInWithCredential(credential);
    log("signInWithGoogle() :=  ${result.user.toString()}");
    return await signIn(result);
  }

  Future<UserModel> signIn(UserCredential userCredential) async {
    ErrorMessageModel errorMessageModel = const ErrorMessageModel(
      statusCode: 0,
      statusMessage: '',
      success: false,
    );
    var result;
    final search =
        await users.where('id', isEqualTo: userCredential.user!.uid).get();
    if (search.docs.isEmpty) {
      var res = await users
          .add(UserModel(
        name: userCredential.user!.displayName ?? "",
        email: userCredential.user!.email ?? "",
        id: userCredential.user!.uid,
        phone: userCredential.user!.phoneNumber ?? "",
      ).toMap())
      .catchError((e) {
        errorMessageModel = ErrorMessageModel(
          statusCode: 404,
          statusMessage: e.toString(),
          success: false,
        );
      });
      await firestore.doc(res.id).get().then((value) {
        result = value;
      });
      log("signIn() 01:=  ${result.id.toString()}");
    } else {
      result = search.docs.first;
      log("signIn() 02:=  ${result.data().toString()}");
    }

    if (result.id.isNotEmpty) {
      return UserModel.fromjson(result.data() as Map<String, dynamic>);
    } else {
      throw ServerException(errorMessageModel: errorMessageModel);
    }
  }
}
