import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/error_message_model.dart';
import 'package:movies_app/movies/data/models/user_model.dart';
import 'package:movies_app/movies/domain/usecase/user/get_user_usecase.dart';

abstract class BaseUserRemoteDataSource {
  Future<UserModel?> getUser(UserParameters parameters);
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<UserModel> signUpAnonymous(UserParameters parameters);
  Future<UserModel> logIn(UserParameters parameters);
  Future<UserModel> signOut();
}

class UserRemoteDataSource extends BaseUserRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  UserModel? userModel;

  @override
  Future<UserModel> signUpAnonymous(UserParameters parameters) async {
    final signinResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: parameters.email, password: parameters.password);

    await users
        .doc(signinResult.user!.uid)
        .set(UserModel(
                name: parameters.name,
                email: parameters.email,
                phone: parameters.phone,
                id: signinResult.user!.uid,
                picture: '')
            .toMap())
        .then((value) async {})
        .catchError((e) {
      failedMessage(parameters.context, e.toString());

      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: 404, statusMessage: e.toString(), success: false));
    });

    await getUser(UserParameters(
            userId: signinResult.user!.uid,
            email: signinResult.user!.email!,
            password: parameters.password,
            context: parameters.context))
        .catchError((e) {
      failedMessage(parameters.context, e.toString());

      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: 404, statusMessage: e.toString(), success: false));
    });

    if (userModel != null) {
      return userModel!;
    } else {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: 404,
              statusMessage: "somthing wrong",
              success: false));
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: ['profile', 'email']).signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final result = await FirebaseAuth.instance.signInWithCredential(credential);
    return await socialSignIn(result);
  }

  Future<UserModel> socialSignIn(UserCredential userCredential) async {
    ErrorMessageModel errorMessageModel = const ErrorMessageModel(
      statusCode: 0,
      statusMessage: '',
      success: false,
    );
    // ignore: prefer_typing_uninitialized_variables
    var result;
    await users
        .doc(userCredential.user!.uid)
        .set(UserModel(
                name: userCredential.user!.displayName ?? "",
                email: userCredential.user!.email ?? "",
                id: userCredential.user!.uid,
                phone: userCredential.user!.phoneNumber ?? "",
                picture: userCredential.user!.photoURL ?? "")
            .toMap())
        .catchError((e) {
      errorMessageModel = ErrorMessageModel(
        statusCode: 404,
        statusMessage: e.toString(),
        success: false,
      );
    });
    await users.doc(userCredential.user!.uid).get().then((value) {
      result = value.data();
    });
    if (result != null) {
      return UserModel.fromjson(result as Map<String, dynamic>);
    } else {
      throw ServerException(errorMessageModel: errorMessageModel);
    }
  }

  @override
  Future<UserModel?> getUser(UserParameters parameters) async {
    await users.doc(parameters.getUserId).get().then((value) {
      userModel = UserModel.fromjson(value.data()! as Map<String, dynamic>);
      return userModel;
    }).catchError((e) {
      failedMessage(parameters.context, e.toString());

      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: 404, statusMessage: e.toString(), success: false));
    });
    return userModel;
  }

  @override
  Future<UserModel> logIn(UserParameters parameters) async {
    final signinResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: parameters.email, password: parameters.password)
        .catchError((e) {
      failedMessage(parameters.context, e.toString());
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: 404, statusMessage: e.toString(), success: false));
    });
    await getUser(UserParameters(
            userId: signinResult.user!.uid,
            email: signinResult.user!.email!,
            password: parameters.password,
            context: parameters.context))
        .catchError((e) {
      failedMessage(parameters.context, e.toString());

      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: 404, statusMessage: e.toString(), success: false));
    });

    if (userModel != null) {
      return userModel!;
    } else {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: 404,
              statusMessage: "somthing wrong",
              success: false));
    }
  }

  @override
  Future<UserModel> signInWithFacebook() async {
    final LoginResult loginResult =
        await FacebookAuth.instance.login(permissions: [
      "email",
      "public_profile",
    ], loginBehavior: LoginBehavior.webOnly);
    if (loginResult.accessToken != null) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final result = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      return await socialSignIn(result);
    } else {
      return const UserModel(
          name: '', email: '', id: "", phone: '', picture: '');
    }
  }

  @override
  Future<UserModel> signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      userModel =
          const UserModel(name: '', email: '', id: "", phone: '', picture: '');
    });
    return userModel!;
  }

  failedMessage(context, message) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
