import 'package:currency_converter/modules/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:splash_view/source/presentation/pages/splash_view.dart';
import 'package:splash_view/source/presentation/widgets/done.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.green[300],
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return SplashView(
      // logo: const FlutterLogo(),
      loadingIndicator: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SpinKitPulse(
          color: Colors.white,
          size: 40,
        ),
      ),
      backgroundColor: Colors.green[300],
      bottomLoading: false,
      showStatusBar: true,
      title: Image.asset(
        'lib/assets/change.png',
        width: 100,
        height: 100,
      ),

      // gradient: const LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //     colors: <Color>[Colors.green, Colors.blue]),
      done: Done(
        Home(),
        animationDuration: const Duration(seconds: 2),
        // curve: Curves.easeInOut,
      ),
    );
  }
}
