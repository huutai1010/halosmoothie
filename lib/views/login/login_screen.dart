import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:halo_smoothie/models/token.dart';
import 'package:halo_smoothie/views/login/local_storage_helper.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/profile.dart';

class LoginPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Text(
                    'Halo Smoothie',
                    style: TextStyle(fontSize: 25),
                  ),
                  Image.asset('assets/images/intro.png'),
                  Text(
                    'Welcome to Halo Smoothie',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: screenWidth * .75,
                    child: Text(
                      "Discover a variety of juice recipes suitable for everyone's health and diversify your menu",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 40),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            signInWithGoogle() async {
                              try {
                                //signOut();
                                final GoogleSignInAccount? googleSignInAccount =
                                    await _googleSignIn.signIn();
                                if (googleSignInAccount != null) {
                                  final GoogleSignInAuthentication
                                      googleSignInAuthentication =
                                      await googleSignInAccount.authentication;
                                  final AuthCredential authCredential =
                                      GoogleAuthProvider.credential(
                                          accessToken:
                                              googleSignInAuthentication
                                                  .accessToken,
                                          idToken: googleSignInAuthentication
                                              .idToken);
                                  var responseServer = await _auth
                                      .signInWithCredential(authCredential);
                                  print(
                                      await responseServer.user?.getIdToken());
                                  //https://hqtbe.site/api/v1/oauth2/public/login?idToken=${await response.user?.getIdToken()}
                                  final response = await http.get(Uri.parse(
                                      'https://bifatlaundrybe.online/api/v1/oauth2/public/login?idToken=${await responseServer.user?.getIdToken()}'));
                                  if (response.statusCode == 202) {
                                    final json = jsonDecode(response.body);
                                    print("Heloo $json");
                                    var accessToken =
                                        json['data']['accessToken'];
                                    var refreshToken =
                                        json['data']['refreshToken'];
                                    final SharedPreferences? prefs =
                                        await _prefs;
                                    await prefs?.setString(
                                        'accessToken', accessToken);
                                    await prefs?.setString(
                                        'refreshToken', refreshToken);
                                    LocalStorageHelper.setValue(
                                        'accessToken', accessToken);
                                    LocalStorageHelper.setValue(
                                        'refreshToken', refreshToken);
                                    String fcmToken =
                                        LocalStorageHelper.getValue('fcmToken');
                                    //savingFCMToken(fcmToken);
                                    return true;
                                  } else {
                                    return false;
                                  }
                                }
                              } on FirebaseAuthException catch (e) {
                                print(e);
                                throw e;
                              }
                            }

                            // var _googleUser = GoogleSignIn();
                            // await _googleUser.signIn().then(
                            //       (googleSignInAccount) =>
                            //           googleSignInAccount!.authentication.then(
                            //         (googleSignInAuthentication) {
                            //           print(googleSignInAuthentication.idToken);
                            //           final credential =
                            //               GoogleAuthProvider.credential(
                            //             accessToken: googleSignInAuthentication
                            //                 .accessToken,
                            //             idToken:
                            //                 googleSignInAuthentication.idToken,
                            //           );

                            //           http.get(
                            //             Uri.parse(
                            //                 'https://bifatlaundrybe.online/api/v1/oauth2/public/login?idToken=${googleSignInAuthentication.idToken}'),
                            //             headers: {
                            //               "Authorization":
                            //                   "Bearer ${googleSignInAuthentication.idToken}"
                            //             },
                            //           ).then(
                            //             (response) {
                            //               print(
                            //                   'loginResponse status code = ${response.statusCode}');
                            //               print(
                            //                   'loginResponse body = ${response.body}');

                            //               /* ----------------------- get accessToken ----------------------- */
                            //               var accessTokenProvider =
                            //                   Provider.of<TokenModel>(context,
                            //                       listen: false);

                            //               TokenModel token =
                            //                   TokenModel.fromJson(
                            //                       jsonDecode(response.body));
                            //               accessTokenProvider.updateAccessToken(
                            //                   token.accessToken);

                            //               print(
                            //                   'accessToken = ${token.accessToken}');
                            //               print(
                            //                   'accessTokenProvider = ${accessTokenProvider.accessToken}');

                            //               /*----------------------- get profile  --------------------------*/

                            //               http.get(
                            //                 Uri.parse(
                            //                     'https://api-halosmoothie.azurewebsites.net/api/auth/me'),
                            //                 headers: {
                            //                   "Authorization":
                            //                       "Bearer ${token.accessToken}"
                            //                 },
                            //               ).then(
                            //                 (profileRes) {
                            //                   print(
                            //                       'profileResStatusCode = ${profileRes.statusCode}');
                            //                   print(
                            //                       'profileBody = ${profileRes.body}');
                            //                   ProfileRes profileResponse =
                            //                       ProfileRes.fromJson(
                            //                           jsonDecode(
                            //                               profileRes.body));
                            //                   Provider.of<ProfileRes>(context,
                            //                           listen: false)
                            //                       .updateProfile(
                            //                           profileResponse
                            //                               .statusCode,
                            //                           profileResponse.message,
                            //                           profileResponse.data);

                            //                   print(
                            //                       'PROFILE_PROVIDER = ${profileResponse.data.id}');
                            //                   var customerId =
                            //                       profileResponse.data.id;

                            //                   /* Save FCM Token to db */
                            //                   FirebaseMessaging.instance
                            //                       .getToken()
                            //                       .then(
                            //                     (fcmToken) {
                            //                       print(
                            //                           "FCM Token = $fcmToken");
                            //                       http.post(
                            //                         Uri.parse(
                            //                             'https://api-halosmoothie.azurewebsites.net/api/customers/$customerId?token=$fcmToken'),
                            //                         headers: {
                            //                           "Authorization":
                            //                               "Bearer ${token.accessToken}"
                            //                         },
                            //                       ).then((res) {
                            //                         print(
                            //                             'save fcm token status code = ${res.statusCode}');
                            //                         if (res.statusCode == 200) {
                            //                           print(
                            //                               'Save or update fcm token successfully.');
                            //                         }
                            //                       });
                            //                     },
                            //                   );
                            //                 },
                            //               );
                            //               final credential =
                            //                   GoogleAuthProvider.credential(
                            //                 accessToken:
                            //                     googleSignInAuthentication
                            //                         .accessToken,
                            //                 idToken: googleSignInAuthentication
                            //                     .idToken,
                            //               );
                            //               FirebaseAuth.instance
                            //                   .signInWithCredential(credential);
                            //             },
                            //           );
                            //         },
                            //       ),
                            //     );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Spacer(),
                              Image.asset('assets/images/google.png',
                                  width: 20, height: 20),
                              SizedBox(width: 10),
                              Text(
                                'Login With Google Account',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.7)),
                              ),
                              Spacer()
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Spacer(),
                              Image.asset('assets/images/facebook.png',
                                  width: 20, height: 20),
                              SizedBox(width: 10),
                              Text(
                                'Login With Facebook Account',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.7)),
                              ),
                              Spacer()
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text('Continue as a Guest'))
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -10,
              left: -60,
              child: Container(
                  width: MediaQuery.of(context).size.width * .35,
                  height: MediaQuery.of(context).size.height * .25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 149, 180, 204))),
            ),
            Positioned(
              top: -80,
              child: Container(
                  width: MediaQuery.of(context).size.width * .35,
                  height: MediaQuery.of(context).size.height * .25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 190, 210, 225))),
            ),
          ],
        ),
      ),
    );
  }
}
