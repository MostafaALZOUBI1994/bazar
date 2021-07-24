import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/data/providers/auth_provider.dart';
import 'package:bazarcom/app/data/repositories/auth_repositoy.dart';
import 'package:bazarcom/app/modules/controllers/auth_controller.dart';
import 'package:bazarcom/app/modules/screens/login.dart';
import 'package:bazarcom/app/modules/screens/login_option.dart';
import 'package:bazarcom/app/modules/screens/signup.dart';
import 'package:bazarcom/app/modules/screens/signup_option.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class SingupLoginPage extends StatefulWidget {
  @override
  _SingupLoginPageState createState() => _SingupLoginPageState();
}

class _SingupLoginPageState extends State<SingupLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  bool login = true;
  final AuthRepository authRepository = AuthRepository(
    apiClient: AuthApiClient(),
  );
  @override
  Widget build(BuildContext context) {
    final AuthController authController =
        Get.put(AuthController(authRepository));
    return Scaffold(
      backgroundColor: kColorOfCanvas,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  login = true;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
                height: login ? deviceHieght * 0.6 : deviceHieght * 0.4,
                child: CustomPaint(
                  painter: CurvePainter(login),
                  child: Container(
                    padding: EdgeInsets.only(bottom: login ? 0 : 55),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          child: login
                              ? Login(
                                  authController: authController,
                                  emailController: emailController,
                                  passwordController: passwordController,
                                )
                              : LoginOption(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  login = false;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
                height: login ? deviceHieght * 0.4 : deviceHieght * 0.6,
                child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(top: login ? 55 : 0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          child: !login
                              ? SignUp(
                                  authController: authController,
                                  emailController: emailController,
                                  passwordController: passwordController,
                                  phoneNumberController: phoneNumberController,
                                )
                              : SignUpOption(),
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = kColorOfYellowRect;
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.5,
        outterCurve ? size.height + 110 : size.height - 110,
        size.width,
        size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
