// @dart=2.9
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signin_up_firebase/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {




    
    return MaterialApp(
      routes: {
      "loginScreen" : (context) => const LoginScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  UserCredential userCredential;
  bool _rememberMe = false;
  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
                  'Email',
          style: kLabelStyle,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter yuor Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        )
      ],
    );
  }

  Widget   _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: kLabelStyle,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: const TextField(
            obscureText: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter yuor Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: MaterialButton(
          padding: const EdgeInsets.only(right: 0.0),
          onPressed: () {},
          child: const Text(
            'Forgot Password?',
            style: kLabelStyle,
          )),
    );
  }

  Widget _buildRememberCheckbox() {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 20.0,
      child: Row(
        children: [
          Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child: Checkbox(
                value: _rememberMe,
                checkColor: Colors.green,
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value;
                  });
                },
              )),
          const Text(
            'Remember me',
            style: kLabelStyle,
          )
        ],
      ),
    );
  }

  Widget _buildLogin() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: MaterialButton(
        color: Colors.white,
        elevation: 5.0,
        onPressed: () {},
        padding: const EdgeInsets.all(15.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: const Text(
          'LOGIN ',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Color(0xFF527DAA)),
        ),
      ),
    );
  }

  Widget _buildSignWith() {
    return Column(
      children: const [
        Text(
          '- OR -',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Sign in with',
          style: kLabelStyle,
        )
      ],
    );
  }

  _buildSignUpWithGoogle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () async {
              userCredential = await FirebaseAuth.instance.signInAnonymously();
              print(userCredential.user.uid);
            },
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                  image: DecorationImage(
                      image: AssetImage('images/anonymous.png'))),
            ),
          ),
          GestureDetector(
            onTap: () async {
              // сначала идёт регистрация
              // 👇👇👇
              // try {
              //  userCredential = await FirebaseAuth.instance
              //       .createUserWithEmailAndPassword(
              //           email: "Ulamuyaman@gmail.com",
              //           password: "sadid123451988");
              // } on FirebaseAuthException catch (e) {
              //   if (e.code == 'weak-password') {
              //     print('The password provided is too weak.');
              //   } else if (e.code == 'email-already-in-use') {
              //     print('The account already exists for that email.');
              //   }
              // } catch (e) {
              //   print(e);
              // }

              try {
                userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: "Ulamuyaman@gmail.com",
                        password: "sadid123451988");
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }
              print(userCredential);
              //Верификация почты 👇👇👇
              // if (userCredential.user.emailVerified == false) {
              //   User user = FirebaseAuth.instance.currentUser;
              //   await user.sendEmailVerification();
              // }
            },
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                  image:
                      DecorationImage(image: AssetImage('images/gmail.png'))),
            ),
          ),
          GestureDetector(
            onTap: () async {
               userCredential = await signInWithGoogle();
              print(userCredential);
            },
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                  image:
                      DecorationImage(image: AssetImage('images/google.jpg'))),
            ),
          ),
          GestureDetector(
            onTap: () {
              print('Login with Facebook');
            },
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                  image: DecorationImage(
                      image: AssetImage('images/facebook.jpg'))),
            ),
          ),
          GestureDetector(
            onTap: () => print('Login with Twitter'),
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                  image:
                      DecorationImage(image: AssetImage('images/twitter.png'))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUp() {
    return GestureDetector(
        onTap: () async {
          try {
            userCredential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: "ulamuyaman@gmail.com", password: "123459090123");
            // print(userCredential);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              User user = FirebaseAuth.instance.currentUser;
              if (userCredential.user.emailVerified == false) {
                await user.sendEmailVerification();
                print(userCredential.user.email);
              }
            } else if (e.code == 'email-already-in-use') {}
          } catch (e) {
            print(e);
          }
        },
        child: Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
          const Text('Dont\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              )),
          TextButton(
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SigneUpScreen();
              }));
            },
            child: const Text('Sign up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                        stops: [
                      0.1,
                      0.4,
                      0.7,
                      0.9
                    ])),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                // color: Colors.lime,
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 100.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          //fontFamily: 'OpenSans'
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      _buildEmail(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      _buildPassword(),
                      _buildForgotPassword(),
                      _buildRememberCheckbox(),
                      _buildLogin(),
                      _buildSignWith(),
                      _buildSignUpWithGoogle(),
                      _buildSignUp(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CONSTANS FILE

const kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: const Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
