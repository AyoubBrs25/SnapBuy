import 'dart:async';
import 'package:SnapBuy/Pages/chspage.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import '../Sides/Provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EnterPage extends StatefulWidget {
  const EnterPage({super.key});

  @override
  State<EnterPage> createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('media/Vector.png'), context);
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: LogRegister());
  }
}

class LogRegister extends StatefulWidget {
  const LogRegister({super.key});

  @override
  State<LogRegister> createState() => _LogRegisterState();
}

class _LogRegisterState extends State<LogRegister> {
  bool showlogin = true;
  @override
  Widget build(BuildContext context) {
    double scrwidth = MediaQuery.of(context).size.width;
    double scrheight = MediaQuery.of(context).size.height;
    return Container(
      width: scrwidth,
      height: scrheight,
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.fromLTRB(
            (5.5555 * scrwidth) / 100,
            (10.9375 * scrheight) / 100,
            (5.5555 * scrwidth) / 100,
            (3.125 * scrheight) / 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Animate(
              effects: [
                ScaleEffect(duration: 700.ms),
                SlideEffect(duration: 700.ms)
              ],
              child: Container(
                width: (19.4444 * scrwidth) / 100,
                height: (10.9375 * scrheight) / 100,
                child: Image(
                  image: AssetImage('media/Vector.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Animate(
              effects: [
                FadeEffect(delay: 200.ms, duration: 700.ms),
                SlideEffect(delay: 200.ms, duration: 700.ms)
              ],
              child: Padding(
                padding: EdgeInsets.only(top: (3.125 * scrheight) / 100),
                child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation.drive(Tween(begin: 0, end: 1)),
                        child: child,
                      );
                    },
                    child: Text(
                      showlogin ? 'Login to Account' : 'Create Account',
                      style: TextStyle(
                        fontSize: (8.8888 * scrwidth) / 100,
                        fontFamily: 'Kunika',
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ),
            ),
            Animate(
              effects: [
                FadeEffect(delay: 400.ms, duration: 700.ms),
                SlideEffect(delay: 400.ms, duration: 700.ms)
              ],
              child: Padding(
                padding: EdgeInsets.only(
                    top: (3.125 * scrheight) / 100,
                    bottom: (2.34375 * scrheight) / 100),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 700),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation.drive(Tween(begin: 0, end: 1)),
                      child: child,
                    );
                  },
                  child: showlogin == true ? Login() : Signup(),
                ),
              ),
            ),
            Animate(
              effects: [
                FadeEffect(delay: 600.ms, duration: 700.ms),
                SlideEffect(delay: 600.ms, duration: 700.ms)
              ],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: (11.1111 * scrwidth) / 100),
                    width: (22.2222 * scrwidth) / 100,
                    height: (0.3125 * scrheight) / 100,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface ==
                                Color(0xff141218)
                            ? Color(0xd8ffffff)
                            : Color(0x1A000000),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Text(
                    'Or',
                    style: TextStyle(
                      fontSize: (5.56 * scrwidth) / 100,
                      fontFamily: 'Kunika',
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.surface ==
                              Color(0xfffffbfe)
                          ? Colors.black
                          : Color(0xfffffbfe),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: (11.1111 * scrwidth) / 100),
                    width: (22.2222 * scrwidth) / 100,
                    height: (0.3125 * scrheight) / 100,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface ==
                                Color(0xff141218)
                            ? Color(0xd8ffffff)
                            : Color(0x1A000000),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ],
              ),
            ),
            Animate(
              effects: [
                FadeEffect(delay: 800.ms, duration: 700.ms),
                SlideEffect(
                    delay: 800.ms, duration: 700.ms, begin: Offset(0, 1))
              ],
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: (1.5625 * scrheight) / 100),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 10,
                            spreadRadius: 1),
                      ],
                      color: Theme.of(context).colorScheme.surface ==
                          Color(0xff141218)
                          ? Colors.black87
                          : Colors.white),
                  child: TextButton(
                      style: ButtonStyle(
                          overlayColor:
                          WidgetStatePropertyAll<Color>(Colors.transparent)),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: (8.3333 * scrwidth) / 100,
                            height: (9.375 * scrheight) / 100,
                            child: Image(
                              image: AssetImage('media/facebook.png'),
                            ),
                          ),
                          SizedBox(
                            width: (2.7777 * scrwidth) / 100,
                          ),
                          Text(
                            showlogin
                                ? 'Login with facebook'
                                : 'SignUp with facebook',
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontSize: (4.72 * scrwidth) / 100,
                                color:
                                    Theme.of(context).colorScheme.surface ==
                                            Color(0xff141218)
                                        ? Color(0xd8ffffff)
                                        : Colors.black),
                          )
                        ],
                      )),
                ),
              ),
            ),
            Animate(
              effects: [
                FadeEffect(),
                SlideEffect(
                    delay: 1000.ms, duration: 700.ms, begin: Offset(0, 2))
              ],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  showlogin
                      ? Text(
                          "Don't have an accont?",
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontSize: (5.56 * scrwidth)/100,
                              color: Colors.grey),
                        )
                      : Text(
                          'Already have an account?',
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontSize: (5.56 * scrwidth)/100,
                              color: Colors.grey),
                        ),
                  TextButton(
                      style: ButtonStyle(
                          padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                              EdgeInsets.only(left: 0)),
                          overlayColor: WidgetStatePropertyAll<Color>(
                              Colors.transparent)),
                      onPressed: () {
                        setState(() {
                          showlogin = !showlogin;
                        });
                      },
                      child: showlogin
                          ? Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: (5.56 * scrwidth)/100,
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).colorScheme.surface ==
                                            Color(0xfffffbfe)
                                        ? Colors.black87
                                        : Colors.white,
                              ),
                            )
                          : Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: (5.56 * scrwidth)/100,
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).colorScheme.surface ==
                                            Color(0xfffffbfe)
                                        ? Colors.black87
                                        : Colors.white,
                              ),
                            ))
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

