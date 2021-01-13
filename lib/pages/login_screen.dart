import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes/constants/app_colors.dart';
import 'package:notes/pages/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";
  final data;

  LoginScreen({this.data});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String textHolder = "Log in";
  bool enabled = true;
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> _signIn() async {
    setState(() {
      enabled = false;
      loading = true;
    });
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await _auth.signInWithCredential(credential);

    print("User Details: ${_auth.currentUser.displayName}");
    return _auth.currentUser;
  }

  handleError(e) {
    print("Sign in Error $e");
    setState(() {
      enabled = true;
      loading = false;
    });
  }

  navigateToHomeScreen() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  void _signOut() {
    try {
      _auth.signOut();
      googleSignIn.signOut();
      setState(() {
        textHolder = "Log in";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/guy_with_notes.jpg",
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: double.infinity,
                    child: Text(
                      "Capture what’s on your mind.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                  child: AbsorbPointer(
                    absorbing: !enabled,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4),
                      splashColor: primaryColor,
                      onTap: () => _signIn()
                          .then((value) => navigateToHomeScreen())
                          .catchError((e) => handleError(e)),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: !loading
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/google.png",
                                        fit: BoxFit.contain,
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Log in to get started")
                                    ],
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Stack introScreen() {
    return Stack(
      fit: StackFit.loose,
      children: [
        Image.asset(
          "assets/images/guy_with_notes.jpg",
          fit: BoxFit.cover,
        ),
      ],
      //     TextButton(
      //   onPressed: () => textHolder.contains("Log in")
      //       ? _signIn()
      //           .then((value) => setState(() {
      //                 textHolder = "Hi, ${value.displayName}\n Log out?";
      //               }))
      //           .catchError((e) => print(e))
      //       : _signOut(),
      //   child: Text(
      //     textHolder,
      //     textAlign: TextAlign.center,
      //     style: TextStyle(fontSize: 50, color: Colors.black),
      //   ),
      // )
    );
  }
}
