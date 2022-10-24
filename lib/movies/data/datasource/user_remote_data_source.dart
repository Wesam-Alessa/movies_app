import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/core/error/exceptions.dart';
import 'package:movies_app/core/network/error_message_model.dart';
import 'package:movies_app/movies/data/models/user_model.dart';
import 'package:movies_app/movies/domain/usecase/user/get_user_usecase.dart';

abstract class BaseUserRemoteDataSource {
  Future<UserModel?> getUser(UserParameters parameters);
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInAnonymous(UserParameters parameters);
  Future<UserModel> logIn(UserParameters parameters);
}

class UserRemoteDataSource extends BaseUserRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  UserModel? userModel;

  @override
  Future<UserModel> signInAnonymous(UserParameters parameters) async {
    final signinResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: parameters.email, password: parameters.password);

    await users
        .doc(signinResult.user!.uid)
        .set(UserModel(
                name: parameters.name,
                email: parameters.email,
                phone: parameters.phone,
                id: signinResult.user!.uid)
            .toMap())
        .then((value) {
      userModel = UserModel(
          name: parameters.name,
          email: parameters.email,
          phone: parameters.phone,
          id: signinResult.user!.uid);
    }).catchError((e) {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: 404, statusMessage: e.toString(), success: false));
    });

    // await getUser(UserParameters(
    //         userId: signinResult.user!.uid,
    //         email: signinResult.user!.email!,
    //         password: parameters.password))
    //     .catchError((e) {
    //   throw ServerException(
    //       errorMessageModel: ErrorMessageModel(
    //           statusCode: 404, statusMessage: e.toString(), success: false));
    // });

    if (userModel!.id.isNotEmpty) {
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

  @override
  Future<UserModel?> getUser(UserParameters parameters) async {
    log("getUser() := ${parameters.gerUserId}");
    await users.doc(parameters.gerUserId).get().then((value) {
      log("getUser() := ${value.data()}");
      userModel = UserModel.fromjson(value.data()! as Map<String, dynamic>);
      return userModel;
    }).catchError((e) {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: 404, statusMessage: e.toString(), success: false));
    });
    return userModel;
  }

  @override
  Future<UserModel> logIn(UserParameters parameters) async {
    final signinResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: parameters.email, password: parameters.password);
    await getUser(UserParameters(
            userId: signinResult.user!.uid,
            email: signinResult.user!.email!,
            password: parameters.password))
        .catchError((e) {
      throw ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: 404, statusMessage: e.toString(), success: false));
    });

    if (userModel!.id.isNotEmpty) {
      return userModel!;
    } else {
      throw const ServerException(
          errorMessageModel: ErrorMessageModel(
              statusCode: 404,
              statusMessage: "somthing wrong",
              success: false));
    }
  }
}