//login
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  FocusNode passfocs = FocusNode();
  FocusNode btnfocs = FocusNode();
  TextEditingController emailcnt = TextEditingController();
  TextEditingController passcnt = TextEditingController();
  bool showpasswrd = false;

  late AnimationController _scalanimationcnt;

  late Animation<double> _scale;

  bool slid = false;

  @override
  void initState() {
    super.initState();
    _scalanimationcnt =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt.reverse();
        }
      });
  }


  Future<Map<String, dynamic>> login(String email, String password) async {

    print('hello');
    setState(() {
      slid = !slid;
    });
    final url = Uri.parse('http://127.0.0.1:8000/api/Login');
    print('login app');
    final response = await http.post(
      url,
      body: json.encode({'Email': email, 'Password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    print('hello2');
    setState(() {
      slid = !slid;
    });

    if (response.statusCode == 200) {
      // Successful login
      return json.decode(response.body);
    } else {
      // Failed login

      return json.decode(response.body);
    }
  }

  void logine() async {
    final email = emailcnt.text;
    final password = passcnt.text;

    try {
      print('11');
      final response = await login(email, password);
      print('12');
      print(response);
    } catch (e) {
      print('not me');
      print('Login failed: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scalanimationcnt.dispose();
  }

  bool erremail = false;
  bool errpass = false;

  @override
  Widget build(BuildContext context) {
    KeepProvider prvd = Provider.of<KeepProvider>(context, listen: false);
    double scrwidth = MediaQuery.of(context).size.width;
    double scrheight = MediaQuery.of(context).size.height;
    return Container(
      width: scrwidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: (2.34375 * scrheight) / 100),
            padding:
                EdgeInsets.symmetric(horizontal: (2.7777 * scrwidth) / 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface ==
                        Color(0xff141218)
                    ? Color(0xd8ffffff)
                    : Color(0x1A000000),
                border: Border.all(
                    width: 1,
                    color: erremail ? Colors.red : Colors.transparent)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: (12.5 * scrwidth) / 100,
                  height: (7.03125 * scrheight) / 100,
                  decoration: BoxDecoration(
                      color: prvd.first.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    EvaIcons.email,
                    color: prvd.first,
                    size: (6.9444 * scrwidth) / 100,
                  ),
                ),
                Container(
                  width: (69.4444 * scrwidth) / 100,
                  padding: EdgeInsets.only(
                      left: (1.94444 * scrwidth) / 100,
                      right: (0.5555 * scrwidth) / 100),
                  child: TextFormField(
                    onChanged: (v) {
                      setState(() {});
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(passfocs);
                    },
                    controller: emailcnt,
                    style: TextStyle(
                        fontSize: (5 * scrwidth) / 100,
                        fontFamily: 'Kunika',
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: (1.25 * scrheight) / 100),
                      label: Padding(
                        padding:
                            EdgeInsets.only(left: (1.38888 * scrwidth) / 100),
                        child: Text(
                          'Email',
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontSize: (5 * scrwidth) / 100,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff252525)),
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    cursorColor: prvd.first,
                    cursorWidth: 2,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: (2.7777 * scrwidth) / 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface ==
                        Color(0xff141218)
                    ? Color(0xd8ffffff)
                    : Color(0x1A000000),
                border: Border.all(
                    width: 1,
                    color: errpass ? Colors.red : Colors.transparent)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: (12.5 * scrwidth) / 100,
                    height: (7.03125 * scrheight) / 100,
                    decoration: BoxDecoration(
                        color: prvd.first.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: IconButton(
                        style: ButtonStyle(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                        ),
                        icon: showpasswrd
                            ? Icon(
                                EvaIcons.eyeOff,
                                size: (6.9444 * scrwidth) / 100,
                                color: prvd.first,
                              )
                            : Icon(
                                EvaIcons.eye,
                          size: (6.9444 * scrwidth) / 100,
                                color: prvd.first,
                              ),
                        onPressed: () {
                          setState(() {
                            showpasswrd = !showpasswrd;
                          });
                        })),
                Container(
                  width: (69.4444 * scrwidth) / 100,
                  padding: EdgeInsets.only(
                      left: (1.94444 * scrwidth) / 100,
                      right: (0.5555 * scrwidth) / 100),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    focusNode: passfocs,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(btnfocs);
                    },
                    controller: passcnt,
                    style: TextStyle(
                        fontSize: (5 * scrwidth) / 100,
                        fontFamily: 'Kunika',
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: (1.25 * scrheight) / 100),
                      label: Padding(
                        padding:
                            EdgeInsets.only(left: (1.38888 * scrwidth) / 100),
                        child: Text(
                          'Password',
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontSize: (5 * scrwidth) / 100,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff252525)),
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    cursorColor: prvd.first,
                    cursorWidth: 2,
                    obscureText: !showpasswrd,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              style: ButtonStyle(
                  overlayColor:
                      WidgetStatePropertyAll<Color>(Colors.transparent)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgetPass()));
              },
              child: Text(
                'Forget Password?',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Kunika',
                  fontSize: (5 * scrwidth) / 100,
                  color: Theme.of(context).colorScheme.surface ==
                          Color(0xfffffbfe)
                      ? Colors.black
                      : Color(0xfffffbfe),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
              animation: _scalanimationcnt,
              builder: (context, child) => Transform.scale(
                    scale: _scale.value,
                    child: Container(
                      width: (41.6666 * scrwidth) / 100,
                      height: (7.8125 * scrheight) / 100,
                      decoration: BoxDecoration(
                        color:
                            passcnt.text.length >= 6 && emailcnt.text.isNotEmpty
                                ? prvd.first
                                : prvd.first.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 10,
                              spreadRadius: 1),
                        ],
                      ),
                      child: TextButton(
                        focusNode: btnfocs,
                        style: ButtonStyle(
                            overlayColor: WidgetStatePropertyAll<Color>(
                                Colors.transparent)),
                        onPressed: () {
                          _scalanimationcnt.forward();
                          if (passcnt.text.length >= 6 &&
                              !slid &&
                              !emailcnt.text.isEmpty) {
                            logine();

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ChoosePge()));
                          }
                          if (emailcnt.text.isEmpty &&
                              passcnt.text.isNotEmpty) {
                            setState(() {
                              erremail = true;
                            });
                            Vibration.vibrate(duration: 200);
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                erremail = false;
                              });
                            });
                          } else if (emailcnt.text.isEmpty) {
                            setState(() {
                              errpass = true;
                              erremail = true;
                            });
                            Vibration.vibrate(duration: 200);
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                erremail = false;
                                errpass = false;
                              });
                            });
                          } else if (passcnt.text.isEmpty) {
                            setState(() {
                              errpass = true;
                            });

                            Vibration.vibrate(duration: 200);
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                errpass = false;
                              });
                            });
                          }
                        },
                        child: Animate(
                            effects: [
                              SlideEffect(
                                  delay: 300.ms,
                                  duration: 700.ms,
                                  begin: Offset(0, 1)),
                              FadeEffect(delay: 300.ms, duration: 700.ms)
                            ],
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale:
                                      animation.drive(Tween(begin: 0, end: 1)),
                                  child: child,
                                );
                              },
                              child: slid
                                  ? LoadingAnimationWidget.fourRotatingDots(
                                      color: Theme.of(context)
                                                  .colorScheme
                                                  .surface ==
                                              Color(0xfffffbfe)
                                          ? Colors.white
                                          : Colors.black87,
                                      size: (8.3333 * scrwidth) / 100)
                                  : Text(
                                      'Log in',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Kunika',
                                        fontSize: (5.8333 * scrwidth) / 100,
                                        color: Theme.of(context)
                                                    .colorScheme
                                                    .surface ==
                                                Color(0xfffffbfe)
                                            ? Colors.white
                                            : Theme.of(context)
                                                .colorScheme
                                                .surface,
                                      ),
                                    ),
                            )),
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}
//end login

