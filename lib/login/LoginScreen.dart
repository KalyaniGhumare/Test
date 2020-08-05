import 'package:flutter/material.dart';
import 'package:test_app/Utils.dart';
import 'package:test_app/home/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  /*
  * Global Instance of Controller
  * */
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            /*
            * Background Image
            * */
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/image/background.jpg"),
                      fit: BoxFit.cover)),
            ),
            /*
            * Text,
            * Username password TextField
            * And Login Button
            * */
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 450.0,
                  margin: EdgeInsets.only(right: 30.0, left: 30.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      color: Colors.white),
                  child: Column(
                    children: <Widget>[
                      /*
                      * Text Hi
                      * */
                      Container(
                        height: 90.0,
                        margin: EdgeInsets.only(top: 26.0),
                        child: Text(
                          "Hi",
                          style: TextStyle(
                              fontFamily: "Sofia",
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 80.0),
                        ),
                      ),
                      /*
                      * EditText
                      * Username
                      * */
                      Container(
                        margin: EdgeInsets.only(
                          right: 30.0,
                          left: 30.0,
                          top: 30.0,
                        ),
                        child: Utils.textFrormField(usernameController,
                            'Username/Email', TextInputType.emailAddress),
                      ),
                      /*
                      * Space between Username and Password
                      * */
                      SizedBox(height: 10.0),
                      /*
                      * EditText
                      * Password
                      * */
                      Container(
                          margin: EdgeInsets.only(
                            right: 30.0,
                            left: 30.0,
                            top: 30.0,
                          ),
                          child: Utils.textFrormField(passwordController, 'Password', TextInputType.text)),
                      /*
                      * Button
                      * Login
                      * */
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                /*
                                * On Click on Button
                                * Open Home Screen
                                * */
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              },
                              child: Container(
                                height: 52.0,
                                width: 160.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(80.0),
                                    color: Colors.blue),
                                child: Center(
                                    child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Sofia",
                                      letterSpacing: 0.9),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
