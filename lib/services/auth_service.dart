import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:halo_smoothie/main.dart';
import 'package:halo_smoothie/models/account.dart';
import 'package:halo_smoothie/views/login/login_screen.dart';
import 'package:http/io_client.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return MainApp();
        } else {
          return LoginPage();
        }
      },
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>['email']).signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication.then((authen) {
      return authen;
    });

    print('idTokenn = ${googleAuth.idToken}');
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print('idToken = ${credential.idToken}');
    var client = new IOClient(
        new HttpClient()..badCertificateCallback = (cer, host, port) => true);
    client.post(
        Uri.https("api-halosmoothie.azurewebsites.net", "/api/auth/customers"),
        headers: {
          "Authorization": "Bearer ${credential.idToken}"
        }).then((value) {
      print('statusCode = ${value.statusCode}');
      print('body = ${value.body}');
      var account = AccountModel.fromJson(jsonDecode(value.body));
      print('id = ${account.id}');
      print('firstName = ${account.firstName}');
      print('lastName = ${account.lastName}');
      print('email = ${account.email}');
      print('role = ${account.role}');
      print('image = ${account.image}');
    });

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