//signup
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  FocusNode emailfocs = FocusNode();
  FocusNode passfocs = FocusNode();
  FocusNode btnfocs = FocusNode();
  TextEditingController namecnt = TextEditingController();
  TextEditingController emailcnt = TextEditingController();
  TextEditingController passcnt = TextEditingController();
  bool showpasswrd = false;
  bool acptrm = false;

  late AnimationController _scalanimationcnt;

  late Animation<double> _scale;

  bool slid = false;

  @override
  void initState() {
    super.initState();
    _scalanimationcnt =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scale = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt.reverse();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scalanimationcnt.dispose();
  }

  bool erruser = false;
  bool erremail = false;
  bool errpass = false;

  @override
  Widget build(BuildContext context) {
    KeepProvider prvd = Provider.of<KeepProvider>(context, listen: false);
    double scrwidth = MediaQuery.of(context).size.width;
    double scrheight = MediaQuery.of(context).size.height;
    return Container(
      width: scrwidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: (2.34375 * scrheight) / 100),
            padding:
                EdgeInsets.symmetric(horizontal:  (2.7778 * scrwidth) / 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface ==
                        Color(0xff141218)
                    ? Color(0xd8ffffff)
                    : Color(0x1A000000),
                border: Border.all(
                    width: 1,
                    color: erruser ? Colors.red : Colors.transparent)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: (12.5 * scrwidth) / 100,
                  height: (7.03125 * scrheight) / 100,
                  decoration: BoxDecoration(
                    color: prvd.first.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    EvaIcons.person,
                    color: prvd.first,
                    size: (6.9444 * scrwidth) / 100,
                  ),
                ),
                Container(
                  width: (69.4444 * scrwidth) / 100,
                  padding: EdgeInsets.only(
                      left: (1.94444 * scrwidth) / 100,
                      right: (0.5555 * scrwidth) / 100),
                  child: TextFormField(
                    onChanged: (v) {
                      setState(() {});
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(emailfocs);
                    },
                    controller: namecnt,
                    style: TextStyle(
                        fontSize: (5 * scrwidth) / 100,
                        fontFamily: 'Kunika',
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: (1.25 * scrheight) / 100),
                      label: Padding(
                        padding:
                            EdgeInsets.only(left: (1.38888 * scrwidth) / 100),
                        child: Text(
                          'UserName',
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontSize: (5 * scrwidth) / 100,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff252525)),
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    cursorColor: prvd.first,
                    cursorWidth: 2,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: (2.34375 * scrheight) / 100),
            padding:
                EdgeInsets.symmetric(horizontal: (2.7777 * scrwidth) / 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface ==
                        Color(0xff141218)
                    ? Color(0xd8ffffff)
                    : Color(0x1A000000),
                border: Border.all(
                    width: 1,
                    color: erremail ? Colors.red : Colors.transparent)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: (12.5 * scrwidth) / 100,
                  height: (7.03125 * scrheight) / 100,
                  decoration: BoxDecoration(
                    color: prvd.first.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    EvaIcons.email,
                    color: prvd.first,
                    size: (6.9444 * scrwidth) / 100,
                  ),
                ),
                Container(
                  width: (69.4444 * scrwidth) / 100,
                  padding: EdgeInsets.only(
                      left: (1.94444 * scrwidth) / 100,
                      right: (0.5555 * scrwidth) / 100),
                  child: TextFormField(
                    onChanged: (v) {
                      setState(() {});
                    },
                    focusNode: emailfocs,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(passfocs);
                    },
                    controller: emailcnt,
                    style: TextStyle(
                        fontSize: (5 * scrwidth) / 100,
                        fontFamily: 'Kunika',
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: (1.25 * scrheight) / 100),
                      label: Padding(
                        padding:
                            EdgeInsets.only(left: (1.38888 * scrwidth) / 100),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontFamily: 'Kunika',
                            fontSize: (5 * scrwidth) / 100,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff252525),
                          ),
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    cursorColor: prvd.first,
                    cursorWidth: 2,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: (2.7777 * scrwidth) / 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.surface ==
                        Color(0xff141218)
                    ? Color(0xd8ffffff)
                    : Color(0x1A000000),
                border: Border.all(
                    width: 1,
                    color: errpass ? Colors.red : Colors.transparent)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: (12.5 * scrwidth) / 100,
                    height: (7.03125 * scrheight) / 100,
                    decoration: BoxDecoration(
                      color: prvd.first.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                        style: ButtonStyle(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                        ),
                        icon: showpasswrd
                            ? Icon(
                                EvaIcons.eyeOff,
                          size: (6.9444 * scrwidth) / 100,
                                color: prvd.first,
                              )
                            : Icon(
                                EvaIcons.eye,
                          size: (6.9444 * scrwidth) / 100,
                                color: prvd.first,
                              ),
                        onPressed: () {
                          setState(() {
                            showpasswrd = !showpasswrd;
                          });
                        })),
                Container(
                  width: (69.4444 * scrwidth) / 100,
                  padding: EdgeInsets.only(
                      left: (1.94444 * scrwidth) / 100,
                      right: (0.5555 * scrwidth) / 100),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    focusNode: passfocs,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(btnfocs);
                    },
                    controller: passcnt,
                    style: TextStyle(
                        fontSize: (5 * scrwidth) / 100,
                        fontFamily: 'Kunika',
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: (1.25 * scrheight) / 100),
                      label: Padding(
                        padding:
                            EdgeInsets.only(left: (1.38888 * scrwidth) / 100),
                        child: Text(
                          'Password',
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontSize: (5 * scrwidth) / 100,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff252525)),
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    cursorColor: prvd.first,
                    cursorWidth: 2,
                    obscureText: !showpasswrd,
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MSHCheckbox(
                duration: Duration(milliseconds: 200),
                size: (5.5556 * scrwidth) / 100,
                value: acptrm,
                colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                  checkedColor: prvd.first,
                  uncheckedColor: Theme.of(context).colorScheme.surface ==
                          Color(0xff141218)
                      ? Color(0xd8ffffff)
                      : Color(0x1A000000),
                ),
                style: MSHCheckboxStyle.fillScaleColor,
                onChanged: (selected) {
                  setState(() {
                    acptrm = selected;
                  });
                },
              ),
              SizedBox(
                width: (2.7777 * scrwidth) / 100,
              ),
              Text(
                'I accepte all the',
                style: TextStyle(
                    fontSize: (5 * scrwidth) / 100,
                    fontFamily: 'Kunika',
                    color: Colors.grey),
              ),
              TextButton(
                style: ButtonStyle(
                    overlayColor:
                        WidgetStatePropertyAll<Color>(Colors.transparent),
                    padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsets.only(left: 2))),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TermsCond()));
                },
                child: Text(
                  'Terms&Conditions',
                  style: TextStyle(
                    fontSize: (5 * scrwidth) / 100,
                    fontFamily: 'Kunika',
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.surface ==
                            Color(0xfffffbfe)
                        ? Colors.black87
                        : Colors.white,
                  ),
                ),
              )
            ],
          ),
          AnimatedBuilder(
              animation: _scalanimationcnt,
              builder: (context, child) => Transform.scale(
                    scale: _scale.value,
                    child: Container(
                      width: (41.6666 * scrwidth) / 100,
                      height: (7.8125 * scrheight) / 100,
                      decoration: BoxDecoration(
                        color: passcnt.text.length >= 6 &&
                                acptrm &&
                                !emailcnt.text.isEmpty &&
                                !namecnt.text.isEmpty
                            ? prvd.first
                            : prvd.first.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 10,
                              spreadRadius: 1),
                        ],
                      ),
                      child: TextButton(
                        focusNode: btnfocs,
                        style: ButtonStyle(
                            overlayColor: WidgetStatePropertyAll<Color>(
                                Colors.transparent)),
                        onPressed: () {
                          _scalanimationcnt.forward();
                          if (passcnt.text.length >= 6 &&
                              !slid &&
                              acptrm &&
                              !emailcnt.text.isEmpty) {
                            setState(() {
                              slid = !slid;
                            });
                            Future.delayed(Duration(milliseconds: 2000), () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          verificat(Codepass: false)));
                              setState(() {
                                slid = !slid;
                              });
                            });
                          }
                          if (namecnt.text.isEmpty &&
                              emailcnt.text.isEmpty &&
                              passcnt.text.isEmpty) {
                            setState(() {
                              errpass = true;
                              erremail = true;
                              erruser = true;
                            });
                            Vibration.vibrate(duration: 200);
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                errpass = false;
                                erremail = false;
                                erruser = false;
                              });
                            });
                          } else if (emailcnt.text.isEmpty &&
                              passcnt.text.isEmpty) {
                            setState(() {
                              erremail = true;
                              errpass = true;
                            });
                            Vibration.vibrate(duration: 200);
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                erremail = false;
                                errpass = false;
                              });
                            });
                          } else if (namecnt.text.isEmpty &&
                              passcnt.text.isEmpty) {
                            setState(() {
                              errpass = true;
                              erruser = true;
                            });
                            Vibration.vibrate(duration: 200);
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                errpass = false;
                                erruser = false;
                              });
                            });
                          } else if (namecnt.text.isEmpty &&
                              emailcnt.text.isEmpty) {
                            setState(() {
                              erremail = true;
                              erruser = true;
                            });
                            Vibration.vibrate(duration: 200);
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                erremail = false;
                                erruser = false;
                              });
                            });
                          } else if (namecnt.text.isEmpty) {
                            setState(() {
                              erruser = true;
                            });
                            Vibration.vibrate(duration: 200);
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                erruser = false;
                              });
                            });
                          } else if (emailcnt.text.isEmpty) {
                            setState(() {
                              erremail = true;
                            });
                            Vibration.vibrate(duration: 200);
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                erremail = false;
                              });
                            });
                          } else if (passcnt.text.isEmpty) {
                            setState(() {
                              errpass = true;
                            });
                            Vibration.vibrate(duration: 200);
                            Future.delayed(Duration(milliseconds: 500), () {
                              setState(() {
                                errpass = false;
                              });
                            });
                          }
                        },
                        child: Animate(
                            effects: [
                              SlideEffect(
                                  duration: 700.ms, begin: Offset(0, 1)),
                              FadeEffect(duration: 700.ms)
                            ],
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale:
                                      animation.drive(Tween(begin: 0, end: 1)),
                                  child: child,
                                );
                              },
                              child: slid
                                  ? LoadingAnimationWidget.fourRotatingDots(
                                      color: Theme.of(context)
                                                  .colorScheme
                                                  .surface ==
                                              Color(0xfffffbfe)
                                          ? Colors.white
                                          : Colors.black87,
                                      size: (8.3333 * scrwidth) / 100)
                                  : Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Kunika',
                                        fontSize: (5.8333 * scrwidth) / 100,
                                        color: Theme.of(context)
                                                    .colorScheme
                                                    .surface ==
                                                Color(0xfffffbfe)
                                            ? Colors.white
                                            : Theme.of(context)
                                                .colorScheme
                                                .surface,
                                      ),
                                    ),
                            )),
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}
//end signup

