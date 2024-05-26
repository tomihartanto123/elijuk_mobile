// import 'package:e_lijuk/pages/login_screen.dart';
import 'package:d_method/d_method.dart';
import 'package:e_lijuk/model/user_services.dart';
import 'package:e_lijuk/pages/login_screen_two.dart';
import 'package:e_lijuk/pages/test.dart';
import 'package:e_lijuk/widget/style.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<Offset>(
      begin: Offset(0, -1.0),
      end: Offset(0, 0),
    ).animate(_animationController);

    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      bool isLogin = await PasarAjaUserService.isLoggedIn();
      String email = await PasarAjaUserService.getEmailLogged();

      DMethod.log('is login : $isLogin');
      DMethod.log('email : $email');

      if (isLogin) {
        Future.delayed(Duration(seconds: 2), () {
          // Menggunakan Navigator untuk pindah ke halaman LoginPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TestPage(),
            ),
          );
        });
      } else {
        Future.delayed(Duration(seconds: 2), () {
          // Menggunakan Navigator untuk pindah ke halaman LoginPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.hijau100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/logo.png',
              width: 500,
              height: 500,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