//Terms&Condition
class TermsCond extends StatefulWidget {
  const TermsCond({super.key});

  @override
  State<TermsCond> createState() => _TermsCondState();
}

class _TermsCondState extends State<TermsCond> {
  @override
  Widget build(BuildContext context) {
    double scrwidth = MediaQuery.of(context).size.width;
    double scrheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          style: ButtonStyle(
              overlayColor:
                  WidgetStatePropertyAll<Color>(Colors.transparent)),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            EvaIcons.arrowIosBack,
            size: (7.5 * scrwidth) / 100,
            color: Theme.of(context).colorScheme.surface == Color(0xfffffbfe)
                ? Colors.black87
                : Colors.white70,
          ),
        ),
        title: Text(
          'Terms&Conditions',
          style: TextStyle(
            fontFamily: 'Kunika',
            fontWeight: FontWeight.bold,
            fontSize: (5.8333 * scrwidth) / 100,
            color: Theme.of(context).colorScheme.surface == Color(0xfffffbfe)
                ? Colors.black87
                : Colors.white70,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: (5.5555 * scrwidth) / 100,
            vertical: (1.5625 * scrheight) / 100),
        child: Text(
          '1. Use of Service\n'
          '- Must be 18 or older.\n'
          '- Maintain account confidentiality.\n'
          '- No prohibited activities.\n\n'
          '2. Purchases\n'
          '- Accurate product listings.\n'
          '- Agree to pay specified price, taxes, and shipping.\n'
          '- Payment via accepted methods.\n'
          '- No guaranteed delivery dates.\n\n'
          '3. Intellectual Property\n'
          '- SnapBuy owns content and materials.\n'
          '- Limited license for personal, non-commercial use.\n\n'
          '4. Privacy\n'
          '- Review Privacy Policy for information handling.\n\n'
          '5. Disclaimers\n'
          '- Service provided "as is" without warranties.\n'
          '- SnapBuy not liable for indirect or consequential damages.\n\n'
          '6. Indemnification\n'
          '- Agree to defend SnapBuy against claims related to use.\n\n'
          '7. Governing Law\n'
          '- Governed by laws of [Your Jurisdiction].\n\n'
          '8. Changes to Terms\n'
          '- SnapBuy may modify Terms, continued use constitutes acceptance.\n\n'
          '9. Contact\n'
          '- Questions? Contact us at [snapbuy.contact@gmail.com].',
          style: TextStyle(
            fontSize: (4.7222 * scrwidth) / 100,
          ),
        ),
      ),
    );
  }
}
//End of Terms&Condition

//forget password
class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> with TickerProviderStateMixin {
  TextEditingController inputcnt = TextEditingController();
  FocusNode bntfocs = FocusNode();

  late AnimationController _scalanimationcnt;

  late Animation<double> _scale;

  bool slid = false;

  @override
  void initState() {
    super.initState();
    _scalanimationcnt = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scale = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt.reverse();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scalanimationcnt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scrwidth = MediaQuery.of(context).size.width;
    double scrheight = MediaQuery.of(context).size.height;
    KeepProvider prvd = Provider.of<KeepProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          style: ButtonStyle(
              overlayColor:
                  WidgetStatePropertyAll<Color>(Colors.transparent)),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            EvaIcons.arrowIosBack,
            size: (7.5 * scrwidth) / 100,
            color: Theme.of(context).colorScheme.surface == Color(0xfffffbfe)
                ? Colors.black87
                : Colors.white70,
          ),
        ),
      ),
      body: Container(
        width: scrwidth,
        height: scrheight,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
              (5.5555 * scrwidth) / 100,
              (3.90625 * scrheight) / 100,
              (5.5555 * scrwidth) / 100,
              (3.125 * scrheight) / 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Animate(
                effects: [
                  FadeEffect(duration: 700.ms),
                  SlideEffect(duration: 700.ms)
                ],
                child: Container(
                  width: (19.4444 * scrwidth) / 100,
                  height: (10.9375 * scrheight) / 100,
                  child: Image(
                    image: AssetImage('media/Vector.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Animate(
                effects: [
                  FadeEffect(delay: 200.ms, duration: 700.ms),
                  SlideEffect(delay: 200.ms, duration: 700.ms)
                ],
                child: Padding(
                  padding: EdgeInsets.only(
                      top: (3.125 * scrheight) / 100,
                      bottom: (3.125 * scrheight) / 100),
                  child: Text(
                    'Forget Password',
                    style: TextStyle(
                      fontSize: (8.8888 * scrwidth) / 100,
                      fontFamily: 'Kunika',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Animate(
                effects: [
                  FadeEffect(delay: 400.ms, duration: 700.ms),
                  SlideEffect(delay: 400.ms, duration: 700.ms)
                ],
                child: Container(
                  margin: EdgeInsets.only(bottom: (2.34375 * scrheight) / 100),
                  padding: EdgeInsets.symmetric(
                      horizontal: (2.7777 * scrwidth) / 100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.surface ==
                            Color(0xff141218)
                        ? Color(0xd8ffffff)
                        : Color(0x1A000000),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: (12.5 * scrwidth) / 100,
                        height: (7.03125 * scrheight) / 100,
                        decoration: BoxDecoration(
                            color: prvd.first.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          EvaIcons.info,
                          color: prvd.first,
                          size: (6.9444 * scrwidth) / 100,
                        ),
                      ),
                      Container(
                        width: (69.4444 * scrwidth) / 100,
                        padding: EdgeInsets.only(
                            left: (1.94444 * scrwidth) / 100,
                            right: (0.5555 * scrwidth) / 100),
                        child: TextFormField(
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(bntfocs);
                          },
                          onChanged: (v) {
                            setState(() {});
                          },
                          controller: inputcnt,
                          style: TextStyle(
                              fontSize: (5 * scrwidth) / 100,
                              fontFamily: 'Kunika',
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: (1.25 * scrheight) / 100),
                            label: Padding(
                              padding: EdgeInsets.only(
                                  left: (1.38888 * scrwidth) / 100),
                              child: Text(
                                'Enter your email',
                                style: TextStyle(
                                    fontFamily: 'Kunika',
                                    fontSize: (5 * scrwidth) / 100,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff252525)),
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                          cursorColor: prvd.first,
                          cursorWidth: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Animate(
                  effects: [
                    SlideEffect(delay: 600.ms, duration: 700.ms),
                    FadeEffect(delay: 600.ms, duration: 700.ms)
                  ],
                  child: AnimatedBuilder(
                    animation: _scalanimationcnt,
                    builder: (context, child) => Transform.scale(
                      scale: _scale.value,
                      child: Container(
                        margin:
                            EdgeInsets.only(top: (2.34375 * scrheight) / 100),
                        width: (41.6666 * scrwidth) / 100,
                        height: (7.8125 * scrheight) / 100,
                        decoration: BoxDecoration(
                          color: !inputcnt.text.isEmpty
                              ? prvd.first
                              : prvd.first.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 10,
                                spreadRadius: 1),
                          ],
                        ),
                        child: TextButton(
                          focusNode: bntfocs,
                          style: ButtonStyle(
                              overlayColor: WidgetStatePropertyAll<Color>(
                                  Colors.transparent)),
                          onPressed: () {
                            _scalanimationcnt.forward();
                            if (!inputcnt.text.isEmpty) {
                              setState(() {
                                slid = !slid;
                              });
                              Future.delayed(Duration(milliseconds: 1550), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            verificat(Codepass: true)));
                                setState(() {
                                  slid = !slid;
                                });
                              });
                            }
                          },
                          child: Animate(
                              effects: [
                                FadeEffect(delay: 700.ms, duration: 700.ms),
                                SlideEffect(
                                    delay: 700.ms,
                                    duration: 700.ms,
                                    begin: Offset(0, 1))
                              ],
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                transitionBuilder: (child, animation) {
                                  return ScaleTransition(
                                    scale: animation
                                        .drive(Tween(begin: 0, end: 1)),
                                    child: child,
                                  );
                                },
                                child: slid
                                    ? LoadingAnimationWidget.fourRotatingDots(
                                        color: Theme.of(context)
                                                    .colorScheme
                                                    .surface ==
                                                Color(0xfffffbfe)
                                            ? Colors.white
                                            : Colors.black87,
                                        size: (8.3333 * scrwidth) / 100)
                                    : Text(
                                        'Send',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Kunika',
                                          fontSize: (5.8333 * scrwidth) / 100,
                                          color: Theme.of(context)
                                                      .colorScheme
                                                      .surface ==
                                                  Color(0xfffffbfe)
                                              ? Colors.white
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                        ),
                                      ),
                              )),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
//end forget password

//verification
class verificat extends StatefulWidget {
  final bool? Codepass;
  const verificat({required this.Codepass});

  @override
  State<verificat> createState() => _verificatState();
}

class _verificatState extends State<verificat> with TickerProviderStateMixin {
  TextEditingController inputcnt = TextEditingController();
  TextEditingController inputcnt1 = TextEditingController();
  TextEditingController inputcnt2 = TextEditingController();
  TextEditingController inputcnt3 = TextEditingController();

  bool? pass;

  late AnimationController _scalanimationcnt;

  late Animation<double> _scale;

  bool slid = false;

  @override
  void initState() {
    super.initState();

    StartTime();
    pass = widget.Codepass;

    _scalanimationcnt =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt.reverse();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scalanimationcnt.dispose();
  }

  FocusNode bntfocs = FocusNode();
  bool res = false;
  Timer? time;
  int sec = 30;
  int min = 1;
  bool err = false;

  @override
  Widget build(BuildContext context) {
    double scrwidth = MediaQuery.of(context).size.width;
    double scrheight = MediaQuery.of(context).size.height;
    KeepProvider prvd = Provider.of<KeepProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          style: ButtonStyle(
              overlayColor:
                  WidgetStatePropertyAll<Color>(Colors.transparent)),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            EvaIcons.arrowIosBack,
            size: (7.5 * scrwidth) / 100,
            color: Theme.of(context).colorScheme.surface == Color(0xfffffbfe)
                ? Colors.black87
                : Colors.white70,
          ),
        ),
      ),
      body: Container(
        width: scrwidth,
        height: scrheight,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
              (5.5555 * scrwidth) / 100,
              (3.90625 * scrheight) / 100,
              (5.5555 * scrwidth) / 100,
              (3.125 * scrheight) / 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Animate(
                effects: [
                  FadeEffect(duration: 700.ms),
                  SlideEffect(duration: 700.ms)
                ],
                child: Container(
                  width: (19.4444 * scrwidth) / 100,
                  height: (10.9375 * scrheight) / 100,
                  child: Image(
                    image: AssetImage('media/Vector.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Animate(
                effects: [
                  FadeEffect(delay: 100.ms, duration: 700.ms),
                  SlideEffect(delay: 100.ms, duration: 700.ms)
                ],
                child: Padding(
                  padding: EdgeInsets.only(
                      top: (3.125 * scrheight) / 100,
                      bottom: (3.125 * scrheight) / 100),
                  child: Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: (8.8888 * scrwidth) / 100,
                      fontFamily: 'Kunika',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Animate(
                      effects: [
                        FadeEffect(delay: 200.ms, duration: 500.ms),
                        SlideEffect(delay: 200.ms, duration: 500.ms)
                      ],
                      child: SizedBox(
                        height: (7.8125 * scrheight) / 100,
                        width: (13.8888 * scrwidth) / 100,
                        child: Center(
                          child: TextFormField(
                            controller: inputcnt,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: (5.5556 * scrwidth) / 100,
                                fontFamily: 'Kunika'),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: prvd.first,
                                    width: (0.3125 * scrheight) / 100),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: EdgeInsets.all(0),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: err
                                        ? Colors.red
                                        : (Theme.of(context)
                                                    .colorScheme
                                                    .surface ==
                                                Color(0xfffffbfe)
                                            ? Colors.black87
                                            : Colors.white70),
                                    width: (0.3125 * scrheight) / 100),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            cursorColor:
                                Theme.of(context).colorScheme.surface ==
                                        Color(0xfffffbfe)
                                    ? Colors.black87
                                    : Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    Animate(
                      effects: [
                        FadeEffect(delay: 300.ms, duration: 500.ms),
                        SlideEffect(delay: 400.ms, duration: 500.ms)
                      ],
                      child: SizedBox(
                        height: (7.8125 * scrheight) / 100,
                        width: (13.8888 * scrwidth) / 100,
                        child: Center(
                          child: TextFormField(
                            controller: inputcnt1,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: (5.5556 * scrwidth) / 100,
                                fontFamily: 'Kunika'),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: prvd.first,
                                      width: (0.3125 * scrheight) / 100),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: EdgeInsets.all(0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: err
                                          ? Colors.red
                                          : (Theme.of(context)
                                                      .colorScheme
                                                      .surface ==
                                                  Color(0xfffffbfe)
                                              ? Colors.black87
                                              : Colors.white70),
                                      width: (0.3125 * scrheight) / 100),
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            cursorColor:
                                Theme.of(context).colorScheme.surface ==
                                        Color(0xfffffbfe)
                                    ? Colors.black87
                                    : Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    Animate(
                      effects: [
                        FadeEffect(delay: 400.ms, duration: 500.ms),
                        SlideEffect(delay: 400.ms, duration: 500.ms)
                      ],
                      child: SizedBox(
                        height: (7.8125 * scrheight) / 100,
                        width: (13.8888 * scrwidth) / 100,
                        child: Center(
                          child: TextFormField(
                            controller: inputcnt2,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: (5.5556 * scrwidth) / 100,
                                fontFamily: 'Kunika'),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: prvd.first,
                                      width: (0.3125 * scrheight) / 100),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: EdgeInsets.all(0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: err
                                          ? Colors.red
                                          : (Theme.of(context)
                                                      .colorScheme
                                                      .surface ==
                                                  Color(0xfffffbfe)
                                              ? Colors.black87
                                              : Colors.white70),
                                      width: (0.3125 * scrheight) / 100),
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            cursorColor:
                                Theme.of(context).colorScheme.surface ==
                                        Color(0xfffffbfe)
                                    ? Colors.black87
                                    : Colors.white70,
                          ),
                        ),
                      ),
                    ),
                    Animate(
                      effects: [
                        FadeEffect(delay: 500.ms, duration: 500.ms),
                        SlideEffect(delay: 500.ms, duration: 500.ms)
                      ],
                      child: SizedBox(
                        height: (7.8125 * scrheight) / 100,
                        width: (13.8888 * scrwidth) / 100,
                        child: Center(
                          child: TextFormField(
                            controller: inputcnt3,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: (5.5556 * scrwidth) / 100,
                                fontFamily: 'Kunika'),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: prvd.first,
                                      width: (0.3125 * scrheight) / 100),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: EdgeInsets.all(0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: err
                                          ? Colors.red
                                          : (Theme.of(context)
                                                      .colorScheme
                                                      .surface ==
                                                  Color(0xfffffbfe)
                                              ? Colors.black87
                                              : Colors.white70),
                                      width: (0.3125 * scrheight) / 100),
                                  borderRadius: BorderRadius.circular(15),
                                )),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            cursorColor:
                                Theme.of(context).colorScheme.surface ==
                                        Color(0xfffffbfe)
                                    ? Colors.black87
                                    : Colors.white70,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Animate(
                  effects: [
                    FadeEffect(delay: 00.ms, duration: 700.ms),
                    SlideEffect(delay: 00.ms, duration: 700.ms)
                  ],
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: (3.125 * scrheight) / 100,
                    ),
                    child: Text(
                      'Resend code after $min:$sec',
                      style: TextStyle(
                        fontFamily: 'Kunika',
                        fontSize: (5.5556 * scrwidth) / 100,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.surface ==
                                Color(0xfffffbfe)
                            ? Colors.black87
                            : Colors.white70,
                      ),
                    ),
                  )),
              Animate(
                  effects: [
                    FadeEffect(delay: 700.ms, duration: 700.ms),
                    SlideEffect(delay: 700.ms, duration: 700.ms)
                  ],
                  child: AnimatedBuilder(
                    animation: _scalanimationcnt,
                    builder: (context, child) => Transform.scale(
                      scale: _scale.value,
                      child: Container(
                        margin: EdgeInsets.only(top: (3.125 * scrheight) / 100),
                        width: (41.6666 * scrwidth) / 100,
                        height: (7.8125 * scrheight) / 100,
                        decoration: BoxDecoration(
                          color: prvd.first,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 10,
                                spreadRadius: 1),
                          ],
                        ),
                        child: TextButton(
                          focusNode: bntfocs,
                          style: ButtonStyle(
                              overlayColor: WidgetStatePropertyAll<Color>(
                                  Colors.transparent)),
                          onPressed: () {
                            if (!inputcnt.text.isEmpty &&
                                (inputcnt.text +
                                        inputcnt1.text +
                                        inputcnt2.text +
                                        inputcnt3.text) ==
                                    '1234') {
                              setState(() {
                                slid = !slid;
                              });
                              if (!pass!) {
                                Future.delayed(Duration(milliseconds: 1550),
                                    () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChoosePge()));
                                  setState(() {
                                    slid = !slid;
                                  });
                                });
                                time?.cancel();
                              } else {
                                Future.delayed(Duration(milliseconds: 1550),
                                    () {
                                  setState(() {
                                    slid = !slid;
                                  });
                                });
                                time?.cancel();
                              }
                            } else {
                              setState(() {
                                slid = !slid;
                              });
                              Future.delayed(Duration(milliseconds: 1000), () {
                                setState(() {
                                  err = !err;
                                });
                                Vibration.vibrate(duration: 200);
                                setState(() {
                                  slid = !slid;
                                });
                              });
                            }
                            Future.delayed(Duration(milliseconds: 500), () {
                              if (!(!inputcnt.text.isEmpty &&
                                  (inputcnt.text +
                                          inputcnt1.text +
                                          inputcnt2.text +
                                          inputcnt3.text) ==
                                      '1234')) {
                                setState(() {
                                  err = !err;
                                });
                              }
                            });
                          },
                          child: Animate(
                              effects: [
                                FadeEffect(delay: 800.ms, duration: 700.ms),
                                SlideEffect(
                                    delay: 800.ms,
                                    duration: 700.ms,
                                    begin: Offset(0, 1))
                              ],
                              child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),
                                  transitionBuilder: (child, animation) {
                                    return ScaleTransition(
                                      scale: animation
                                          .drive(Tween(begin: 0, end: 1)),
                                      child: child,
                                    );
                                  },
                                  child: slid
                                      ? LoadingAnimationWidget.fourRotatingDots(
                                          color: Theme.of(context)
                                                      .colorScheme
                                                      .surface ==
                                                  Color(0xfffffbfe)
                                              ? Colors.white
                                              : Colors.black87,
                                          size: (8.3333 * scrwidth) / 100)
                                      : Text(
                                          'Verify',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Kunika',
                                            fontSize:
                                                (5.8333 * scrwidth) / 100,
                                            color: Theme.of(context)
                                                        .colorScheme
                                                        .surface ==
                                                    Color(0xfffffbfe)
                                                ? Colors.white
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                          ),
                                        ))),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void StartTime() {
    time = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (sec > 0) {
          sec--;
        } else if (min == 1 && sec == 0) {
          min--;
          sec = 59;
        } else {
          res = true;
        }
      });
      Resend();
    });
  }

  void Resend() {
    if (res) {
      Navigator.pop(context);
    }
  }
}
//end verification
